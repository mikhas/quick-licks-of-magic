import QtQuick
import QtQuick.Controls
import MyApp.UI.Layer1 as L1


ApplicationWindow {
    title: "QML Hierarchies"
    width: 1280
    height: 800
    visible: true
    menuBar: L1.AppMenu {}

    L1.Canvas { anchors.fill: parent }
}
