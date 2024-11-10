import QtQuick
import QtQuick.Controls
import MyApp.UI as UI


ApplicationWindow {
    id: root

    title: "Using QML Actions to Decouple Components"
    width: 1280
    height: 800
    visible: true
    menuBar: UI.Toolbar {
        browse: Action {
            text: "Browse"
            onTriggered: view.showPage(view, view.browsePage, "browsePage")
        }
        viewDetails: Action {
            text: "View Details"
            onTriggered: view.showPage(view, view.detailsPage, "detailsPage")
        }
        viewSettings: Action {
            text: "View Settings"
            onTriggered: view.showPage(view, view.browsePage, "settingsPage")
        }
    }

    UI.View {
        id: view

        anchors.fill: parent
    }
}
