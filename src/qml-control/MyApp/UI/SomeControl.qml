import QtQuick
import QtQuick.Controls
import MyApp.UI as UI


Control {
    id: root

    function findByName(name, suffix, item = root) {
        return item.children.find((e) => e.objectName === `${name}${suffix}`);
    }

    required property real initialPadding

    component PropertyInfo: Text {
        required property Item target
        required property var props

        color: "indigo"
        textFormat: Text.RichText
        text: {
              let result = [`<b>${target.objectName}</b>`]
              this.props.forEach(e => {
                  result.push(`${e}: ${target[e].toFixed(1)}`);
              });
              return result.join("<br/>")
        }
    }

    objectName: "root"
    background: Rectangle {
        objectName: "root.background"
        color: "teal"
        implicitWidth: 640 - root.leftInset - root.rightInset
        implicitHeight: 360 - root.topInset - root.bottomInset

    }
    padding: root.initialPadding
    contentItem: Rectangle {
        objectName: "root.contentItem"
        color: "orange"

        Row {
            anchors.centerIn: parent
            spacing: 24

            Column {
                spacing: 8

                PropertyInfo {
                    target: root
                    props: ["leftPadding", "topPadding", "rightPadding", "bottomPadding"]
                }
                PropertyInfo {
                    target: root
                    props: ["leftInset", "topInset", "rightInset", "bottomInset"]
                }
            }
            Column {
                spacing: 8

                PropertyInfo {
                    target: root.contentItem
                    props: ["x", "y", "width", "height"]
                }
                PropertyInfo {
                    target: root.background
                    props: ["x", "y", "width", "height"]
                }
            }
        }
    }

    Repeater {
        model: [
            {
                name: "leftResizer", suffix: "", left: true, top: true, right: false, bottom: true,
                orientation: Qt.Horizontal, margin: root.initialPadding, property: "leftPadding", position: "leftPosition"
            },
            {
                name: "topResizer", suffix: "", left: true, top: true, right: true, bottom: false,
                orientation: Qt.Vertical, margin: root.initialPadding, property: "topPadding", position: "topPosition"
            },
            {
                name: "rightResizer", suffix: "", left: false, top: true, right: true, bottom: true,
                orientation: Qt.Horizontal, margin: root.initialPadding, property: "rightPadding", position: "rightPosition"
            },
            {
                name: "bottomResizer", suffix: "", left: true, top: false, right: true, bottom: true,
                orientation: Qt.Vertical, margin: root.initialPadding, property: "bottomPadding", position: "bottomPosition"
            },
            {
                name: "leftResizerBG", suffix: "BG", left: true, top: true, right: false, bottom: true,
                orientation: Qt.Horizontal, margin: 0, property: "leftInset", position: "leftPosition"
            },
            {
                name: "topResizerBG", suffix: "BG", left: true, top: true, right: true, bottom: false,
                orientation: Qt.Vertical, margin: 0, property: "topInset", position: "topPosition"
            },
            {
                name: "rightResizerBG", suffix: "BG", left: false, top: true, right: true, bottom: true,
                orientation: Qt.Horizontal, margin: 0, property: "rightInset", position: "rightPosition"
            },
            {
                name: "bottomResizerBG", suffix: "BG", left: true, top: false, right: true, bottom: true,
                orientation: Qt.Vertical, margin: 0, property: "bottomInset", position: "bottomPosition"
            },
        ]
        delegate: UI.ResizeHandle {
            id: resizer

            required property var modelData
            readonly property bool needsVerticalMargins: this.modelData.orientation === Qt.Horizontal
            readonly property bool needsHorizontalMargins: this.modelData.orientation === Qt.Vertical

            objectName: modelData.name
            anchors {
                left: this.modelData.left ? root.left : undefined
                leftMargin: this.needsHorizontalMargins ? this.modelData.margin + root.findByName("leftResizer", this.modelData.suffix).leftPosition : undefined
                top: this.modelData.top ? root.top : undefined
                topMargin: this.needsVerticalMargins ? this.modelData.margin + root.findByName("topResizer", this.modelData.suffix).topPosition : undefined
                right: this.modelData.right ? root.right : undefined
                rightMargin: this.needsHorizontalMargins ? this.modelData.margin + root.findByName("rightResizer", this.modelData.suffix).rightPosition : undefined
                bottom: this.modelData.bottom ? root.bottom : undefined
                bottomMargin: this.needsVerticalMargins ? this.modelData.margin + root.findByName("bottomResizer", this.modelData.suffix).bottomPosition : undefined
                margins: this.modelData.margin
            }
            orientation: this.modelData.orientation

            Binding {
                target: root
                property: resizer.modelData.property
                when: resizer.active
                value: resizer.modelData.margin + resizer[resizer.modelData.position]
                restoreMode: Binding.RestoreNone
            }
        }
    }
}
