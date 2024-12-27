import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import MyApp.Backend as BE
import MyApp.UI.Layer4 as L4


Control {
    id: root

    required property BE.InboxModel model
    required property int currentIndex

    padding: 8
    contentItem: ColumnLayout {
        id: view

        readonly property var message: root.model.get(root.currentIndex)

        spacing: 16

        Control {
            Layout.fillWidth: true
            padding: 8
            background: Rectangle { color: "#f6f6f6" }
            contentItem: L4.MessageHeading {
                message: view.message
                bold: true
                subjectFontSize: 18
                subjectWeigth: .75
            }
        }
        L4.FlickableMessagePayload {
            Layout.fillWidth: true
            Layout.fillHeight: true
            payload: view.message.payload
        }
    }
}
