import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4

Column {
    id: inputContainer
    Layout.fillWidth: true
    spacing: 15

    property Control exposeLogin: loginButton
    property bool failed
    property alias sessionName: sessionSelect.currentSessionName

    // --- USERNAME (Now a ComboBox for User Switching) ---
    RowLayout {
        spacing: 0 
        Layout.fillWidth: true
        Text {
            text: "LOGIN:   "
            color: "white"; font.family: root.font.family; font.pointSize: root.font.pointSize; font.bold: true
            Layout.rightMargin: 10
        }
        Text { text: "["; color: "white"; font.pointSize: root.font.pointSize; font.bold: true }
        
        // This ComboBox works as a User Switcher
        ComboBox {
            id: username
            Layout.preferredWidth: 250
            Layout.fillWidth: false
            model: userModel
            textRole: "name"
            currentIndex: model.lastIndex
            
            // Visual styling to match terminal look (Transparent)
            background: Rectangle { color: "transparent" }
            contentItem: Text {
                text: parent.currentText
                color: "white"
                font.family: root.font.family
                font.pointSize: root.font.pointSize
                font.bold: true
                verticalAlignment: Text.AlignVCenter
            }
            
            // The Dropdown List Styling
            popup: Popup {
                y: parent.height
                width: parent.width
                implicitHeight: contentItem.implicitHeight
                padding: 1
                contentItem: ListView {
                    clip: true
                    implicitHeight: contentHeight
                    model: username.popup.visible ? username.delegateModel : null
                    currentIndex: username.highlightedIndex
                }
                background: Rectangle {
                    color: "black"
                    border.color: "white"
                    border.width: 1
                }
            }
            
            // Individual Items in the list
            delegate: ItemDelegate {
                width: parent.width
                contentItem: Text {
                    text: model.name
                    color: hovered ? "black" : "white"
                    font.family: root.font.family
                    font.bold: true
                }
                background: Rectangle {
                    color: hovered ? "#33ff00" : "black"
                }
            }
        }
        
        Text { text: "]"; color: "white"; font.pointSize: root.font.pointSize; font.bold: true }
    }

    // --- PASSWORD ---
    RowLayout {
        spacing: 0
        Layout.fillWidth: true
        Text {
            text: "PASSWORD:"
            color: "white"; font.family: root.font.family; font.pointSize: root.font.pointSize; font.bold: true
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
            font.family: root.font.family; font.pointSize: root.font.pointSize; font.bold: true
            color: "white"
            horizontalAlignment: TextInput.AlignLeft
            background: Rectangle { color: "transparent" }
            Keys.onReturnPressed: loginButton.clicked()
        }
        Text { text: "]"; color: "white"; font.pointSize: root.font.pointSize; font.bold: true }
    }

    // --- CONTROLS ROW (Full Feature Set) ---
    RowLayout {
        spacing: 20
        Layout.topMargin: 5
        Layout.leftMargin: 105 

        // 1. Show Password
        CheckBox {
            id: revealSecret
            hoverEnabled: true
            indicator: Text {
                text: parent.checked ? "[X] SHOW" : "[ ] SHOW"
                font.family: root.font.family; font.pointSize: root.font.pointSize * 0.9; font.bold: true
                color: parent.hovered ? "#33ff00" : "white" 
            }
            contentItem: Item {} 
        }

        // 2. Session Select
        SessionButton {
            id: sessionSelect
            textConstantSession: textConstants.session
        }

        // 3. Virtual Keyboard Toggle
        Button {
            text: "[KEYBOARD]"
            hoverEnabled: true
            visible: config.ForceHideVirtualKeyboardButton == "false"
            background: Rectangle { color: "transparent" }
            contentItem: Text {
                text: parent.text
                font.family: root.font.family; font.pointSize: root.font.pointSize * 0.9; font.bold: true
                color: parent.hovered ? "#33ff00" : "white"
            }
            onClicked: {
                // Toggle the keyboard
                virtualKeyboard.active = !virtualKeyboard.active
            }
        }
        
        // 4. Layout Switcher (Only shows if >1 layout)
        Button {
            text: "[LAYOUT]"
            hoverEnabled: true
            // Only visible if there are multiple layouts to switch between
            visible: keyboard.layouts.length > 1
            background: Rectangle { color: "transparent" }
            contentItem: Text {
                text: parent.text
                font.family: root.font.family; font.pointSize: root.font.pointSize * 0.9; font.bold: true
                color: parent.hovered ? "#33ff00" : "white"
            }
            onClicked: {
                // Cycle through layouts
                keyboard.currentLayout = (keyboard.currentLayout + 1) % keyboard.layouts.length
            }
        }
    }

    Text {
        id: errorMessage
        text: failed ? config.TranslateLoginFailedWarning : ""
        color: "#ff3333" 
        font.family: root.font.family; font.bold: true; font.pointSize: 16
        visible: failed
        Layout.topMargin: 10
    }

    Button {
        id: loginButton
        visible: false
        onClicked: sddm.login(username.currentText, password.text, sessionSelect.selectedSession)
    }
}