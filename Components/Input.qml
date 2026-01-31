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

    // --- USERNAME (Layer 200 - Highest Priority) ---
    RowLayout {
        spacing: 0 
        Layout.fillWidth: true
        // CRITICAL FIX: High Z-index ensures the dropdown covers everything below it
        z: 200 
        
        Text {
            text: "LOGIN:   "
            color: "white"; font.family: root.font.family; font.pointSize: root.font.pointSize; font.bold: true
            Layout.rightMargin: 10
        }
        Text { text: "["; color: "white"; font.pointSize: root.font.pointSize; font.bold: true }
        
        ComboBox {
            id: username
            Layout.preferredWidth: 250
            Layout.fillWidth: false
            model: userModel
            textRole: "name"
            currentIndex: model.lastIndex
            background: Rectangle { color: "transparent" }
            contentItem: Text {
                text: parent.currentText
                color: "white"
                font.family: root.font.family; font.pointSize: root.font.pointSize; font.bold: true
                verticalAlignment: Text.AlignVCenter
            }
            popup: Popup {
                y: parent.height; width: parent.width; implicitHeight: contentItem.implicitHeight; padding: 1
                contentItem: ListView {
                    clip: true; implicitHeight: contentHeight
                    model: username.popup.visible ? username.delegateModel : null
                    currentIndex: username.highlightedIndex
                }
                background: Rectangle { color: "black"; border.color: "white"; border.width: 1 }
            }
            delegate: ItemDelegate {
                width: parent.width
                contentItem: Text {
                    text: model.name; color: hovered ? "black" : "white"
                    font.family: root.font.family; font.bold: true
                }
                background: Rectangle { color: hovered ? "#33ff00" : "black" }
            }
        }
        Text { text: "]"; color: "white"; font.pointSize: root.font.pointSize; font.bold: true }
    }

    // --- PASSWORD (Layer 100) ---
    RowLayout {
        spacing: 0
        Layout.fillWidth: true
        z: 100
        
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

    // --- CONTROLS STACK (Layer 1) ---

    // 1. Show Password
    RowLayout {
        Layout.topMargin: 5
        Layout.leftMargin: 105 
        z: 1
        CheckBox {
            id: revealSecret
            hoverEnabled: true
            indicator: Text {
                text: parent.checked ? "[X] SHOW" : "[ ] SHOW"
                font.family: root.font.family; font.pointSize: root.font.pointSize * 0.8; font.bold: true
                color: parent.hovered ? "#33ff00" : "white" 
            }
            contentItem: Item {} 
        }
    }

    // 2. Virtual Keyboard Toggle
    RowLayout {
        Layout.topMargin: 0
        Layout.leftMargin: 105 
        z: 1
        Button {
            text: "[ KEYBOARD ]"
            hoverEnabled: true
            visible: true
            background: Rectangle { color: "transparent" }
            contentItem: Text {
                text: parent.text
                font.family: root.font.family; font.pointSize: root.font.pointSize * 0.8; font.bold: true
                color: parent.hovered ? "#33ff00" : "white"
            }
            onClicked: {
                virtualKeyboard.active = !virtualKeyboard.active
            }
        }
    }

    // 3. Session Switcher
    RowLayout {
        Layout.topMargin: 0
        Layout.leftMargin: 105 
        z: 1
        
        // Wrap in Item to ensure it takes proper space in the layout
        Item {
            width: childrenRect.width
            height: childrenRect.height
            SessionButton {
                id: sessionSelect
                textConstantSession: textConstants.session
                anchors.left: parent.left
                // Remove centering to respect the RowLayout
                anchors.horizontalCenter: undefined 
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