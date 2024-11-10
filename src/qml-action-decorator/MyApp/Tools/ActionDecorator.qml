import QtQuick
import QtQuick.Controls

// Tools.ActionDecorator
Action {
    id: root

    required property Action action

    checkable: root.action.checkable
    checked: root.action.checked
    enabled: root.action.enabled
    icon: root.action.icon
    shortcut: root.action.shortcut
    text: root.action.text
    onTriggered: Qt.callLater(root.action.trigger)
}
