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
        spacing: 10
        Layout.fillWidth: true

        Text {
            text: "LOGIN:   "
            color: "white" // Force White
            font.family: root.font.family
            font.pointSize: root.font.pointSize
            font.bold: true
        }

        Text { text: "["; color: "white"; font.pointSize: root.font.pointSize; font.bold: true }

        TextField {
            id: username
            Layout.preferredWidth: 300
            text: config.ForceLastUser == "true" ? userModel.lastUser : ""
            font.capitalization: Font.Capitalize
            font.family: root.font.family
            font.pointSize: root.font.pointSize
            font.bold: true
            
            // Text color inside the box
            color: "white" 
            
            placeholderText: "IDENTITY"
            horizontalAlignment: TextInput.AlignLeft
            background: Rectangle { color: "transparent" }

            Keys.onReturnPressed: loginButton.clicked()
            KeyNavigation.down: password
        }

        Text { text: "]"; color: "white"; font.pointSize: root.font.pointSize; font.bold: true }
    }

    // --- PASSWORD ---
    RowLayout {
        spacing: 10
        Layout.fillWidth: true

        Text {
            text: "PASSWORD:"
            color: "white" // Force White
            font.family: root.font.family
            font.pointSize: root.font.pointSize
            font.bold: true
        }

        Text { text: "["; color: "white"; font.pointSize: root.font.pointSize; font.bold: true }

        TextField {
            id: password
            Layout.preferredWidth: 300
            focus: config.ForcePasswordFocus == "true"
            echoMode: TextInput.Password
            passwordCharacter: "*"
            font.family: root.font.family
            font.pointSize: root.font.pointSize
            font.bold: true
            
            // Password dots should be white
            color: "white"
            
            horizontalAlignment: TextInput.AlignLeft
            background: Rectangle { color: "transparent" }

            Keys.onReturnPressed: loginButton.clicked()
        }

        Text { text: "]"; color: "white"; font.pointSize: root.font.pointSize; font.bold: true }
    }

    // --- ERROR MESSAGE ---
    Text {
        id: errorMessage
        text: failed ? config.TranslateLoginFailedWarning : ""
        color: "#ff3333" // Bright Red for error
        font.family: root.font.family
        font.bold: true
        font.pointSize: 16
        visible: failed
    }

    Button {
        id: loginButton
        visible: false
        onClicked: sddm.login(username.text, password.text, sessionSelect.selectedSession)
    }

    // --- SESSION SELECT ---
    SessionButton {
        id: sessionSelect
        textConstantSession: textConstants.session
        Layout.topMargin: 20
    }
}