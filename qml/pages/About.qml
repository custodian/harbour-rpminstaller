import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        Column {
            id: column

            anchors{
                left: parent.left
                right: parent.right
                margins: Theme.paddingLarge
            }

            spacing: Theme.paddingLarge
            PageHeader {
                title: "RPM Installer"
            }
            Label {
                x: Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter
                text: "About"
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
            }
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                source: "/usr/share/icons/hicolor/86x86/apps/harbour-rpminstaller.png"
            }
            Text {
                width: parent.width
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeMedium
                text: "RPM Installer is a program that assists and guide you through the process of local RPM package installation."
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }
            Text {
                width: parent.width
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeMedium
                text: "You should not launch RPM Installer directly, tap on .rpm package instead, RPM Installer will be launched automatically to assist you."
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeMedium
                text: "<a href='https://openrepos.net/content/basil/rpm-installer'>Web-site (OpenRepos)</a>";
                linkColor: Theme.highlightColor
                onLinkActivated: Qt.openUrlExternally("https://openrepos.net/content/basil/rpm-installer")
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeMedium
                text: "<a href='http://talk.maemo.org/showthread.php?t=92353'>Support forum (Talk Maemo Org)</a>";
                linkColor: Theme.highlightColor
                onLinkActivated: Qt.openUrlExternally("http://talk.maemo.org/showthread.php?t=92353")
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeMedium
                text: "<a href='https://github.com/custodian/harbour-rpminstaller'>Source code (GitHub)</a>";
                linkColor: Theme.highlightColor
                onLinkActivated: Qt.openUrlExternally("https://github.com/custodian/harbour-rpminstaller")
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeMedium
                text: "Basil Semuonov 2014"
            }
        }
    }
}


