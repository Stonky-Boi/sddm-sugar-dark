import QtQuick 2.11
import QtQuick.Layouts 1.11
import SddmComponents 2.0 as SDDM

ColumnLayout {
    id: formContainer
    SDDM.TextConstants { id: textConstants }

    property alias currentSessionName: input.sessionName
    property string fontFamily
    property real fontSize
    property real screenHeight

    Input {
        id: input
        Layout.alignment: Qt.AlignLeft
        Layout.preferredWidth: parent.width
        Layout.fillHeight: true
        fontFamily: formContainer.fontFamily
        fontSize: formContainer.fontSize
    }
}