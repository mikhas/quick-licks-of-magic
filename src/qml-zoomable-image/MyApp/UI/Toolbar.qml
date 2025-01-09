import QtQuick
import QtQuick.Controls


Control {
    id: root

    required property Action fitToWidth
    required property Action fitToHeight
    required property Action fitToSize
    required property Action enableLogScaling

    leftPadding: 16
    topPadding: 8
    rightPadding: 16
    bottomPadding: 8
    background: Rectangle { color: "lightgrey" }
    contentItem: Row {
        spacing: 8

        Button { action: root.fitToWidth }
        Button { action: root.fitToHeight }
        Button { action: root.fitToSize }
        Switch { action: root.enableLogScaling }
    }
}

