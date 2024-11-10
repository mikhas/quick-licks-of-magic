import QtQuick
import QtQuick.Controls


ItemDelegate {
    id: root

    required property int index
    required property color modelData
    readonly property bool flipped: this.flippedAngle < -90
    property real flippedAngle: this.action.checked ? -180 : 0

    leftInset: 6
    topInset: 6
    rightInset: 6
    bottomInset: 6
    background: Rectangle {
        color: root.flipped ? "white" : root.modelData
        transform: Rotation {
            origin.x: width / 2 - 6; origin.y: height / 2; axis { x: 0; y: 1; z: 0 }
            angle: root.flippedAngle
        }

        Behavior on color { ColorAnimation { duration: 400 }}
        Rectangle {
            color: root.modelData
            anchors {
                right: parent.right
                rightMargin: 2
                top: parent.top
                bottom: parent.bottom
            }
            width: root.flippedAngle === 0 ? parent.width : 40
            visible: root.flipped

            Behavior on width { SmoothedAnimation { duration: 400 }}
        }
        Rectangle {
            color: "grey"
            anchors {
                right: parent.right
                top: parent.top
                bottom: parent.bottom
            }
            width: 2
        }
    }

    Behavior on flippedAngle { SmoothedAnimation {
        id: flipAnimation; duration: 400
    }}
}

