import QtQuick
import QtQuick.Controls


// UI.Toolbar
Container {
    id: root

    required property Action home
    required property Action next

    contentItem: Row { spacing: 8 }

    Button { action: root.home }
    Button { action: root.next }
}
