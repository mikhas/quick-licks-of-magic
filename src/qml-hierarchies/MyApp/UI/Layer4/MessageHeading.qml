import QtQuick


Column {
    id: root

    required property var message
    required property bool bold
    property alias subjectFontSize: subject.font.pointSize
    property real subjectWeigth: 0.65

    Row {
        width: root.width
        spacing: 16

        Text {
            id: subject

            text: root.message.subject
            width: parent.width * root.subjectWeigth - parent.spacing / 2
            font.bold: root.bold
            elide: Text.ElideRight
        }
        Text {
            text: root.message.date
            width: parent.width * (1 - root.subjectWeigth) - parent.spacing / 2
            font {
                bold: root.bold
                pointSize: 11
            }
            elide: Text.ElideRight
        }
    }
    Text {
        text: `From: ${root.message.from}`
        width: root.width
        font.bold: root.bold
        elide: Text.ElideRight
    }
}
