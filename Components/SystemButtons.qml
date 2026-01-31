import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4

RowLayout {
    spacing: 30
    Layout.alignment: Qt.AlignLeft

    property var suspend: ["[SUSPEND]", config.TranslateSuspend, sddm.canSuspend]
    property var hibernate: ["[HIBERNATE]", config.TranslateHibernate, sddm.canHibernate]
    property var reboot: ["[REBOOT]", config.TranslateReboot, sddm.canReboot]
    property var shutdown: ["[TERMINATE]", config.TranslateShutdown, sddm.canPowerOff]

    property Control exposedLogin

    Repeater {
        model: [suspend, hibernate, reboot, shutdown]

        Button {
            text: modelData[0]
            visible: modelData[2]
            hoverEnabled: true
            
            contentItem: Text {
                text: parent.text
                font.family: root.font.family
                font.pointSize: root.font.pointSize
                font.bold: true 
                // INTERACTIVITY: White by default, Green when mouse hovers
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