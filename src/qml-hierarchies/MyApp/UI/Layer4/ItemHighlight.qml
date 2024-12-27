import QtQuick


Rectangle {
    id: root

    color: "#f6f6f6"
    implicitWidth: 240
    implicitHeight: 48

    Rectangle {
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
        width: 2
        color: "black"
    }
}
