import QtQuick
import QtQuick.Controls


ToolBar {
    id: root

    readonly property Action showComposeView: Action {
        icon.source: "file:assets/envelope-paper-fill.svg"
        onTriggered: console.log("showComposeView action triggered...")
    }
    readonly property Action showCalendarView: Action {
        icon.source: "file:assets/calendar-date-fill.svg"
        onTriggered: console.log("showCalendarView triggered...")
    }
    readonly property Action showCollaborationsView: Action {
        icon.source: "file:assets/people-fill.svg"
        onTriggered: console.log("showTeamsView action triggered...")
    }
    readonly property Action showTodoView: Action {
        icon.source: "file:assets/check-all.svg"
        onTriggered: console.log("showTodoView action triggered...")
    }

    background: Rectangle { color: "#e6e6e6" }
    contentItem: Column { spacing: 8 }

    Repeater {
        model: [root.showComposeView, root.showCalendarView, root.showCollaborationsView, root.showTodoView]
        delegate: ToolButton {
            width: 48
            action: modelData
            icon.color: "teal"
        }
    }
}
