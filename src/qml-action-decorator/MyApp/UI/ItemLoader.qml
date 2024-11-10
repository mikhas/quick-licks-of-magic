import QtQuick
import QtQuick.Controls


Control {
    id: root

    function load(item) {
        root.contentItem.visible = false;
        root.background.color = item;
    }

    function unload() {
        root.contentItem.visible = true;
        root.background.color = "transparent";
    }

    leftInset: 6
    topInset: 6
    rightInset: 6
    bottomInset: 6
    background: Rectangle { color: "transparent" }
    contentItem: Item {
        Text {
            anchors.centerIn: parent
            text: "No item loaded"
        }
    }
}
