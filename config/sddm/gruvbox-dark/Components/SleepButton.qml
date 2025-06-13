import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
  implicitHeight: sleepButton.height
  implicitWidth: sleepButton.width
  Button {
    id: sleepButton
    height: 40
    width: 40
    hoverEnabled: true
    icon {
      source: Qt.resolvedUrl("../icons/sleep.svg")
      height: 20
      width: 20
      color: config.foreground
    }
    background: Rectangle {
      id: sleepButtonBg
      color: config.background
      border.color: config.accent
      radius: 15
    }
    states: [
      State {
        name: "hovered"
        when: sleepButton.hovered
        PropertyChanges {
          border.width: 2
          target: sleepButtonBg
          color: config.accent
        }
      }
    ]
    MouseArea {
        anchors.fill: sleepButton
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: sleepButton.clicked()
    }
    transitions: Transition {
      PropertyAnimation {
        properties: "color"
        duration: 300
      }
    }
    onClicked: sddm.suspend()
  }
}
