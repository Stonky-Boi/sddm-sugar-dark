import QtQuick 2.11
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0

Item {
    id: sessionButton
    height: root.font.pointSize
    width: parent.width / 2
    anchors.horizontalCenter: parent.horizontalCenter

    property var selectedSession: selectSession.currentIndex
    property string textConstantSession
    property string currentSessionName: selectSession.currentText

    ComboBox {
        id: selectSession
        hoverEnabled: true
        anchors.left: parent.left
        model: sessionModel
        currentIndex: model.lastIndex
        textRole: "name"

        // The Dropdown List Item
        delegate: ItemDelegate {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            contentItem: Text {
                text: model.name
                font.pointSize: root.font.pointSize * 0.8
                // Highlight logic
                color: selectSession.highlightedIndex === index ? "black" : "white"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: root.font.family
                font.bold: true
            }
            highlighted: parent.highlightedIndex === index
            background: Rectangle {
                color: selectSession.highlightedIndex === index ? "#33ff00" : "black"
            }
        }

        indicator: Item { visible: false }

        // --- THE MAIN BUTTON LABEL ---
        contentItem: Text {
            id: displayedItem
            // FORMAT: [ SESSION: HYPRLAND ]
            text: "[ SESSION: " + (selectSession.currentText ? selectSession.currentText.toUpperCase() : "DEFAULT") + " ]"
            
            color: parent.hovered ? "#33ff00" : "white" // Green on hover
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
            font.pointSize: root.font.pointSize * 0.8
            font.family: root.font.family
            font.bold: true
        }

        background: Rectangle {
            color: "transparent"
            border.width: 0
        }

        popup: Popup {
            y: parent.height
            width: parent.width
            implicitHeight: contentItem.implicitHeight
            padding: 1
            contentItem: ListView {
                clip: true
                implicitHeight: contentHeight
                model: selectSession.popup.visible ? selectSession.delegateModel : null
                currentIndex: selectSession.highlightedIndex
            }
            background: Rectangle {
                color: "black"
                border.color: "white"
                border.width: 1
            }
        }
    }
}