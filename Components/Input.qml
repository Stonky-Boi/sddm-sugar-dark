import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4

Column {
    id: inputContainer
    Layout.fillWidth: true
    spacing: 15

    property Control exposeLogin: loginButton
    property bool failed

    // --- USERNAME ---
    RowLayout {
        spacing: 0 
        Layout.fillWidth: true

        Text {
            text: "LOGIN:   "
            color: "white" 
            font.family: root.font.family
            font.pointSize: root.font.pointSize
            font.bold: true
            Layout.rightMargin: 10
        }
        Text { text: "["; color: "white"; font.pointSize: root.font.pointSize; font.bold: true }
        
        TextField {
            id: username
            Layout.preferredWidth: 250
            Layout.fillWidth: false
            text: config.ForceLastUser == "true" ? userModel.lastUser : ""
            font.family: root.font.family
            font.pointSize: root.font.pointSize
            font.bold: true
            color: "white" 
            horizontalAlignment: TextInput.AlignLeft
            background: Rectangle { color: "transparent" }
            
            Keys.onReturnPressed: loginButton.clicked()
            KeyNavigation.down: password
        }
        
        Text { text: "]"; color: "white"; font.pointSize: root.font.pointSize; font.bold: true }
    }

    // --- PASSWORD ---
    RowLayout {
        spacing: 0
        Layout.fillWidth: true

        Text {
            text: "PASSWORD:"
            color: "white" 
            font.family: root.font.family
            font.pointSize: root.font.pointSize
            font.bold: true
            Layout.rightMargin: 10
        }
        Text { text: "["; color: "white"; font.pointSize: root.font.pointSize; font.bold: true }
        
        TextField {
            id: password
            Layout.preferredWidth: 250
            Layout.fillWidth: false
            focus: config.ForcePasswordFocus == "true"
            echoMode: revealSecret.checked ? TextInput.Normal : TextInput.Password
            passwordCharacter: "*"
            font.family: root.font.family
            font.pointSize: root.font.pointSize
            font.bold: true
            color: "white"
            horizontalAlignment: TextInput.AlignLeft
            background: Rectangle { color: "transparent" }
            
            Keys.onReturnPressed: loginButton.clicked()
        }
        
        Text { text: "]"; color: "white"; font.pointSize: root.font.pointSize; font.bold: true }
    }

    // --- CONTROLS ROW (Show Password + Session) ---
    RowLayout {
        spacing: 20
        Layout.topMargin: 5
        Layout.leftMargin: 105 // Aligns with the input boxes visually

        // Show Password Toggle
        CheckBox {
            id: revealSecret
            hoverEnabled: true
            
            indicator: Text {
                text: parent.checked ? "[X] SHOW" : "[ ] SHOW"
                font.family: root.font.family
                font.pointSize: root.font.pointSize * 0.9
                font.bold: true
                color: parent.hovered ? "#33ff00" : "white" // Turns green on hover
            }
            contentItem: Item {} // Hide standard text
        }

        // Session Selector (e.g. Hyprland/Plasma)
        SessionButton {
            id: sessionSelect
            textConstantSession: textConstants.session
        }
    }

    // --- ERROR MESSAGE ---
    Text {
        id: errorMessage
        text: failed ? config.TranslateLoginFailedWarning : ""
        color: "#ff3333" 
        font.family: root.font.family
        font.bold: true
        font.pointSize: 16
        visible: failed
        Layout.topMargin: 10
    }

    Button {
        id: loginButton
        visible: false
        onClicked: sddm.login(username.text, password.text, sessionSelect.selectedSession)
    }
}