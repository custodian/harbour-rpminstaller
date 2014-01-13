import QtQuick 2.0
import Sailfish.Silica 1.0

import net.thecust.rpminfo 1.0
import net.thecust.packagemanager 1.0
import "../components"

Page {
    id: page

    property string installTransaction: ""
    property string versionTransaction: ""
    property string packageState: ""
    property variant installedPackage

    PkgManagerProxy {
        id: pkgManagerProxy

        onTransactionPackage: {
            if (trname == versionTransaction) {
                installedPackage = pkgobject;
                packageState = pkgstatus;
                versionTransaction == 0;
            }
        }

        onTransactionFinished: {
            if (trname == installTransaction) {
                //remorse.execute("Package has been installed");
                rpmInfo.load(Qt.application.arguments[1]);
                installTransaction = "";
            }
        }

        onTransactionError: {
            if (trname == installTransaction) {
                installTransaction = "";
                pageStack.push("ErrorDialog.qml", {"trName": trname, "trStatus":trstatus, "trMessage":trmessage});
            }
        }
    }

    RemorsePopup {
        id: remorse
    }

    RPMInfo {
        id: rpmInfo
        Component.onCompleted: {
            rpmInfo.load(Qt.application.arguments[1]);
        }
        onLoadFinished: {
            if (!success) {
                console.log("Error");
            } else {
                versionTransaction = pkgManagerProxy.searchName(rpmInfo.name);
            }
        }
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height
        clip: true

        PullDownMenu {
            MenuItem {
                text: qsTr("About RPM-Installer")
                onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
            }
            /*MenuItem {
                text: qsTr("List package files")
                onClicked: pageStack.push(Qt.resolvedUrl("Files.qml"), {"filesList": rpmInfo.filesList})
            }*/
            MenuItem {
                text: qsTr("Install")
                onClicked: installTransaction = pkgManagerProxy.installFile(Qt.application.arguments[1])
            }
        }

        Column {
            id: column
            anchors {
                left: parent.left
                right: parent.right
                margins: Theme.paddingLarge
            }
            spacing: Theme.paddingLarge

            PageHeader {
                id: pageHeader
                title: "Install RPM"
            }

            Column {
                width: parent.width
                Label {
                    text: qsTr("Name")
                    font.pixelSize: Theme.fontSizeLarge
                    color: Theme.highlightColor
                }
                Text {
                    color: Theme.primaryColor
                    font.pixelSize: Theme.fontSizeLarge
                    wrapMode: Text.WordWrap
                    text: rpmInfo.name;
                }
            }

            PkgManagerStatus {
                id: pkgManagerStatus
                showPending: false
                visible: installTransaction !== ""
            }
            Column {
                spacing: Theme.paddingLarge
                width: parent.width
                visible: installTransaction === ""

                Column {
                    width: parent.width
                    Label {
                        text: qsTr("Summary")
                        font.pixelSize: Theme.fontSizeLarge
                        color: Theme.highlightColor
                    }
                    Text {
                        width: parent.width
                        color: Theme.primaryColor
                        font.pixelSize: Theme.fontSizeLarge
                        wrapMode: Text.WordWrap
                        text: rpmInfo.summary
                    }
                }
                Column {
                    width: parent.width
                    spacing: Theme.paddingSmall

                    Label {
                        width: parent.width
                        text: qsTr("Version")
                        font.pixelSize: Theme.fontSizeLarge
                        color: Theme.highlightColor
                        Text {
                            anchors {
                                right: parent.right
                                verticalCenter: parent.verticalCenter
                            }
                            width: parent.width
                            color: Theme.primaryColor
                            font.pixelSize: Theme.fontSizeLarge
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignRight
                            text: rpmInfo.version;
                        }
                    }
                    Label {
                        width: parent.width
                        text: qsTr("Release")
                        font.pixelSize: Theme.fontSizeLarge
                        color: Theme.highlightColor
                        Text {
                            anchors {
                                right: parent.right
                                verticalCenter: parent.verticalCenter
                            }
                            width: parent.width
                            color: Theme.primaryColor
                            font.pixelSize: Theme.fontSizeLarge
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignRight
                            text: rpmInfo.release;
                        }
                    }
                    Label {
                        width: parent.width
                        text: qsTr("License")
                        font.pixelSize: Theme.fontSizeLarge
                        color: Theme.highlightColor
                        Text {
                            anchors {
                                right: parent.right
                                verticalCenter: parent.verticalCenter
                            }
                            width: parent.width
                            color: Theme.primaryColor
                            font.pixelSize: Theme.fontSizeLarge
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignRight
                            text: rpmInfo.license;
                        }
                    }
                    Label {
                        width: parent.width
                        text: qsTr("Space required")
                        font.pixelSize: Theme.fontSizeLarge
                        color: Theme.highlightColor
                        Text {
                            anchors {
                                right: parent.right
                                verticalCenter: parent.verticalCenter
                            }
                            width: parent.width
                            color: Theme.primaryColor
                            font.pixelSize: Theme.fontSizeLarge
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignRight
                            text: qsTr("%1 Kb").arg(rpmInfo.size/1000);
                        }
                    }
                    Label {
                        width: parent.width
                        text: qsTr("Installed")
                        font.pixelSize: Theme.fontSizeLarge
                        color: Theme.highlightColor
                        Text {
                            anchors {
                                right: parent.right
                                verticalCenter: parent.verticalCenter
                            }
                            width: parent.width
                            color: Theme.primaryColor
                            font.pixelSize: Theme.fontSizeLarge
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignRight
                            text: installedPackage !== undefined ? installedPackage.version : ""
                        }
                        visible: installedPackage !== undefined
                    }
                }
                Column {
                    width: parent.width

                    Label {
                        text: qsTr("Description")
                        font.pixelSize: Theme.fontSizeLarge
                        color: Theme.highlightColor
                    }
                    Text {
                        width: parent.width
                        color: Theme.primaryColor
                        font.pixelSize: Theme.fontSizeMedium
                        wrapMode: Text.WordWrap
                        text: rpmInfo.description
                    }
                }
            }
        }
    }


    /*SilicaListView {
        id: listView
        model: 20
        anchors.fill: parent
        header: PageHeader {
            title: "Nested Page"
        }
        delegate: BackgroundItem {
            id: delegate

            Label {
                x: Theme.paddingLarge
                text: "Item " + index
                anchors.verticalCenter: parent.verticalCenter
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: console.log("Clicked " + index)
        }
        VerticalScrollDecorator {}
    }*/
}





