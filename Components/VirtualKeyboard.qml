import QtQuick 2.0

// Safe Placeholder - prevents "InputPanel unavailable" crashes
Item {
    id: root
    visible: active
    property bool active: false
    property string fontFamily: "Monospace"
    
    anchors.fill: parent
    z: 200

    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: 250
        color: "black"
        opacity: 0.9
        border.color: "#33ff00"
        border.width: 1

        Column {
            anchors.centerIn: parent
            spacing: 10
            Text {
                text: "VIRTUAL_INPUT_DEVICE"
                color: "#33ff00"
                font.family: root.fontFamily
                font.bold: true
                font.pointSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Text {
                text: "[ KEYBOARD DRIVER ONLINE ]"
                color: "white"
                font.family: root.fontFamily
                font.pointSize: 14
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
    
    MouseArea {
        anchors.fill: parent
        z: -1
        onClicked: root.active = false
    }
}