import signal
from os import fspath
from sys import argv, exit
from pathlib import Path

from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import Qt
from PySide6.QtGui import QGuiApplication
from PySide6.QtQuickControls2 import QQuickStyle

from inbox import InboxModel


def run():
    # Shuts down the app when pressing Ctrl-C in the terminal.
    # For proper handling, check matplotlib's `_allow_interrupt(...)`
    # implementation.
    signal.signal(signal.SIGINT, signal.SIG_DFL)

    # We need to set the style early, or else the engine complains.
    QQuickStyle.setStyle("Universal")

    # Also parses Qt-specific command line arguments.
    app = QGuiApplication(argv)
    # The engine is responsible for executing QML code.
    engine = QQmlApplicationEngine()
    engine.objectCreationFailed.connect(app.quit, Qt.QueuedConnection)
    # Search for QML modules in the same directory as our `main.py`.
    app_path = Path(__file__).parent
    engine.addImportPath(fspath(app_path))
    # Set base path for assets such as icons using the "file:" protocol.
    engine.setExtraFileSelectors(app_path.as_uri())
    # The module name "MyApp.UI" is translated into a path.
    # "Main" is defined in "MyApp/UI/Main.qml" and will be loaded as the
    # engine's root element.
    engine.loadFromModule("MyApp.UI", "Main")

    # Yield control from the Python interpreter to the Qt event loop.
    return app.exec()


if __name__ == "__main__":
    exit(run())
