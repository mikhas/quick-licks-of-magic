import QtQuick
import QtQuick.Controls
import MyApp.UI as UI
import MyApp.Backend as BE


ApplicationWindow {
    id: root

    title: "Actions and Decorators"
    width: 1280
    height: 800
    visible: true

    SplitView {
        anchors.fill: parent
        spacing: 8

        UI.ItemLoader {
            id: itemLoader

            SplitView.preferredWidth: root.width * .42
        }
        UI.ItemsView {
            id: view

            model: BE.Factory.makeStandardItemsModel(view)
            loadItem: Action {
                text: "Load"
                onTriggered: itemLoader.load(view.item)
            }
            removeItem: Action {
                text: "Remove"
                onTriggered: {
                    itemLoader.unload();
                    view.model.remove(view.item);
                }
            }
        }
    }
}
