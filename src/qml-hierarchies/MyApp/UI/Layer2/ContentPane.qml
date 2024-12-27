import QtQuick
import QtQuick.Controls
import MyApp.UI.Layer3 as L3


Control {
    id: root

    contentItem: SplitView {
        handle: Rectangle {
            id: handle

            implicitWidth: 2
            implicitHeight: 2
            color: {
                if (SplitHandle.pressed) { return "#393939" }
                if (SplitHandle.hovered) { return "grey" }
                return "#e2e2e2"
            }
            containmentMask: Item {
                x: (handle.width - this.width) / 2
                width: 16
                height: handle.height
            }
        }
        Column {
            SplitView.preferredWidth: root.contentItem.width * .35

            L3.InboxView {
                id: inbox

                width: parent.width
                height: parent.height - parent.spacing - status.height
            }
            L3.InboxStatus {
                id: status

                width: parent.width
                messageIndex: inbox.currentIndex
                messageCount: inbox.count
            }
        }
        L3.MessageView {
            model: inbox.model
            currentIndex: inbox.currentIndex
        }
    }
}
