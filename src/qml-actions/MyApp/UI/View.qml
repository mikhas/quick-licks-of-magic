import QtQuick
import QtQuick.Controls


// UI.View
StackView {
    id: root

    function showPage(view, page, objectName) {
        const found = view.find((elem) => elem.objectName === objectName);

        if (found) {
            view.pop(found); // unwinds stack to found page
        } else {
            view.push(page) // page wasn't in stack yet => push
        }
    }

    component Page: Item {
        required property string text

        Text {
            anchors.centerIn: parent
            text: parent.text
            textFormat: Text.RichText
        }
    }

    readonly property Component browsePage: Page {
        objectName: "browsePage"
        text: "Showing <em>Browse</em> page"
    }
    readonly property Component detailsPage: Page {
        objectName: "detailsPage"
        text: "Showing <em>Details</em> page"
    }
    readonly property Component settingsPage: Page {
        objectName: "settingsPage"
        text: "Showing <em>Settings</em> page"
    }

    Component.onCompleted: root.showPage(root, root.browsePage, "browsePage")
}
