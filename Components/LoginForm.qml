import QtQuick 2.11
import QtQuick.Layouts 1.11
import SddmComponents 2.0 as SDDM

ColumnLayout {
    id: formContainer
    SDDM.TextConstants { id: textConstants }

    // --- CRITICAL FIX: Accept the keyboard object from Main.qml ---
    property var keyboard
    
    // Expose session name to Main.qml
    property alias currentSessionName: input.sessionName

    Input {
        id: input
        Layout.alignment: Qt.AlignLeft
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: root.height / 10
        
        // --- CRITICAL FIX: Pass it to Input.qml ---
        keyboard: formContainer.keyboard
    }
}