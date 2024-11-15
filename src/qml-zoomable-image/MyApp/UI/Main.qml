import QtQuick
import QtQuick.Controls
import MyApp.UI as UI


ApplicationWindow {
    id: root

    title: "ZoomableImage"
    width: 1280
    height: 800
    visible: true
    menuBar: UI.Toolbar {
        fitToWidth: Action {
            text: "Fit to width"
            onTriggered: image.fitToWidth()
        }
        fitToHeight: Action {
            text: "Fit to height"
            onTriggered: image.fitToHeight()
        }
        fitToSize: Action {
            text: "Fit to size"
            onTriggered: image.fitToSize()
        }
    }

    UI.ZoomableImage {
        id: image

        anchors {
            fill: parent
            leftMargin: root.width / 5
            topMargin: root.height / 10
            rightMargin: root.width / 5
            bottomMargin: root.height / 10
        }
        source: "../../media/norway.jpg"

    }
}
