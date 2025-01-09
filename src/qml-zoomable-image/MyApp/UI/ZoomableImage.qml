import QtQuick
import QtQuick.Controls


Flickable {
    id: root

    function fitToWidth() {
        root.setZoom(root.width / image.width);
    }

    function fitToHeight() {
        root.setZoom(root.height / image.height);
    }

    function fitToSize() {
        root.setZoom(Math.min(root.width / image.width, root.height / image.height));
    }

    function setZoom(zoom: real, originX: real, originY: real) {
        const roundToFixed = (value, digits) => {
            const factor = Math.pow(10, digits);
            return Math.round(value * factor) / factor;
        }

        // Change zoom in origin, which defaults to the center of the Flickable
        const x = isNaN(originX) ? (root.contentX + root.width / 2) : originX
        const y = isNaN(originY) ? (root.contentY + root.height / 2) : originY

        const clampedZoom = Math.min(root.maxZoom, Math.max(root.minZoom, zoom));
        const roundedZoom = roundToFixed(clampedZoom, root.digits);
        const normalizedFactor = (roundedZoom - root.zoom) / root.zoom;

        // Update Flickable's state
        root.zoom = roundedZoom;
        root.contentX += x * normalizedFactor;
        root.contentY += y * normalizedFactor;
    }

    property alias source: image.source
    property alias zoom: image.scale
    property bool enableLogScaling: false
    readonly property real minZoom: 0.25
    readonly property real maxZoom: 16.0
    readonly property real zoomStepSize: 0.04
    readonly property int digits: 2 // Should match or be larger than number of digits in `zoomStepSize`

    clip: true
    contentWidth: image.width * image.scale
    contentHeight: image.height * image.scale
    boundsMovement: Flickable.StopAtBounds
    ScrollBar.horizontal: ScrollBar {}
    ScrollBar.vertical: ScrollBar {}

    Image {
        id: image

        // Use the available width to fit image. Due to the fillMode, the image
        // will be scaled accordingly. The initial scale is unaffected and will
        // remain at 1.
        width: root.width - root.leftMargin - root.rightMargin
        fillMode: Image.PreserveAspectFit
        // `transformOrigin` needs to be mapped to root.contentX = 0, root.contentY = 0
        transformOrigin: Item.TopLeft
        horizontalAlignment: Image.AlignLeft

        // Settings optimized for scaling
        antialiasing: true
        asynchronous: true
        cache: false
        mipmap: true
        smooth: true

        // Remember, x & y have two bindings: Their original value and the
        // conditional bindings that are active when the image's size becomes
        // smaller than the viewport, on zoom out.
        x: 0
        y: 0

        // Two bindings to keep the image centered on zoom out.
        Binding on x {
            when: root.width > root.contentWidth
            value: (root.width - root.contentWidth) / 2
        }
        Binding on y {
            when: root.height > root.contentHeight
            value: (root.height - root.contentHeight) / 2
        }
    }
    MouseArea {
        // Sometimes, direct positioning (and sizing) is the best way...
        x: image.x
        y: image.y
        width: parent.width
        height: parent.height

        acceptedButtons: Qt.NoButton
        onWheel: (event) => {
            const stepSize = event.angleDelta.y > 0 ? root.zoomStepSize : -root.zoomStepSize;
            // With log scaling enabled, the step size adjusts dynamically to the zoom level.
            const scale = root.enableLogScaling ? Math.log(1 + root.zoom) : 1;
            root.setZoom(root.zoom + stepSize * scale, event.x, event.y);
            // Consumes the mouse event before the `Flickable` can process it.
            wheel.accepted = true;
        }
    }
}
