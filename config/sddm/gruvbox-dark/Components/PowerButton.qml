import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
  implicitHeight: powerButton.height
  implicitWidth: powerButton.width
  Button {
    id: powerButton
    height: 40
    width: 40
    hoverEnabled: true
    icon {
      source: Qt.resolvedUrl("../icons/power.svg")
      height: 20
      width: 20
      color: config.foreground
    }
    background: Rectangle {
      id: powerButtonBackground
      radius: 15
      color: config.background
      border.color: config.accent
    }
    states: [
      State {
        name: "hovered"
        when: powerButton.hovered
        PropertyChanges {
          target: powerButtonBackground
          color: config.accent
          border.width: 2
        }
      }
    ]
    MouseArea {
        anchors.fill: powerButton
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: powerButton.clicked()
    }
    transitions: Transition {
      PropertyAnimation {
        properties: "color"
        duration: 300
      }
    }
    onClicked: sddm.powerOff()
  }
}
