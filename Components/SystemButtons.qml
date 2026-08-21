import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4

RowLayout {
    id: root // ID added for direct access
    spacing: 30
    Layout.alignment: Qt.AlignLeft
    z: 100 

    // Receive Font from Main.qml
    property string fontFamily: "Monospace"

    property var buttons: [
        ["[ SUSPEND ]", 0],
        ["[ HIBERNATE ]", 1],
        ["[ REBOOT ]", 2],
        ["[ TERMINATE ]", 3]
    ]

    Repeater {
        model: buttons

        Button {
            id: btn
            text: modelData[0]
            visible: true 
            hoverEnabled: true
            
            background: Rectangle { color: "transparent" }
            
            contentItem: Text {
                text: parent.text
                // DIRECT ID REFERENCE (Fixes the undefined error)
                font.family: root.fontFamily 
                font.pointSize: 16 * 0.9 
                font.bold: true 
                color: btn.hovered ? "#33ff00" : "white"
            }

            onClicked: {
                var action = modelData[1]
                if (action === 0) sddm.suspend()
                else if (action === 1) sddm.hibernate()
                else if (action === 2) sddm.reboot()
                else if (action === 3) sddm.powerOff()
            }
        }
    }
}