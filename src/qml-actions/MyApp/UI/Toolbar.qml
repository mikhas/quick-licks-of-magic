import QtQuick
import QtQuick.Controls


// UI.Toolbar
Container {
    id: root

    required property Action browse
    required property Action viewDetails
    required property Action viewSettings

    leftPadding: 16
    topPadding: 8
    rightPadding: 16
    bottomPadding: 8
    background: Rectangle { color: "lightgrey" }
    contentItem: Row { spacing: 8 }

    Button { action: root.browse }
    Button { action: root.viewDetails }
    Button { action: root.viewSettings }
}
