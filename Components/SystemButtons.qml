import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4

RowLayout {
    spacing: 30
    Layout.alignment: Qt.AlignLeft
    // Ensure it sits on top of any background layers
    z: 100 

    // Define buttons: [Text, Translation, Check]
    // We set the 3rd value to 'true' to FORCE them to show up
    property var suspend:   ["[SUSPEND]",   config.TranslateSuspend,   true]
    property var hibernate: ["[HIBERNATE]", config.TranslateHibernate, true]
    property var reboot:    ["[REBOOT]",    config.TranslateReboot,    true]
    property var shutdown:  ["[TERMINATE]", config.TranslateShutdown,  true]

    Repeater {
        model: [suspend, hibernate, reboot, shutdown]

        Button {
            text: modelData[0]
            // This forces the button to be visible regardless of system state
            visible: true 
            hoverEnabled: true
            
            contentItem: Text {
                text: parent.text
                font.family: root.font.family
                font.pointSize: root.font.pointSize
                font.bold: true 
                // Default White, Green on Hover
                color: parent.hovered ? "#33ff00" : "white"
            }

            background: Rectangle { color: "transparent" }

            onClicked: {
                index == 0 ? sddm.suspend() : 
                index == 1 ? sddm.hibernate() : 
                index == 2 ? sddm.reboot() : sddm.powerOff()
            }
        }
    }
}