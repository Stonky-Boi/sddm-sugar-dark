import QtQuick 2.11
import QtQuick.Layouts 1.11
import SddmComponents 2.0 as SDDM

ColumnLayout {
    id: formContainer
    SDDM.TextConstants { id: textConstants }

    property int p: config.ScreenPadding
    property string a: config.FormPosition
    property bool virtualKeyboardActive
    property alias currentSessionName: input.sessionName

    Input {
        id: input
        Layout.alignment: Qt.AlignLeft
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: root.height / 10
    }
}