import QtQuick
import QtQuick.Controls


ApplicationWindow {
    id: root

    title: "My first QML app"
    width: 1280
    height: 800
    // Everybody forgets to set `visible` to `true` the first time. Right, Trin?
    visible: true

    Text {
        anchors.centerIn: parent
        text: "It works! Our application window size is "
            + `${root.width}x${root.height} pixels.`
    }
}
