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

    // --- LEFT COLUMN (Untouched) ---
    ColumnLayout {
        id: leftPanel
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 50
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

    // --- RIGHT COLUMN: FUNCTIONAL DASHBOARD ---
    ColumnLayout {
        id: rightPanel
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: config.ScreenPadding
        anchors.topMargin: 150 // Align top with Left Column
        width: parent.width * 0.4
        spacing: 40

        // 1. SYSTEM TIME (The Hero Element)
        Column {
            Layout.alignment: Qt.AlignLeft
            spacing: 0
            
            Text {
                text: "SYSTEM_TIME_REF:"
                color: "#33ff00"
                font.family: terminalFont.name
                font.bold: true
                font.pointSize: 14
            }
            Text {
                id: timeDisplay
                font.family: terminalFont.name
                font.bold: true
                font.pointSize: 64 // Bigger
                color: "white"
                function updateTime() { text = Qt.formatDateTime(new Date(), "HH:mm") }
                Timer { interval: 1000; running: true; repeat: true; onTriggered: parent.updateTime() }
                Component.onCompleted: updateTime()
            }
            Text {
                text: Qt.formatDateTime(new Date(), "ss") + " TICKS" // Seconds as "Ticks"
                font.family: terminalFont.name
                font.bold: true
                font.pointSize: 24
                color: "#33ff00"
                anchors.right: timeDisplay.right
            }
            Text {
                text: Qt.formatDateTime(new Date(), "dddd, yyyy-MM-dd").toUpperCase()
                font.family: terminalFont.name
                font.bold: true
                font.pointSize: 18
                color: "white"
                opacity: 0.8
            }
        }

        // 2. BIOMETRIC SCAN (User Avatar)
        // This attempts to load the user's face icon. If none, it shows a placeholder box.
        Column {
            spacing: 5
            Layout.alignment: Qt.AlignLeft
            
            Text {
                text: ">BIOMETRIC_MATCH:"
                color: "#33ff00"
                font.family: terminalFont.name
                font.bold: true
            }
            
            Item {
                width: 150
                height: 150
                
                // Green Brackets around the photo
                Rectangle { anchors.fill: parent; color: "transparent"; border.color: "white"; border.width: 2 }
                
                // Corner accents
                Rectangle { width: 10; height: 10; color: "#33ff00"; anchors.top: parent.top; anchors.left: parent.left }
                Rectangle { width: 10; height: 10; color: "#33ff00"; anchors.top: parent.top; anchors.right: parent.right }
                Rectangle { width: 10; height: 10; color: "#33ff00"; anchors.bottom: parent.bottom; anchors.left: parent.left }
                Rectangle { width: 10; height: 10; color: "#33ff00"; anchors.bottom: parent.bottom; anchors.right: parent.right }

                Image {
                    anchors.fill: parent
                    anchors.margins: 5
                    source: userModel.lastUser ? Qt.resolvedUrl(userModel.lastUser) : ""
                    fillMode: Image.PreserveAspectCrop
                    visible: source != ""
                }
                
                // Fallback text if no image
                Text {
                    anchors.centerIn: parent
                    text: "NO_BIO_DATA"
                    visible: parent.children[4].status !== Image.Ready
                    color: "white"
                    font.family: terminalFont.name
                    opacity: 0.5
                }
            }
        }

        // 3. ENVIRONMENT PARAMETERS (Session Info)
        Column {
            spacing: 10
            Layout.alignment: Qt.AlignLeft
            
            Text { 
                text: ">ENVIRONMENT_TARGET:"
                color: "#33ff00"
                font.family: terminalFont.name
                font.bold: true
            }
            
            // This mirrors the session selected in the left column
            Text { 
                // Accessing the session model to get the name
                text: "[" + form.sessionName.toUpperCase() + "]" 
                color: "white"
                font.family: terminalFont.name
                font.bold: true
                font.pointSize: 24
            }
            
            Text { 
                text: "Layout: " + Qt.locale().name.toUpperCase()
                color: "white"
                font.family: terminalFont.name
                font.bold: true
                opacity: 0.7
            }
        }
        
        Item { Layout.fillHeight: true }
        
        // FOOTER (Copyright)
        Text {
            text: "(C) SM-LINK DATA SYSTEMS"
            color: "white"
            font.family: terminalFont.name
            font.bold: true
            opacity: 0.8
        }
    }
}