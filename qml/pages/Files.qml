import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    property variant filesList

    SilicaListView{
        id: filesView
        clip: true
        anchors {
            fill: parent
            margins: Theme.paddingLarge
        }
        header: PageHeader{
            title: qsTr("Files in package");
        }
        model: filesList
        delegate: fileDelegate
    }

    Component {
        id: fileDelegate

        Text {
            width: filesView.width
            color: Theme.primaryColor
            text: modelData
            wrapMode: Text.WordWrap
        }
    }

}


