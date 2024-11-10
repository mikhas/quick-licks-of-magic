import QtQuick
import QtQuick.Controls
import MyApp.UI as UI
import MyApp.Tools as Tools


// UI.ItemsView
GridView {
    id: root

    required property Action loadItem
    required property Action removeItem
    readonly property var item: root.model.get(root.currentIndex)

    clip: true
    cellWidth: {
        const cols = Math.floor(root.width / 240);
        return root.width / cols;
    }
    cellHeight: 120
    highlight: Rectangle {
        border {
            width: 6
            color: "gold"
        }
    }
    removeDisplaced: Transition {
        SmoothedAnimation {
            properties: "x,y"
            duration: 400
        }
    }
    delegate: UI.FancyTile {
        id: tile

        modelData: root.model.get(tile.index)
        width: root.cellWidth
        height: root.cellHeight
        action: Action {
            checkable: true
            onTriggered: root.currentIndex = tile.index
        }

        Row {
            anchors.centerIn: parent
            spacing: 8
            visible: tile.flipped

            // A natural 3rd action would be `editItem`
            Button {
                action: Tools.ActionDecorator {
                    action: root.loadItem
                    onTriggered: root.currentIndex = tile.index
                }
            }
            Button {
                action: Tools.ActionDecorator {
                    action: root.removeItem
                    onTriggered: root.currentIndex = tile.index
                }
            }
        }
    }

    Connections {
        target: root.model
        function onRowsRemoved(_, from, to) {
            // GridView does not move currentIndex when an QAbstractItemModel
            // removes items ...
            root.currentIndex = root.currentIndex + (from - to + 1);
        }
    }
}
