/* Copyright (c) 2013 Ekkehard Gentz (ekke)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bb.cascades 1.0

Page {
    id: rootPage
    property bool loginDone: false
    titleBar: TitleBar {
        title: "Custom Credentials Dialog"
    }
    attachedObjects: [
        LoginDialog {
            id: myLoginDialog
            onClosed: {
                if (myLoginDialog.result == "LOGIN") {
                    console.log("LOGIN");
                    app.login(myLoginDialog.usernameEntry, myLoginDialog.passwordEntry);
                    myLoginDialog.usernameEntry = ""
                    myLoginDialog.passwordEntry = ""
                    return
                }
                if (myLoginDialog.result == "FORGOT") {
                    if (myLoginDialog.usernameEntry.length == 0) {
                        noEmailDialog.show()
                        return;
                    }
                    console.log("FORGOT PASSWORD");
                    app.forgotPassword(myLoginDialog.usernameEntry)
                    myLoginDialog.passwordEntry = ""
                    return
                }
                console.log("CANCEL LOGIN");
                myLoginDialog.usernameEntry = ""
                myLoginDialog.passwordEntry = ""
            }
        }
    ]
    Container {
        topPadding: 100
        leftPadding: 40
        rightPadding: 40
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        layout: StackLayout {
        }
        Label {
            text: "What's the answer Answer to the Ultimate Question of Life, The Universe, and Everything ?"
            multiline: true
            bottomMargin: 80
        }
        Button {
            id: loginButton
            visible: ! rootPage.loginDone
            text: qsTr("  Login") + Retranslate.onLanguageChanged
            imageSource: "asset:///images/buttons/login.png"
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            onClicked: {
                myLoginDialog.open();
            }
        }
        Label {
            id: answerLabel
            visible: rootPage.loginDone
            text: "42"
            textStyle.fontSize: FontSize.XXLarge
            textStyle.color: Color.Red
            horizontalAlignment: HorizontalAlignment.Center
        }
    }
    function onLoginDone(success) {
        if (success) {
            rootPage.loginDone = true
            return
        }
        // send toast to user that login failed
    }
    onCreationCompleted: {
        // we have to wait for the signal that login was done
        app.loginDone.connect(onLoginDone)
    }
}
