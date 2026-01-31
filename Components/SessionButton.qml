import QtQuick 2.11
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0

Item {
    id: sessionButton
    height: root.font.pointSize * 2
    width: parent.width // Fill the column

    property var selectedSession: selectSession.currentIndex
    property string textConstantSession

    ComboBox {
        id: selectSession
        anchors.left: parent.left
        width: 300 // Fixed width for the dropdown area

        model: sessionModel
        currentIndex: model.lastIndex
        textRole: "name"

        // The Text you see before clicking
        contentItem: Text {
            text: selectSession.currentText.toUpperCase()
            color: "white"
            font.family: root.font.family
            font.pointSize: root.font.pointSize
            font.bold: true
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle { color: "transparent" }

        // The Dropdown Menu
        popup: Popup {
            y: parent.height
            width: parent.width
            implicitHeight: contentItem.implicitHeight
            padding: 10

            contentItem: ListView {
                clip: true
                implicitHeight: contentHeight + 20
                model: selectSession.popup.visible ? selectSession.delegateModel : null
                currentIndex: selectSession.highlightedIndex
            }

            background: Rectangle {
                color: "black"
                border.color: "#33ff00" // Green border for terminal feel
                border.width: 1
            }
        }
        
        // The Items inside the Dropdown
        delegate: ItemDelegate {
            width: parent.width
            contentItem: Text {
                text: model.name.toUpperCase()
                font.family: root.font.family
                font.pointSize: root.font.pointSize
                color: hovered ? "#33ff00" : "white"
            }
            background: Rectangle { color: "transparent" }
        }
    }
}