import QtQuick


// UI.ResizeHandle
Item {
    id: root

    property int orientation: Qt.Horizontal
    property color color: "lightgrey"
    readonly property real leftPosition: positioner.x + positioner.width / 2
    readonly property real topPosition: positioner.y + positioner.height / 2
    readonly property real rightPosition: -(positioner.x - positioner.width / 2)
    readonly property real bottomPosition: -(positioner.y - positioner.height / 2)
    readonly property bool horizontal: root.orientation === Qt.Horizontal
    readonly property bool vertical: root.orientation === Qt.Vertical
    readonly property real initialPadding: root.anchors.margins
    readonly property alias active: drag.active

    width: root.horizontal ? 12 : undefined
    height: root.vertical ? 12 : undefined
    x: root.horizontal ? root.initialPadding : 0
    y: root.vertical ? root.initialPadding : 0
    z: 1

    Item {
        id: positioner

        readonly property bool isLeftAligned: root.x < (root.parent?.width ?? 0) / 2
        readonly property bool isTopAligned: root.y < (root.parent?.height ?? 0) / 2

        // Anchors can be used to limit degrees of freedom of a DragHandler
        anchors {
            horizontalCenter: root.vertical ? parent.horizontalCenter : undefined
            verticalCenter: root.horizontal ? parent.verticalCenter : undefined
        }

        x: 0
        y: 0
        width: parent.width
        height: parent.height

        Binding on x {
            when: root.horizontal
            value: positioner.isLeftAligned ? -positioner.width / 2 : positioner.width / 2
        }
        Binding on y {
            when: root.vertical
            value: positioner.isTopAligned ? -positioner.height / 2 : positioner.height / 2
        }
        Rectangle {
            visible: drag.active || hover.hovered
            color: root.color
            anchors {
                left: root.vertical ? parent.left : undefined
                top: root.horizontal ? parent.top : undefined
                right: root.vertical ? parent.right : undefined
                bottom: root.horizontal ? parent.bottom : undefined
                horizontalCenter: root.horizontal ? parent.horizontalCenter : undefined
                verticalCenter: root.vertical ? parent.verticalCenter : undefined
            }
            width: root.horizontalCenter ? 4 : undefined
            height: root.verticalCenter ? 4 : undefined
        }
        DragHandler {
            id: drag

            cursorShape: root.horizontal ? Qt.SplitHCursor : Qt.SplitVCursor
        }
        HoverHandler {
            id: hover

            cursorShape: root.horizontal ? Qt.SplitHCursor : Qt.SplitVCursor
        }
    }
}
