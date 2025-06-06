import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
  implicitHeight: rebootButton.height
  implicitWidth: rebootButton.width
  Button {
    id: rebootButton
    height: inputHeight
    width: inputHeight
    hoverEnabled: true
    icon {
      source: Qt.resolvedUrl("../icons/reboot.svg")
      height: height
      width: width
      color: config.background
    }
    background: Rectangle {
      id: rebootButtonBackground
      radius: 3
      color: config.lgreen1
    }
    states: [
      State {
        name: "hovered"
        when: rebootButton.hovered
        PropertyChanges {
          target: rebootButtonBackground
          color: config.lgreen2
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
