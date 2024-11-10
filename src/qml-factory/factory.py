from PySide6.QtCore import Property, QObject, Qt, QUrl, Signal, Slot
from PySide6.QtQml import QmlElement, QmlSingleton

QML_IMPORT_NAME = "MyApp.Tools"
QML_IMPORT_MAJOR_VERSION = 1


@QmlElement
class Derived(QObject):
    iconSourceChanged = Signal(QUrl)
    amountChanged = Signal(int)

    def __init__(self, icon_source: QUrl, amount: int, parent: QObject = None):
        super().__init__(parent)
        self._icon_source = icon_source
        self._amount = amount

    @Property(QUrl, notify=iconSourceChanged)
    def iconSource(self):
        return self._icon_source

    @Property(int, notify=amountChanged)
    def amount(self):
        return self._amount


@QmlElement
@QmlSingleton
class Factory(QObject):
    # By introducing optional parameters, we've created an overloaded method
    # issue that the QML engine cannot resolve unless we define `@Slot`
    # decorators for each case.
    @Slot(QUrl, int, result=Derived)
    @Slot(QUrl, int, QObject, result=Derived)
    def makeDerived(
        self, icon_source: QUrl, amount: int, parent: QObject = None
    ) -> Derived:
        # We need to decide on an owner, not just for the QML engine.
        # Otherwise, we risk that the instance we want to return will
        # immediately be cleaned up by Python's garbage collector.
        owner = parent if parent else self
        return Derived(icon_source, amount, owner)
