import QtQuick 2.11
import QtQuick.Layouts 1.11
import SddmComponents 2.0 as SDDM

ColumnLayout {
    id: formContainer
    SDDM.TextConstants { id: textConstants }

    property int p: config.ScreenPadding
    property string a: config.FormPosition
    property alias systemButtonVisibility: systemButtons.visible
    // We hide the default clock to use our custom text instead
    property alias clockVisibility: clock.visible 
    property bool virtualKeyboardActive

    // Hidden Clock (Kept to prevent errors, but visibility set to false)
    Clock {
        id: clock
        visible: false 
    }

    // The Input Fields
    Input {
        id: input
        Layout.alignment: Qt.AlignLeft
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: root.height / 10
    }

    // System Buttons (Reboot/Shutdown) - Aligned Left
    SystemButtons {
        id: systemButtons
        Layout.alignment: Qt.AlignLeft
        Layout.preferredHeight: root.height / 10
        Layout.topMargin: 20
        exposedLogin: input.exposeLogin
    }
}