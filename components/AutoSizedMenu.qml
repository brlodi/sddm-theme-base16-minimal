import QtQuick 2.15
import QtQuick.Controls 2.15

Menu {
    id: container

    property bool sizeToContents: true
    property int modelWidth
    property alias model: instantiator.model

    width: (sizeToContents) ? modelWidth + 2*leftPadding + 2*rightPadding : implicitWidth

    delegate: ItemDelegate {
        width: container.width
        text: container.textRole ? (Array.isArray(container.model) ? modelData[container.textRole] : model[container.textRole]) : modelData
        font.weight: container.currentIndex === index ? Font.DemiBold : Font.Normal
        font.family: container.font.family
        font.pointSize: container.font.pointSize
        highlighted: container.highlightedIndex === index
        hoverEnabled: container.hoverEnabled
    }

    TextMetrics {
        id: textMetrics
    }

    Instantiator {
        id: instantiator

        model: sessionModel
        onObjectAdded: container.insertItem(index, object)
        onObjectRemoved: container.removeItem(object)

        delegate: MenuItem {
            text: model.name
            onTriggered: {
                container.currentIndex = model.index
                container.close()
            }
        }
    }

    onModelChanged: {
        textMetrics.font = container.font
        for(var i = 0; i < model.length; i++){
            textMetrics.text = model[i]
            modelWidth = Math.max(textMetrics.width, modelWidth)
        }
    }
}