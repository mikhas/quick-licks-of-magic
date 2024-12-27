import QtQuick
import QtQuick.Controls
import MyApp.Backend as BE
import MyApp.UI.Layer4 as L4


Control {
    id: root

    readonly property alias model: view.model
    readonly property alias currentIndex: view.currentIndex
    readonly property alias count: view.count

    padding: 8
    contentItem: ListView {
        id: view

        model: BE.InboxModel { directory: "file:assets/inbox" }
        clip: true
        focus: true
        highlight: L4.ItemHighlight {}
        highlightMoveDuration: 120
        delegate: ItemDelegate {
            required property int index
            required property var modelData

            width: view.width
            action: Action {
                onTriggered: {
                    view.currentIndex = index;
                    // Allow the user to refocus our ListView by clicking on a delegate.
                    // Focus can be lost through tab navigation, for instance.
                    view.focus = true;
                }
            }
            contentItem: L4.MessageHeading {
                message: parent.modelData
                bold: parent.ListView.isCurrentItem
            }
        }
        ScrollBar.vertical: ScrollBar {}
    }
}
