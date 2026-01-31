import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtMultimedia 5.8 
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

    // --- AUDIO SYSTEM ---
    SoundEffect { 
        id: soundKeypress
        source: Qt.resolvedUrl("Assets/Sounds/keypress.wav")
        volume: 0.5 
    }
    SoundEffect { 
        id: soundAccessGranted
        source: Qt.resolvedUrl("Assets/Sounds/access_granted.wav")
        volume: 1.0 
    }
    SoundEffect { 
        id: soundAccessDenied
        source: Qt.resolvedUrl("Assets/Sounds/access_denied.wav")
        volume: 1.0 
    }

    // --- LOGIC: PLAY SOUNDS ON LOGIN EVENTS ---
    Connections {
        target: sddm
        function onLoginSucceeded() { soundAccessGranted.play() }
        function onLoginFailed() { soundAccessDenied.play() }
    }

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
            
            // Pass audio signal down to inputs for typing sounds
            property var soundEffect: soundKeypress 
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
        spacing: 40

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
                        color: index < 18 ? "white" : "#444" 
                    }
                }
            }
            Text { text: "OUTPUT: NOMINAL [100%]"; color: "white"; font.family: terminalFont.name; font.bold: true }
        }

        // 3. COMMS UPLINK
        Column {
            spacing: 5
            Layout.alignment: Qt.AlignLeft
            Text { text: ">COMMS_UPLINK_ARRAY:"; color: "#33ff00"; font.family: terminalFont.name; font.bold: true }
            
            Text { text: "PRIORITY: 1"; color: "white"; font.family: terminalFont.name; font.bold: true }
            Text { text: "ENCRYPTION: [ AES-256 ]"; color: "white"; font.family: terminalFont.name; font.bold: true }
            RowLayout {
                spacing: 10
                Text { text: "SIGNAL_STRENGTH:"; color: "white"; font.family: terminalFont.name; font.bold: true }
                Text { text: "|||||||||||| [-32dBm]"; color: "#33ff00"; font.family: terminalFont.name; font.bold: true }
            }
        }

        // 4. SYSTEM STATUS ARRAY
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
                Text { text: "INPUT_NODE:"; color: "white"; font.family: terminalFont.name; font.bold: true }
                Text { 
                    text: keyboard.layouts && keyboard.layouts.length > 0 ? "[" + keyboard.layouts[keyboard.currentLayout].toString().toUpperCase() + "]" : "[STD_INPUT]"
                    color: "white"; font.family: terminalFont.name; font.bold: true 
                }
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

    // --- VIRTUAL KEYBOARD ---
    Loader {
        id: virtualKeyboard
        source: "Components/VirtualKeyboard.qml"
        state: "hidden"
        z: 200 
        property bool active: item ? item.active : false
        anchors.fill: parent
        states: [
            State { name: "visible"; when: virtualKeyboard.active; PropertyChanges { target: virtualKeyboard; opacity: 1 } },
            State { name: "hidden"; when: !virtualKeyboard.active; PropertyChanges { target: virtualKeyboard; opacity: 0 } }
        ]
        transitions: Transition { NumberAnimation { property: "opacity"; duration: 200 } }
    }
}