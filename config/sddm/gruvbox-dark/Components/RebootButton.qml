import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
  implicitHeight: rebootButton.height
  implicitWidth: rebootButton.width
  Button {
    id: rebootButton
    height: 40
    width: 40
    hoverEnabled: true
    icon {
      source: Qt.resolvedUrl("../icons/reboot.svg")
      height: 20
      width: 20
      color: config.foreground
    }
    background: Rectangle {
      id: rebootButtonBackground
      radius: 15
      color: config.background
      border.color: config.accent
    }
    states: [
      State {
        name: "hovered"
        when: rebootButton.hovered
        PropertyChanges {
          target: rebootButtonBackground
          border.width: 2
          color: config.accent
        }
      }
    ]
    MouseArea {
        anchors.fill: rebootButton
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: rebootButton.clicked()
    }
    transitions: Transition {
      PropertyAnimation {
        properties: "color"
        duration: 300
      }
    }
    onClicked: sddm.reboot()
  }
}
