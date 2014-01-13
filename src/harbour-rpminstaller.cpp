#include <QtQuick>

#include <sailfishapp.h>
#include <QProcess>
#include <QDir>
#include "rpminfo.h"
#include "packagekitproxy.h"

int main(int argc, char *argv[])
{
    qmlRegisterType<RPMInfo>("net.thecust.rpminfo", 1, 0, "RPMInfo");
    qmlRegisterType<PackageKitProxy>("net.thecust.packagemanager", 1, 0, "PkgManagerProxy");

    QDir appdir;
    appdir.mkpath(QString("%1/.local/share/applications").arg(QDir::homePath()));
    QProcess xdg;
    QStringList args;
    args.push_back("default");
    args.push_back("harbour-rpminstaller.desktop");
    args.push_back("application/x-rpm");
    xdg.start("xdg-mime", args);
    xdg.waitForFinished();

    return SailfishApp::main(argc, argv);
}

