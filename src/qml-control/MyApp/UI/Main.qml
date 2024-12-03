import QtQuick
import QtQuick.Controls
import MyApp.UI as UI


ApplicationWindow {
    id: root

    title: "Control, background & contentItem"
    width: 768
    height: 540
    visible: true

    Column {
        anchors.centerIn: parent
        spacing: 24

        Switch {
            action: Action {
              id: enableClipping

              text: "Enable clipping"
              checked: false
              checkable: true
            }
        }
        SomeControl {
            initialPadding: 32
            clip: enableClipping.checked
        }
    }
}
