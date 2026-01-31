import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import "Components"

Pane {
    id: root
    height: config.ScreenHeight || Screen.height
    width: config.ScreenWidth || Screen.width

    FontLoader { id: terminalFont; source: "Assets/Fonts/ShareTechMono-Regular.ttf" }

    palette.text: "white"
    palette.buttonText: "white"
    palette.window: "transparent"

    font.family: terminalFont.name
    font.pointSize: config.FontSize

    Image {
        id: backgroundImage
        anchors.fill: parent
        source: config.Background
        fillMode: Image.PreserveAspectCrop
        z: 0
    }

    // --- LEFT COLUMN (PRESERVED STRICTLY AS REQUESTED) ---
    ColumnLayout {
        id: leftPanel
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        
        // MARGIN: 50 (As requested)
        anchors.leftMargin: 50
        // TOP: 150 (To clear the logo)
        anchors.topMargin: 150 
        
        spacing: 10
        width: parent.width * 0.45

        LoginForm {
            id: form
            Layout.fillWidth: true
            Layout.preferredHeight: 250
        }

        Item { height: 80; width: 1 } 

        Column {
            spacing: 5
            Text { text: "[ACCESSING PTAI SYSTEM...]"; color: "white"; font.family: terminalFont.name; font.bold: true }
            Text { text: "[LOADING USER PROFILE...]"; color: "white"; font.family: terminalFont.name; font.bold: true }
            Text { text: "[AUTHENTICATION STANDBY]"; color: "#33ff00"; font.family: terminalFont.name; font.bold: true }
            Item { height: 15; width: 1 }
            Text { text: "[INITIALIZING DATA ACCESS...]"; color: "white"; font.family: terminalFont.name; font.bold: true }
            Text { text: "[RETRIEVING INFORMATION...]"; color: "white"; font.family: terminalFont.name; font.bold: true }
            Item { height: 15; width: 1 }
            Text { text: ">CMD:/access quick"; color: "white"; font.family: terminalFont.name; font.bold: true }
            Text { text: ">[DISPLAYING LOCAL QUICK ACCESS://]"; color: "white"; font.family: terminalFont.name; font.bold: true }
        }
        
        Item { Layout.fillHeight: true } 

        SystemButtons {
            id: systemButtons
            Layout.alignment: Qt.AlignLeft
            Layout.preferredHeight: 50
            Layout.fillWidth: true
            Layout.bottomMargin: 50 
            visible: true
        }
    }

    // --- RIGHT COLUMN: FULL SYSTEM DASHBOARD ---
    ColumnLayout {
        id: rightPanel
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 50
        anchors.topMargin: 150 
        width: parent.width * 0.4
        spacing: 40

        // 1. SYSTEM TIME (Updated Formats)
        Column {
            Layout.alignment: Qt.AlignLeft
            spacing: 0
            
            Text {
                text: ">SYSTEM_TIME_REF:"
                color: "#33ff00"
                font.family: terminalFont.name
                font.bold: true
                font.pointSize: 14
            }
            Text {
                id: timeDisplay
                font.family: terminalFont.name
                font.bold: true
                font.pointSize: 64 
                color: "white"
                // Format: HH:mm:ss (24hr)
                function updateTime() { text = Qt.formatDateTime(new Date(), "HH:mm:ss") }
                Timer { interval: 1000; running: true; repeat: true; onTriggered: parent.updateTime() }
                Component.onCompleted: updateTime()
            }
            Text {
                // Format: Day, dd-mm-yyyy
                text: Qt.formatDateTime(new Date(), "dddd, dd-MM-yyyy").toUpperCase()
                font.family: terminalFont.name
                font.bold: true
                font.pointSize: 18
                color: "white"
                opacity: 0.8
            }
        }

        // 2. BIOMETRIC IDENTITY (Avatar)
        Column {
            spacing: 5
            Layout.alignment: Qt.AlignLeft
            
            Text {
                text: ">BIOMETRIC_IDENTITY:"
                color: "#33ff00"
                font.family: terminalFont.name
                font.bold: true
            }
            
            Item {
                width: 150
                height: 150
                
                // Outer Frame
                Rectangle { anchors.fill: parent; color: "transparent"; border.color: "white"; border.width: 2 }
                
                // Corner Brackets
                Rectangle { width: 10; height: 10; color: "#33ff00"; anchors.top: parent.top; anchors.left: parent.left }
                Rectangle { width: 10; height: 10; color: "#33ff00"; anchors.top: parent.top; anchors.right: parent.right }
                Rectangle { width: 10; height: 10; color: "#33ff00"; anchors.bottom: parent.bottom; anchors.left: parent.left }
                Rectangle { width: 10; height: 10; color: "#33ff00"; anchors.bottom: parent.bottom; anchors.right: parent.right }

                Image {
                    anchors.fill: parent
                    anchors.margins: 5
                    source: userModel.lastUser ? Qt.resolvedUrl(userModel.lastUser) : ""
                    fillMode: Image.PreserveAspectCrop
                }
                
                // Scanline effect
                Column {
                    anchors.fill: parent
                    Repeater {
                        model: 15
                        Rectangle {
                            width: parent.width; height: 1
                            color: "black"; opacity: 0.3
                            y: index * 10
                        }
                    }
                }
            }
        }

        // 3. SYSTEM STATUS ARRAY
        Column {
            spacing: 15
            Layout.alignment: Qt.AlignLeft
            
            Text { 
                text: ">SYSTEM_STATUS_ARRAY:"
                color: "#33ff00"
                font.family: terminalFont.name
                font.bold: true
            }

            // HOSTNAME
            RowLayout {
                spacing: 10
                Text { text: "HOST_NODE:"; color: "white"; font.family: terminalFont.name; font.bold: true }
                Text { 
                    text: "[" + sddm.hostName.toUpperCase() + "]"
                    color: "white"; font.family: terminalFont.name; font.bold: true 
                }
            }

            // SESSION TARGET (Bubbled up from left column)
            RowLayout {
                spacing: 10
                Text { text: "TARGET_ENV:"; color: "white"; font.family: terminalFont.name; font.bold: true }
                Text { 
                    text: "[" + (form.currentSessionName ? form.currentSessionName.toUpperCase() : "DEFAULT") + "]"
                    color: "white"; font.family: terminalFont.name; font.bold: true 
                }
            }

            // KEYBOARD LAYOUT
            RowLayout {
                spacing: 10
                Text { text: "INPUT_NODE:"; color: "white"; font.family: terminalFont.name; font.bold: true }
                Text { 
                    // Tries to get layout name, falls back to "STD_INPUT" if null
                    text: keyboard.layouts ? "[" + keyboard.layouts[keyboard.currentLayout].toUpperCase() + "]" : "[STD_INPUT]"
                    color: "white"; font.family: terminalFont.name; font.bold: true 
                }
            }
            
            // SECURITY ALERT (Caps Lock Sensor)
            // This only appears if Caps Lock is ON
            RowLayout {
                spacing: 10
                visible: keyboard.capsLock
                Text { text: "SECURITY_ALERT:"; color: "red"; font.family: terminalFont.name; font.bold: true }
                Text { text: "[CAPS_LOCK DETECTED]"; color: "red"; font.family: terminalFont.name; font.bold: true }
            }
        }
        
        Item { Layout.fillHeight: true }
        
        // FOOTER
        Text {
            text: "(C) SM-LINK DATA SYSTEMS"
            color: "white"
            font.family: terminalFont.name
            font.bold: true
            opacity: 0.8
        }
    }
}