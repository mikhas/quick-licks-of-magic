import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import MyApp.UI.Layer2 as L2


Container {
    id: root

    contentItem: RowLayout { spacing: 0 }

    L2.ToolBar {
        Layout.fillHeight: true
        topPadding: 8
    }
    L2.ContentPane {
        Layout.fillHeight: true
        Layout.fillWidth: true
    }
}
