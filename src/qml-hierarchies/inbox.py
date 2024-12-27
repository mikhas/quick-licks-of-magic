import re
import email
from email.message import Message
from email.parser import BytesParser
from pathlib import Path

# ProcessPoolExecutor is faster than ThreadPoolExecutor here
from concurrent.futures import ProcessPoolExecutor

# Splitting up QtCore imports in two lines still saves lines, compared to black
from PySide6.QtCore import Property, Signal, Slot, Qt, QObject, QByteArray
from PySide6.QtCore import QAbstractItemModel, QModelIndex, QTimer, QUrl
from PySide6.QtQml import QmlElement


QML_IMPORT_NAME = "MyApp.Backend"
QML_IMPORT_MAJOR_VERSION = 1


def chunk(collection, size):
    for i in range(0, len(collection), size):
        yield collection[i : i + size]


def decoded_items(collection):
    return [(key, value.decode()) for key, value in collection.items()]


def parse_emails(file_names: list[Path]):
    result = []
    email_parser = BytesParser()

    for fn in file_names:
        with open(fn, "rb") as fp:
            email = email_parser.parse(fp)
            if "spamassassin.taint.org" not in str(email.get("from")):
                result.append(email)

    return result


def make_urls_stripper():
    compiled_re = re.compile(r"^[^:]*:\/\/.*[\r\n]*", flags=re.MULTILINE)

    def strip(text: str, replacement: str = ""):
        return re.sub(compiled_re, replacement, text)

    return strip


def extract_payload(message: Message, strip_urls_cb):
    payload = message.get_payload()
    payload_parts = payload if isinstance(payload, list) else [payload]
    result = [
        strip_urls_cb(part.as_string() if isinstance(part, Message) else part)
        for part in payload_parts
    ]
    return "\n".join(result)


@QmlElement
class InboxModel(QAbstractItemModel):
    def __init__(self, parent: QObject = None):
        QAbstractItemModel.__init__(self, parent)
        self._pending_messages = None
        self._messages = []
        self._directory = None
        self.strip_urls = make_urls_stripper()

    def parent(self, index: QModelIndex):
        return QModelIndex()

    def index(self, row: int, column: int, parent: QModelIndex):
        return self.createIndex(row, column)

    def roleNames(self) -> dict[int, QByteArray]:
        return {
            index: name.encode()
            for index, name in enumerate(["subject", "date", "from", "to", "payload"])
        }

    def flags(self, index: QModelIndex):
        return Qt.ItemIsEnabled | Qt.ItemIsSelectable

    def append_parsed_messages_from_task_queue(self):
        try:
            begin = len(self._messages)
            next_messages = next(self._pending_messages)
            end = begin + len(next_messages)

            self.beginInsertRows(QModelIndex(), begin, end - 1)
            self._messages.extend(next_messages)
            self.endInsertRows()

            QTimer.singleShot(0, self.append_parsed_messages_from_task_queue)
        except StopIteration:
            pass

    @Property(QUrl)
    def directory(self):
        return self._directory

    @directory.setter
    def directory(self, url: QUrl):
        if self._directory == url:
            return

        self._directory = url
        app_path = Path(__file__).parent
        base_url = QUrl.fromLocalFile(app_path)
        path = app_path / Path(base_url.resolved(self._directory).toLocalFile())

        if not path.is_dir():
            return

        with ProcessPoolExecutor(max_workers=8) as executor:
            files = chunk([fn for fn in path.iterdir()], 64)
            self._pending_messages = executor.map(parse_emails, files)

        self.append_parsed_messages_from_task_queue()

    @Slot(result=int)
    def rowCount(self, parent: QModelIndex):
        return len(self._messages)

    @Slot(QModelIndex, int, result=float)
    def data(self, index: QModelIndex, role: int):
        message = self._messages[index.row()]

        return (
            extract_payload(message, self.strip_urls)
            if self.roleNames().get(role).decode() == "payload"
            else message.get(["subject", "date", "from", "to"][role])
        )

    @Slot(int, result=dict)
    def get(self, row: int):
        index = self.index(row, 0, QModelIndex())
        fetch_data = lambda index, role: self.data(index, role)
        if row < 0 or row >= len(self._messages):
            fetch_data = lambda x, y: ""

        return {
            name: fetch_data(index, role)
            for role, name in decoded_items(self.roleNames())
        }
