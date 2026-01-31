import QtQuick 2.11
import QtQuick.Layouts 1.11
import SddmComponents 2.0 as SDDM

ColumnLayout {
    id: formContainer
    SDDM.TextConstants { id: textConstants }

    property var keyboard
    property alias currentSessionName: input.sessionName
    
    // --- ACCEPT PROPERTIES ---
    property string fontFamily
    property real fontSize
    property real screenHeight

    Input {
        id: input
        Layout.alignment: Qt.AlignLeft
        Layout.preferredWidth: parent.width
        
        // --- RESTORED PRISTINE LAYOUT LOGIC ---
        Layout.preferredHeight: formContainer.screenHeight / 10
        
        // --- PASS PROPERTIES DOWN ---
        keyboard: formContainer.keyboard
        fontFamily: formContainer.fontFamily
        fontSize: formContainer.fontSize
    }
}