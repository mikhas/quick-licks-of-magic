import QtQuick
import QtQuick.Controls


Flickable {
    id: root

    required property var payload

    clip: true
    contentWidth: content.width
    contentHeight: content.height
    boundsMovement: Flickable.StopAtBounds
    ScrollBar.horizontal: ScrollBar {}
    ScrollBar.vertical: ScrollBar {}

    Text {
        id: content

        text: root.payload
        width: root.width - root.leftMargin - root.rightMargin
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
    }
}
