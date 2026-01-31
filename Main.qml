import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import "Components"

Pane {
    id: root
    height: config.ScreenHeight || Screen.height
    width: config.ScreenWidth || Screen.width

    // Expose the Right Panel's session selection to the Login Form
    property alias sessionIndex: rightPanelSessionSelect.selectedSession

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

    // --- LEFT COLUMN: LOGIN ONLY ---
    ColumnLayout {
        id: leftPanel
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 100 // Adjusted as per your previous preference
        anchors.topMargin: 150 
        spacing: 10
        width: parent.width * 0.45

        LoginForm {
            id: form
            Layout.fillWidth: true
            Layout.preferredHeight: 200
            // Pass the root session index to the form
            // (We will update LoginForm to use this)
        }

        Item { height: 80; width: 1 } 

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

    // --- RIGHT COLUMN: DASHBOARD ---
    ColumnLayout {
        id: rightPanel
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 100
        anchors.topMargin: 150
        width: parent.width * 0.4
        spacing: 40

        // 1. CLOCK WIDGET
        Column {
            spacing: 0
            Text {
                text: "> SYSTEM_TIME"
                color: "#33ff00"
                font.family: terminalFont.name
                font.bold: true
                font.pointSize: 14
            }
            Text {
                font.family: terminalFont.name
                font.bold: true
                font.pointSize: 64
                color: "white"
                style: Text.Outline; styleColor: "black" // Slight contrast
                
                function updateTime() { text = Qt.formatDateTime(new Date(), "HH:mm") }
                Timer { interval: 1000; running: true; repeat: true; onTriggered: parent.updateTime() }
                Component.onCompleted: updateTime()
            }
            Text {
                text: Qt.formatDateTime(new Date(), "dddd, MMMM d, yyyy").toUpperCase()
                font.family: terminalFont.name
                font.bold: true
                font.pointSize: 18
                color: "white"
                opacity: 0.8
            }
        }

        // 2. CALENDAR WIDGET
        Column {
            spacing: 10
            Text {
                text: "> CALENDAR_MODULE [" + Qt.formatDateTime(new Date(), "MM-yyyy") + "]"
                color: "#33ff00"
                font.family: terminalFont.name
                font.bold: true
                font.pointSize: 14
            }

            // Simple Grid for Calendar
            GridLayout {
                columns: 7
                columnSpacing: 15
                rowSpacing: 10

                // Days Header
                Repeater {
                    model: ["SU", "MO", "TU", "WE", "TH", "FR", "SA"]
                    Text { text: modelData; color: "#33ff00"; font.bold: true; font.family: terminalFont.name; font.pointSize: 14 }
                }

                // Days Generator
                Repeater {
                    model: 31 
                    Text {
                        // Quick logic to dim days not in month (simplified for aesthetics)
                        // A full JS calendar is complex in pure QML, this is a static visual representation
                        // In a real Qt environment we'd bind this to a C++ model, but for SDDM themes:
                        property var date: new Date()
                        property int today: date.getDate()
                        
                        text: (index + 1).toString().padStart(2, '0')
                        color: (index + 1) === today ? "#33ff00" : "white"
                        font.family: terminalFont.name
                        font.pointSize: 14
                        font.bold: (index + 1) === today
                        
                        // Simple toggle to highlight today
                        Rectangle {
                            anchors.fill: parent
                            color: "transparent"
                            border.color: (index + 1) === today ? "#33ff00" : "transparent"
                            border.width: 1
                        }
                    }
                }
            }
        }

        // 3. ENVIRONMENT SELECTOR (Moved from Left)
        Column {
            spacing: 5
            Text {
                text: "> TARGET_ENVIRONMENT"
                color: "#33ff00"
                font.family: terminalFont.name
                font.bold: true
                font.pointSize: 14
            }
            
            // We place the session button here now
            SessionButton {
                id: rightPanelSessionSelect
                textConstantSession: "SESSION"
                width: parent.width
                
                // Style it to look like a terminal entry
                anchors.left: parent.left
            }
            
            Text {
                text: "[SELECT DE/WM FOR INITIALIZATION]"
                color: "white"
                font.family: terminalFont.name
                font.pointSize: 12
                opacity: 0.6
                Layout.topMargin: 5
            }
        }

        Item { Layout.fillHeight: true }
        
        // FOOTER
        Text {
            text: "(C) SM-LINK DATA SYSTEMS"
            color: "white"
            font.family: terminalFont.name
            font.bold: true
            opacity: 0.5
        }
    }
}