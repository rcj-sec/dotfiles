import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
  id: passwordField
  focus: true
  selectByMouse: true
  placeholderText: "passwd"
  echoMode: TextInput.Password
  passwordCharacter: "*"
  passwordMaskDelay: config.PasswordShowLastLetter
  selectionColor: config.lgreen1
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
    opacity: 0.8
    border.color: config.foreground
  }
  states: [
    State {
      name: "hovered"
      when: passwordField.hovered
      PropertyChanges {
        target: passFieldBackground
        opacity: 1
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
    if (user !== "" && password !== "")
      sddm.login(user, password, session)
  }
}
