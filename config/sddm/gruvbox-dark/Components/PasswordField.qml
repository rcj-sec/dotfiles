import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
  id: passwordField
  focus: true
  selectByMouse: true
  placeholderText: "passwd"
  placeholderTextColor: config.accent
  echoMode: TextInput.Password
  passwordCharacter: "*"
  passwordMaskDelay: config.PasswordShowLastLetter
  selectionColor: config.accent
  renderType: Text.NativeRendering
  font.family: config.Font
  font.pointSize: config.FontSize
  font.bold: true
  color: config.foreground
  horizontalAlignment: TextInput.AlignHCenter
  background: Rectangle {
    id: passFieldBackground
    radius: 15
    color: config.background
    border.color: config.accent
  }
  states: [
    State {
      name: "hovered"
      when: passwordField.hovered
      PropertyChanges {
        target: passFieldBackground
      }
    }
  ]
  transitions: Transition {
    PropertyAnimation {
      properties: "color"
      duration: 300
    }
  }
  onAccepted: {
      if (user !== "" && password !== "") {
        passFieldBackground.color = config.accent
        sddm.login(user, password, session)
      }
  }
  Connections {
    target: sddm

    function onLoginFailed() {
      passFieldBackground.color = config.background
    }
  }
}
