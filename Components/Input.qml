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
            color: root.palette.text
            font.family: root.font.family
            font.pointSize: root.font.pointSize
        }

        // We wrap the User Input in brackets [ ] visually
        Text { text: "["; color: root.palette.text; font.pointSize: root.font.pointSize }

        TextField {
            id: username
            Layout.preferredWidth: 300
            text: config.ForceLastUser == "true" ? userModel.lastUser : ""
            font.capitalization: Font.Capitalize
            font.family: root.font.family
            font.pointSize: root.font.pointSize
            color: root.palette.highlight
            
            placeholderText: "IDENTITY"
            horizontalAlignment: TextInput.AlignLeft
            
            // Remove standard white box, make it transparent
            background: Rectangle { color: "transparent" }

            Keys.onReturnPressed: loginButton.clicked()
            KeyNavigation.down: password
        }

        Text { text: "]"; color: root.palette.text; font.pointSize: root.font.pointSize }
    }

    // --- PASSWORD ---
    RowLayout {
        spacing: 10
        Layout.fillWidth: true

        Text {
            text: "PASSWORD:"
            color: root.palette.text
            font.family: root.font.family
            font.pointSize: root.font.pointSize
        }

        Text { text: "["; color: root.palette.text; font.pointSize: root.font.pointSize }

        TextField {
            id: password
            Layout.preferredWidth: 300
            focus: config.ForcePasswordFocus == "true"
            echoMode: TextInput.Password
            passwordCharacter: "*"
            font.family: root.font.family
            font.pointSize: root.font.pointSize
            color: root.palette.highlight
            
            horizontalAlignment: TextInput.AlignLeft
            background: Rectangle { color: "transparent" }

            Keys.onReturnPressed: loginButton.clicked()
        }

        Text { text: "]"; color: root.palette.text; font.pointSize: root.font.pointSize }
    }

    // --- ERROR MESSAGE ---
    Text {
        id: errorMessage
        text: failed ? config.TranslateLoginFailedWarning : ""
        color: "red" // Red alert for errors
        font.family: root.font.family
        font.bold: true
        visible: failed
    }

    // --- HIDDEN BUT NECESSARY BUTTON ---
    // SDDM needs a button to trigger the login signal
    Button {
        id: loginButton
        visible: false
        onClicked: sddm.login(username.text, password.text, sessionSelect.selectedSession)
    }

    // --- SESSION SELECT (Text Only) ---
    SessionButton {
        id: sessionSelect
        textConstantSession: textConstants.session
        Layout.topMargin: 20
    }
}