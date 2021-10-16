import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "components"
// import SddmComponents 2.0

Rectangle {
    id: container
    width: 1024
    height: 768

    Item {
        id: themeVars
        property int fontSize: config.fontSize || 16
        property color base00: config.base00 || "#2d2d2d"
        property color base01: config.base01 || "#393939"
        property color base02: config.base02 || "#515151"
        property color base03: config.base03 || "#747369"
        property color base04: config.base04 || "#a09f93"
        property color base05: config.base05 || "#d3d0c8"
        property color base06: config.base06 || "#e8e6df"
        property color base07: config.base07 || "#f2f0ec"
        property color base08: config.base08 || "#f2777a"
        property color base09: config.base09 || "#f99157"
        property color base0A: config.base0A || "#ffcc66"
        property color base0B: config.base0B || "#99cc99"
        property color base0C: config.base0C || "#66cccc"
        property color base0D: config.base0D || "#6699cc"
        property color base0E: config.base0E || "#cc99cc"
        property color base0F: config.base0F || "#d27b53"

        property var bgColor:  (Qt.rgba(base00.r, base00.g, base00.b, config.windowBgOpacity || base00.a))
    }

    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    Connections {
        target: sddm
        onLoginSucceeded: {}
        onLoginFailed: {}
    }

    Image {
        id: backgroundImage
        anchors.fill: parent
        // source: "https://source.unsplash.com/1920x1080/?autumn"
        source: "./heather.jpg"
        fillMode: Image.PreserveAspectCrop

        onStatusChanged: {
            // for (const key of Object.keys(sessionModel)) {
            //     console.log(key, sessionModel[key])
            // }
            // console.log(sessionModel.index(0, 0).row())
            // for (let prop in sessionModel) {
            //     console.log(prop + ": " + sessionModel[prop])
            // }
            if (status == Image.Error && source != "./heather.jpg") {
                source = "./heather.jpg"
            }
        }
    }

    Rectangle {
        id: loginWindow

        property string placement: (config.loginWindowPlacement || "middleCenter").toLowerCase()
        property string hPlacement: placement.includes("left") ? "left"
                                    : placement.includes("right") ? "right"
                                    : "center"
        property string vPlacement: placement.includes("top") ? "top"
                                    : placement.includes("bottom") ? "bottom"
                                    : "middle"
        property int padding: themeVars.fontSize

        anchors.margins: themeVars.fontSize * 2
        anchors.left: hPlacement === "left" ? parent.left : undefined
        anchors.right: hPlacement === "right" ? parent.right : undefined
        anchors.horizontalCenter: hPlacement === "center" ? parent.horizontalCenter : undefined
        anchors.top: vPlacement === "top" ? parent.top : undefined
        anchors.bottom: vPlacement === "bottom" ? parent.bottom : undefined
        anchors.verticalCenter: vPlacement === "middle" ? parent.verticalCenter : undefined

        width: childrenRect.width + 2*padding
        height: childrenRect.height + 2*padding

        color: themeVars.bgColor

        GridLayout {
            anchors.centerIn: parent
            columns: 2
            rowSpacing: themeVars.fontSize/2
            columnSpacing: themeVars.fontSize/2

            Text {
                Layout.fillWidth: true;
                color: themeVars.base06
                horizontalAlignment: Text.AlignRight
                text: "user"
            }
            TextField {
                id: username
                Layout.preferredWidth: themeVars.fontSize * 8
                palette.text: themeVars.base07
                background: Rectangle { color: themeVars.base01 }
                text: userModel.lastUser
                selectByMouse: true

                onAccepted: password.focus = true
            }

            Text {
                Layout.fillWidth: true;
                color: themeVars.base06
                horizontalAlignment: Text.AlignRight
                text: "password"
            }
            TextField {
                id: password
                Layout.preferredWidth: themeVars.fontSize * 8
                palette.text: themeVars.base07
                background: Rectangle { color: themeVars.base01 }
                echoMode: TextInput.Password
                selectByMouse: true

                onAccepted: sddm.login(username.text, password.text, session.currentIndex)
            }
        }
    }

    GridLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: themeVars.fontSize / 4

        RoundButton {
            Layout.preferredWidth: themeVars.fontSize
            Layout.preferredHeight: themeVars.fontSize
            palette.buttonText: themeVars.base08
            palette.button: "transparent"
            contentItem: Text {
                text: "⨯"
                color: parent.palette.buttonText
                elide: Text.ElideNone
                horizontalAlignment: Text.AlignVCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        RoundButton {
            Layout.preferredWidth: themeVars.fontSize
            Layout.preferredHeight: themeVars.fontSize
            palette.buttonText: themeVars.base0A
            palette.button: "transparent"
            contentItem: Text {
                text: "↺"
                color: parent.palette.buttonText
                elide: Text.ElideNone
                horizontalAlignment: Text.AlignVCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        RoundButton {
            Layout.preferredWidth: themeVars.fontSize
            Layout.preferredHeight: themeVars.fontSize
            palette.buttonText: themeVars.base0B
            palette.button: "transparent"
            contentItem: Text {
                text: "☽"
                color: parent.palette.buttonText
                elide: Text.ElideNone
                horizontalAlignment: Text.AlignVCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        Rectangle {
            Layout.fillWidth: true
        }

        SessionPicker {
            id: session
            Layout.preferredWidth: childrenRect.width
            Layout.preferredHeight: themeVars.fontSize

            text: "⚙"
            
            menuBgColor: themeVars.base01
            menuTextColor: themeVars.base07
            menuHighlightBgColor: themeVars.base06
            menuHighlightTextColor: themeVars.base01
        }
    }

    Text {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        Timer {
            interval: 1000
            repeat: true
            running: true
            triggeredOnStart: true
            onTriggered: parent.text = new Date().toLocaleTimeString(Qt.locale(), Locale.ShortFormat)
        }
    }

    

    // Rectangle {
    //     id: overlay
    //     anchors.fill: parent
    //     color: "black"
    //     opacity: 1.0

    //     states: [
    //         State {
    //             name: "HIDDEN"
    //             when: backgroundImage.status == Image.Ready
    //             PropertyChanges { target: overlay; opacity: 0.0 }
    //         }
    //     ]

    //     transitions: Transition {
    //         to: "HIDDEN"; reversible: true
    //         NumberAnimation { properties: "opacity"; easing.type: Easing.InOutQuart; duration: 1000 }
    //     }
    // }
}