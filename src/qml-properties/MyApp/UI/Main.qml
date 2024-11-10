import QtQuick
import QtQuick.Controls


ApplicationWindow {
    id: root

    title: "Properties 101"
    width: 640
    height: 400
    visible: true

    Rectangle {
        anchors.fill: parent
        color: "gold"

        TapHandler { id: tapHandler }
        Binding on color {
            when: tapHandler.tapCount === 2
            value: "teal"
        }
        Binding on color {
            when: tapHandler.tapCount === 3
            value: "hotpink"
        }
        Binding on color {
            when: tapHandler.tapCount > 3
            value: "honeydew"
        }
        Text {
            anchors.centerIn: parent
            text: `tap count: ${tapHandler.tapCount}`
        }
    }
}
