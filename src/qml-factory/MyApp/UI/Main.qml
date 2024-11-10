import QtQuick
import QtQuick.Controls
import MyApp.Tools as Tools


ApplicationWindow {
    id: root

    readonly property Tools.Derived derived: {
        const url = Qt.resolvedUrl("path/to/icon.png");
        return Tools.Factory.makeDerived(url, 5);
    }

    title: "Overcoming Trivially Constructable Types"
    width: 1280
    height: 800
    visible: true

    Flow {
        anchors.centerIn: parent
        flow: Flow.TopToBottom

        Text { text: `root.derived.amount: ${root.derived.amount}` }
        Text { text: `root.derived.iconSource: ${root.derived.iconSource}` }
    }
}
