import QtQuick 2.15
import QtQuick.Controls 2.15

RoundButton {
    id: container
    property int currentIndex: 0
    property string selectedSessionName: "default"

    property color menuTextColor: "black"
    property color menuBgColor: "gray"
    property color menuHighlightBgColor: "white"
    property color menuHighlightTextColor: "black"
    
    Menu {
        id: menu

        width: instantiator.widest
        
        background: Rectangle {
            color: container.menuBgColor
        }

        Instantiator {
            id: instantiator

            property real widest: -1

            model: sessionModel
            onObjectAdded: {
                menu.insertItem(index, object)
                instantiator.widest = Math.max(instantiator.widest, object.width)
            }
            onObjectRemoved: menu.removeItem(object)

            delegate: MenuItem {
                id: menuItem
                
                background: Rectangle {
                    color: menuItem.highlighted ? container.menuHighlightBgColor : "transparent"
                }
                
                contentItem: Text {
                    text: model.name
                    color: menuItem.highlighted ? container.menuHighlightTextColor : container.menuTextColor
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    padding: 0
                }
                
                onTriggered: {
                    container.currentIndex = model.index
                    container.selectedSessionName = model.name
                    menu.close()
                }
            }
        }
    }

    onPressed: {
        menu.popup(width/2, height)
    }
}