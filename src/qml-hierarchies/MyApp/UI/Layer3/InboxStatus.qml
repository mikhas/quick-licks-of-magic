import QtQuick
import QtQuick.Controls


Control {
    id: root

    required property int messageIndex
    required property int messageCount

    background: Rectangle {
        Rectangle {
            anchors {
                left: parent.left
                top: parent.top
                right: parent.right
            }
            height: 1
            color: "lightgrey"
        }
    }
    horizontalPadding: 16
    verticalPadding: 8
    contentItem: Text {
        text: `Message: ${root.messageIndex + 1}/${root.messageCount}`
        elide: Text.ElideRight
    }
}
