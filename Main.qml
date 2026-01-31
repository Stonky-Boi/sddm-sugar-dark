import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import "Components"

Pane {
    id: root
    height: config.ScreenHeight || Screen.height
    width: config.ScreenWidth || Screen.width

    // Load Custom Font
    FontLoader { id: terminalFont; source: "Assets/Fonts/ShareTechMono-Regular.ttf" }

    // Force global white text
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

    // --- LEFT COLUMN: LOGIN & CONTROLS ---
    ColumnLayout {
        id: leftPanel
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: config.ScreenPadding
        
        // This margin pushes the Login Form down to clear the logo in your wallpaper
        anchors.topMargin: 250 
        
        spacing: 10
        width: parent.width * 0.45

        // [REMOVED HEADER TEXT BLOCKS HERE]

        // LOGIN FORM
        LoginForm {
            id: form
            Layout.fillWidth: true
            Layout.preferredHeight: 250
        }

        // LORE TEXT
        Column {
            spacing: 5
            Layout.topMargin: 0
            
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
        
        Item { Layout.fillHeight: true } // Push Power Buttons to bottom

        // POWER CONTROLS
        SystemButtons {
            id: systemButtons
            Layout.alignment: Qt.AlignLeft
            Layout.preferredHeight: 50
            Layout.fillWidth: true
            Layout.bottomMargin: 50 
            visible: true
        }
    }

    // --- RIGHT COLUMN: REMINDERS, CLOCK & UPDATES ---
    ColumnLayout {
        id: rightPanel
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: config.ScreenPadding
        anchors.topMargin: config.ScreenPadding
        width: parent.width * 0.4
        spacing: 30

        // Reminder Block
        Column {
            spacing: 5
            Text { 
                text: ">WYC REMINDER: SAFETY SECOND! PROFIT FIRST!"
                color: "white" 
                font.family: terminalFont.name
                font.bold: true
            }
            Text { 
                text: "[00]D [00]H [00]M [19]S since last accident"
                color: "white" 
                font.family: terminalFont.name
                font.bold: true
            }
        }

        // Vacation Timer
        Column {
            spacing: 5
            Text { 
                text: ">Remaining Work Time Till Yvaga III Vacation"
                color: "white"
                font.family: terminalFont.name
                font.bold: true
            }
            Text { 
                text: "[28489]D [21]H [5]M [5]S"
                color: "white"
                font.family: terminalFont.name
                font.bold: true
            }
        }
        
        Item { Layout.fillHeight: true } 

        // --- CLOCK ---
        Column {
            spacing: 5
            Layout.alignment: Qt.AlignLeft
            
            Text {
                text: ">SYSTEM TIME:"
                color: "#33ff00"
                font.family: terminalFont.name
                font.bold: true
                font.pointSize: 14
            }
            Text {
                id: timeDisplay
                font.family: terminalFont.name
                font.bold: true
                font.pointSize: 48 
                color: "white"
                function updateTime() { text = Qt.formatDateTime(new Date(), "HH:mm:ss") }
                Timer { interval: 1000; running: true; repeat: true; onTriggered: parent.updateTime() }
                Component.onCompleted: updateTime()
            }
            Text {
                text: Qt.formatDateTime(new Date(), "dddd, yyyy-MM-dd")
                font.family: terminalFont.name
                font.bold: true
                font.pointSize: 18
                color: "white"
                opacity: 0.8
            }
        }

        Item { height: 20; width: 1 }

        // Important Update
        Column {
            spacing: 10
            Text { 
                text: ">>IMPORTANT UPDATE<<"
                color: "#33ff00"
                font.family: terminalFont.name
                font.bold: true
                font.pointSize: 20
            }
            Text { 
                width: parent.parent.width
                wrapMode: Text.WordWrap
                text: "ORBITAL MINERAL HARVESTING OVER LV-410\nHALTED UNTIL FURTHER NOTICE DUE TO UNKNOWN\nDEBRIS FIELD NEAR OPERATION AREA."
                color: "white"
                font.family: terminalFont.name
                font.bold: true
                font.pointSize: 14 
            }
            Text { 
                width: parent.parent.width
                wrapMode: Text.WordWrap
                text: "THE SPREAD OF RUMORS OF ROGUE PERSONNEL ARE\nBASELESS."
                color: "white"
                font.family: terminalFont.name
                font.bold: true
                font.pointSize: 14
            }
            Text { 
                width: parent.parent.width
                wrapMode: Text.WordWrap
                text: "AIR CURFEW IS IN EFFECT.\nHAULERS OVER 50000FT WILL BE TARGETED BY\nDEFENSE SYSTEMS."
                color: "white"
                font.family: terminalFont.name
                font.bold: true
                font.pointSize: 14
            }
        }
        
        Item { Layout.fillHeight: true }
    }

    // --- FOOTER ---
    Text {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 20
        text: "(C) SM-LINK DATA SYSTEMS"
        color: "white"
        font.family: terminalFont.name
        font.bold: true
        opacity: 0.8
    }
}