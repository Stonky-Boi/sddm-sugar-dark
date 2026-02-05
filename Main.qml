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

    // --- LEFT COLUMN ---
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
            Layout.preferredHeight: 400
            fontFamily: terminalFont.name
            fontSize: config.FontSize
            screenHeight: root.height 
        }

        Item { height: 30; width: 1 } 

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
            fontFamily: terminalFont.name
        }
    }

    // --- RIGHT COLUMN ---
    ColumnLayout {
        id: rightPanel
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 50
        anchors.topMargin: 50 
        width: parent.width * 0.4
        spacing: 35

        // 1. SYSTEM TIME
        Column {
            Layout.alignment: Qt.AlignLeft
            spacing: 0
            Text { text: ">SYSTEM_TIME_REF:"; color: "#33ff00"; font.family: terminalFont.name; font.bold: true; font.pointSize: 14 }
            Text {
                id: timeDisplay
                font.family: terminalFont.name; font.bold: true; font.pointSize: 64; color: "white"
                function updateTime() { text = Qt.formatDateTime(new Date(), "HH:mm:ss") }
                Timer { interval: 1000; running: true; repeat: true; onTriggered: parent.updateTime() }
                Component.onCompleted: updateTime()
            }
            Text {
                text: Qt.formatDateTime(new Date(), "dddd, dd-MM-yyyy").toUpperCase()
                font.family: terminalFont.name; font.bold: true; font.pointSize: 18; color: "white"; opacity: 0.8
            }
        }

        // 2. REACTOR STATUS
        Column {
            spacing: 5
            Layout.alignment: Qt.AlignLeft
            Text { text: ">REACTOR_CORE_STATUS:"; color: "#33ff00"; font.family: terminalFont.name; font.bold: true }
            
            Row {
                spacing: 2
                Repeater {
                    model: 20
                    Rectangle {
                        width: 15; height: 25
                        property bool active: index < 18
                        color: active ? "white" : "#444"
                        opacity: active ? (0.8 + Math.random()*0.2) : 1 
                        Timer {
                            interval: 100 + Math.random() * 500
                            running: true; repeat: true
                            onTriggered: parent.opacity = parent.active ? (0.8 + Math.random()*0.2) : 1
                        }
                    }
                }
            }
            RowLayout {
                spacing: 10
                Text { text: "OUTPUT: NOMINAL"; color: "white"; font.family: terminalFont.name; font.bold: true }
                Text { 
                    text: "[ " + (100 + Math.floor(Math.random() * 3)) + "% ]" 
                    color: "#33ff00"; font.family: terminalFont.name; font.bold: true
                    Timer { interval: 800; running: true; repeat: true; onTriggered: parent.text = "[ " + (100 + Math.floor(Math.random() * 3)) + "% ]" }
                }
            }
        }

        // 3. COMMS UPLINK
        Column {
            spacing: 5
            Layout.alignment: Qt.AlignLeft
            Text { text: ">COMMS_UPLINK_ARRAY:"; color: "#33ff00"; font.family: terminalFont.name; font.bold: true }
            Text { text: "ENCRYPTION: [ AES-256 ]"; color: "white"; font.family: terminalFont.name; font.bold: true }
            
            RowLayout {
                spacing: 10
                Text { text: "SIGNAL_STRENGTH:"; color: "white"; font.family: terminalFont.name; font.bold: true }
                Text { 
                    text: "|||||||||||| [ -" + (32 + Math.floor(Math.random() * 4)) + "dBm ]" 
                    color: "#33ff00"; font.family: terminalFont.name; font.bold: true 
                    Timer { interval: 1500; running: true; repeat: true; onTriggered: parent.text = "|||||||||||| [ -" + (32 + Math.floor(Math.random() * 4)) + "dBm ]" }
                }
            }
        }

        // 4. MEMORY BANK
        Column {
            spacing: 5
            Layout.alignment: Qt.AlignLeft
            Text { text: ">MEMORY_ALLOCATION:"; color: "#33ff00"; font.family: terminalFont.name; font.bold: true }
            
            RowLayout {
                spacing: 5
                Rectangle {
                    width: 150; height: 15
                    color: "#222"; border.color: "white"; border.width: 1
                    Rectangle {
                        height: parent.height - 4; x: 2; y: 2
                        color: "white"
                        width: parent.width * 0.4 
                        SequentialAnimation on width {
                            loops: Animation.Infinite
                            NumberAnimation { to: 100; duration: 2000; easing.type: Easing.InOutQuad }
                            NumberAnimation { to: 60; duration: 2000; easing.type: Easing.InOutQuad }
                        }
                    }
                }
                Text { text: "[ BANK_01: ACTIVE ]"; color: "white"; font.family: terminalFont.name; font.bold: true }
            }
        }

        // 5. STORAGE STATUS
        Column {
            spacing: 5
            Layout.alignment: Qt.AlignLeft
            Text { text: ">DATA_VOLUME_STATUS:"; color: "#33ff00"; font.family: terminalFont.name; font.bold: true }
            
            RowLayout {
                spacing: 10
                Text { text: "MOUNT: /DEV/NVME0N1"; color: "white"; font.family: terminalFont.name; font.bold: true }
                Text { 
                    text: "[ READ ]"
                    color: parent.blink ? "#33ff00" : "#222"
                    font.family: terminalFont.name; font.bold: true
                    property bool blink: false
                    Timer { interval: 100; running: true; repeat: true; onTriggered: parent.blink = Math.random() > 0.7 }
                }
                Text { 
                    text: "[ WRITE ]"
                    color: parent.blink ? "red" : "#222"
                    font.family: terminalFont.name; font.bold: true
                    property bool blink: false
                    Timer { interval: 100; running: true; repeat: true; onTriggered: parent.blink = Math.random() > 0.9 } 
                }
            }
        }

        // 6. SYSTEM STATUS
        Column {
            spacing: 15
            Layout.alignment: Qt.AlignLeft
            
            Text { text: ">SYSTEM_STATUS_ARRAY:"; color: "#33ff00"; font.family: terminalFont.name; font.bold: true }
            RowLayout {
                spacing: 10
                Text { text: "HOST_NODE:"; color: "white"; font.family: terminalFont.name; font.bold: true }
                Text { text: "[" + sddm.hostName.toUpperCase() + "]"; color: "white"; font.family: terminalFont.name; font.bold: true }
            }
            RowLayout {
                spacing: 10
                Text { text: "TARGET_ENV:"; color: "white"; font.family: terminalFont.name; font.bold: true }
                Text { text: "[" + (form.currentSessionName ? form.currentSessionName.toUpperCase() : "DEFAULT") + "]"; color: "white"; font.family: terminalFont.name; font.bold: true }
            }
            RowLayout {
                spacing: 10
                visible: keyboard.capsLock
                Text { text: "SECURITY_ALERT:"; color: "red"; font.family: terminalFont.name; font.bold: true }
                Text { text: "[CAPS_LOCK DETECTED]"; color: "red"; font.family: terminalFont.name; font.bold: true }
            }
        }
        
        Item { Layout.fillHeight: true }
    }

    // --- FOOTER ---
    Text {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 50
        text: "(C) SM-LINK DATA SYSTEMS"
        color: "white"
        font.family: terminalFont.name
        font.bold: true
        opacity: 0.8
    }
}