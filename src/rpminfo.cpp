#include "rpminfo.h"
#include <QFileInfo>
#include <QProcess>
#include <QString>
#include <QDebug>

RPMInfo::RPMInfo(QObject *parent) :
    QObject(parent)
{
}

QString RPMInfo::getPackageSection(QString filename, QString section)
{
    QProcess rpm;
    QStringList args;
    args.push_back("-qp");
    args.push_back("--qf");
    args.push_back(QString("\%{%1}").arg(section));
    args.push_back(filename);
    rpm.start("rpm", args);
    rpm.waitForFinished();
    QByteArray output = rpm.readAll();
    qDebug() << section << "=" << output;
    return output;
}

QStringList RPMInfo::getPackageFiles(QString filename)
{
    QProcess rpm;
    QStringList args;
    args.push_back("-qp");
    args.push_back("--list");
    args.push_back(filename);
    rpm.start("rpm", args);
    rpm.waitForFinished();
    QByteArray output = rpm.readAll();
    return QString(output).split("\n");
}

void RPMInfo::load(QString filename)
{
    qDebug() << "Loading file" << filename;
    QFileInfo fileinfo(filename);
    if (!fileinfo.exists() || !fileinfo.isFile()) {
        qDebug() << "Error in file path";
        emit loadFinished(false);
        return;
    }

    m_name = getPackageSection(filename, "name");
    emit nameChanged();

    m_version = getPackageSection(filename, "version");
    emit versionChanged();

    m_release = getPackageSection(filename, "release");
    emit releaseChanged();

    m_size = getPackageSection(filename, "size");
    emit sizeChanged();

    m_state = getPackageSection(filename, "installtime");
    emit stateChanged();

    m_signature = getPackageSection(filename, "signature");
    emit signatureChanged();

    m_license = getPackageSection(filename, "license");
    emit licenseChanged();

    m_url = getPackageSection(filename, "url");
    emit urlChanged();

    m_summary = getPackageSection(filename, "summary");
    emit summaryChanged();

    m_description = getPackageSection(filename, "description");
    emit descriptionChanged();

    m_filesList = getPackageFiles(filename);
    emit filesListChanged();

    emit loadFinished(true);
}
