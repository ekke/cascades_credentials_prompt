import bb.cascades 1.0

Dialog {
    id: loginDialog
    property string result
    property alias usernameEntry: usernameField.text
    property alias passwordEntry: passwordField.text
    Container {
        id: dialogContainer
        background: isDark() ? Color.Black : Color.White
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        Container {
            id: titleContainer
            background: Color.Blue
            topPadding: 5
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            minHeight: 90
            maxHeight: 90
            Label {
                text: "Login to your App"
                textStyle.base: SystemDefaults.TextStyles.TitleText
                textStyle.color: Color.White
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                translationY: 14
            }
        }
        ScrollView {
            Container {
                id: body
                leftPadding: 40
                rightPadding: 40
                topPadding: 60
                bottomPadding: 60
                TextField {
                    id: usernameField
                    hintText: qsTr("Email Address or Username")
                    text: ""
                    onTextChanging: {
                        loginButton.enabled = passwordField.text.length > 0 && text.length > 0
                        forgotButton.enabled = text.length > 0
                    }
                    inputMode: TextFieldInputMode.Url
                }
                TextField {
                    id: passwordField
                    hintText: "My Password"
                    topMargin: 30
                    text: ""
                    onTextChanging: {
                        loginButton.enabled = usernameField.text.length > 0 && text.length > 0
                    }
                    onTextChanged: {
                        loginButton.requestFocus()
                    }
                    inputMode: TextFieldInputMode.Password
                }
                Container {
                    id: buttonContainer
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    topPadding: 20
                    Button {
                        id: cancelButton
                        text: qsTr("Cancel")
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 1
                        }
                        onClicked: {
                            loginDialog.result = "CANCEL"
                            loginDialog.close()
                        }
                    }
                    Button {
                        id: forgotButton
                        enabled: false
                        text: qsTr("Forgot Password")
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 1
                        }
                        onClicked: {
                            loginDialog.result = "FORGOT"
                            loginDialog.close()
                        }
                    }
                }
                Container {
                    id: loginButtonContainer
                    topPadding: 30
                    bottomPadding: 80
                    Button {
                        id: loginButton
                        enabled: false
                        text: qsTr("Login")
                        preferredWidth: Infinity
                        focusPolicy: FocusPolicy.KeyAndTouch
                        onClicked: {
                            loginDialog.result = "LOGIN"
                            loginDialog.close()
                        }
                    }
                }
            }
        }

    }
    function isDark() {
        return Application.themeSupport.theme.colorTheme.style == VisualStyle.Dark
    }
    onOpened: {
        usernameField.requestFocus()
    }
}