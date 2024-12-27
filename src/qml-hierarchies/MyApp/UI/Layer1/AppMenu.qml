import QtQuick
import QtQuick.Controls


MenuBar {
    id: root

    background: Rectangle {
        color: "#e6e6e6"

        Rectangle {
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            height: 1
            color: "#d3d3d3"
        }
    }

    Menu {
        title: "Edit"

        Action { text: "Undo" }
        Action { text: "Redo" }
    }
    Menu {
        title: "View"

        Action { text: "Toolbars" }
        Action { text: "Sidebar" }
    }
    Menu {
        title: "Help"

        Action { text: "Get Help" }
        Action { text: "About" }
    }
}
