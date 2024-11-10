from PySide6.QtCore import QAbstractItemModel, QModelIndex, QObject, Qt, Slot
from PySide6.QtQml import QmlElement, QmlSingleton

QML_IMPORT_NAME = "MyApp.Backend"
QML_IMPORT_MAJOR_VERSION = 1


@QmlElement
class ItemsModel(QAbstractItemModel):
    def __init__(self, data: list, parent: QObject = None):
        QAbstractItemModel.__init__(self, parent)
        self._data = data

    @Slot(result=int)
    def rowCount(self, parent: QModelIndex):
        return len(self._data)

    @Slot(result=int)
    def columnCount(self, parent: QModelIndex):
        return 1

    @Slot(int, result=str)
    def get(self, index: int):
        try:
            return self._data[index]
        except Exception:
            return None

    @Slot(QModelIndex, int, result=str)
    def data(self, index: QModelIndex, role: int):
        try:
            return self._data[index.row()]
        except Exception:
            return None

    @Slot(str, result=bool)
    def remove(self, item: str):
        try:
            found = self._data.index(item)
            self.beginRemoveRows(QModelIndex(), found, found)
            del self._data[found]
            self.endRemoveRows()
        except Exception:
            return False


@QmlElement
@QmlSingleton
class Factory(QObject):
    @Slot(result=ItemsModel)
    @Slot(QObject, result=ItemsModel)
    def makeStandardItemsModel(self, owner: QObject = None):
        # fmt: off
        data = [
            "aliceblue", "antiquewhite", "aqua", "aquamarine", "azure",
            "beige", "bisque", "black", "blanchedalmond", "blue", "blueviolet",
            "brown", "burlywood", "cadetblue", "chartreuse", "chocolate",
            "coral", "cornflowerblue", "cornsilk", "crimson", "cyan",
            "darkblue", "darkcyan", "darkgoldenrod", "darkgray", "darkgreen",
            "darkgrey", "darkkhaki", "darkmagenta", "darkolivegreen",
            "darkorange", "darkorchid", "darkred", "darksalmon",
            "darkseagreen", "darkslateblue", "darkslategray", "darkslategrey",
            "darkturquoise", "darkviolet", "deeppink", "deepskyblue",
            "dimgray", "dimgrey", "dodgerblue", "firebrick", "floralwhite",
            "forestgreen", "fuchsia", "gainsboro", "ghostwhite", "gold",
            "goldenrod", "gray", "grey", "green", "greenyellow", "honeydew",
            "hotpink", "indianred", "indigo", "ivory", "khaki", "lavender",
            "lavenderblush", "lawngreen", "lemonchiffon", "lightblue",
            "lightcoral", "lightcyan", "lightgoldenrodyellow", "lightgray",
            "lightgreen", "lightgrey", "lightpink", "lightsalmon",
            "lightseagreen", "lightskyblue", "lightslategray",
            "lightslategrey", "lightsteelblue", "lightyellow", "lime",
            "limegreen", "linen", "magenta", "maroon", "mediumaquamarine",
            "mediumblue", "mediumorchid", "mediumpurple", "mediumseagreen",
            "mediumslateblue", "mediumspringgreen", "mediumturquoise",
            "mediumvioletred", "midnightblue", "mintcream", "mistyrose",
            "moccasin", "navajowhite", "navy", "oldlace", "olive", "olivedrab",
            "orange", "orangered", "orchid", "palegoldenrod", "palegreen",
            "paleturquoise", "palevioletred", "papayawhip", "peachpuff",
            "peru", "pink", "plum", "powderblue", "purple", "red", "rosybrown",
            "royalblue", "saddlebrown", "salmon", "sandybrown", "seagreen",
            "seashell", "sienna", "silver", "skyblue", "slateblue",
            "slategray", "slategrey", "snow", "springgreen", "steelblue",
            "tan", "teal", "thistle", "tomato", "turquoise", "violet", "wheat",
            "white", "whitesmoke", "yellow", "yellowgreen",
        ]
        # fmt: on
        _owner = owner if owner else self
        return ItemsModel(data=data, parent=_owner)
