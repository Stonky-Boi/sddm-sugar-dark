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

    palette.button: "transparent"
    palette.highlight: config.AccentColor
    palette.text: config.MainColor
    palette.buttonText: config.MainColor
    palette.window: "transparent"

    font.family: terminalFont.name
    font.pointSize: config.FontSize

    // Background
    Image {
        id: backgroundImage
        anchors.fill: parent
        source: config.Background
        fillMode: Image.PreserveAspectCrop
        z: 0
    }

    // --- LEFT COLUMN: LOGIN & LOGS ---
    ColumnLayout {
        id: leftPanel
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: config.ScreenPadding
        anchors.topMargin: config.ScreenPadding
        spacing: 20
        width: parent.width * 0.45

        // Header Logo Text
        Text {
            text: "WEYLAND-YUTANI\nPERSONAL-TERMINAL-ACCESS-INTERFACE"
            color: config.MainColor
            font.family: terminalFont.name
            font.bold: true
            font.pointSize: 24
            lineHeight: 1.2
        }

        Text {
            text: "**********************************************"
            color: config.MainColor
            font.family: terminalFont.name
        }

        // Login Form (Username/Pass)
        LoginForm {
            id: form
            Layout.fillWidth: true
            Layout.preferredHeight: 300
        }

        // Fake Terminal Boot Sequence
        Column {
            spacing: 5
            opacity: 0.8
            Text { text: "[ACCESSING PTAI SYSTEM...]"; color: config.MainColor; font.family: terminalFont.name }
            Text { text: "[LOADING USER PROFILE...]"; color: config.MainColor; font.family: terminalFont.name }
            Text { text: "[AUTHENTICATION REQUIRED]"; color: config.AccentColor; font.family: terminalFont.name }
            
            Item { height: 20; width: 1 } 
            
            Text { text: ">CMD:/access quick"; color: config.MainColor; font.family: terminalFont.name; opacity: 0.7 }
            Text { text: ">[DISPLAYING LOCAL QUICK ACCESS://]"; color: config.MainColor; font.family: terminalFont.name; opacity: 0.7 }
        }
        
        Item { Layout.fillHeight: true }
    }

    // --- RIGHT COLUMN: LORE & UPDATES ---
    ColumnLayout {
        id: rightPanel
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: config.ScreenPadding
        anchors.topMargin: config.ScreenPadding
        width: parent.width * 0.4
        spacing: 40

        // Safety Reminder
        Column {
            spacing: 5
            Text { 
                text: ">WYC REMINDER: SAFETY SECOND! PROFIT FIRST!"
                color: config.AccentColor
                font.family: terminalFont.name
                font.bold: true
            }
            Text { 
                text: "[00]D [00]H [00]M [19]S since last accident"
                color: config.MainColor
                font.family: terminalFont.name
            }
        }

        // Vacation Timer
        Column {
            spacing: 5
            Text { 
                text: ">Remaining Work Time Till Yvaga III Vacation"
                color: config.MainColor
                font.family: terminalFont.name
            }
            Text { 
                text: "[28489]D [21]H [5]M [5]S"
                color: config.MainColor
                font.family: terminalFont.name
            }
        }

        Item { height: 100; width: 1 } 

        // Important Update (LV-410)
        Column {
            spacing: 10
            Text { 
                text: ">>IMPORTANT UPDATE<<"
                color: config.AccentColor
                font.family: terminalFont.name
                font.bold: true
                font.pointSize: 18
            }
            Text { 
                width: parent.parent.width
                wrapMode: Text.WordWrap
                text: "ORBITAL MINERAL HARVESTING OVER LV-410\nHALTED UNTIL FURTHER NOTICE DUE TO UNKNOWN\nDEBRIS FIELD NEAR OPERATION AREA."
                color: config.MainColor
                font.family: terminalFont.name
            }
            Text { 
                width: parent.parent.width
                wrapMode: Text.WordWrap
                text: "THE SPREAD OF RUMORS OF ROGUE PERSONNEL ARE\nBASELESS."
                color: config.MainColor
                font.family: terminalFont.name
            }
            Text { 
                width: parent.parent.width
                wrapMode: Text.WordWrap
                text: "AIR CURFEW IS IN EFFECT.\nHAULERS OVER 50000FT WILL BE TARGETED BY\nDEFENSE SYSTEMS."
                color: config.MainColor
                font.family: terminalFont.name
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
        color: config.MainColor
        font.family: terminalFont.name
        opacity: 0.8
    }
}