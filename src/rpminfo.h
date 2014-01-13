#ifndef RPMINFO_H
#define RPMINFO_H

#include <QObject>
#include <QString>
#include <QStringList>

class RPMInfo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name NOTIFY nameChanged)
    Q_PROPERTY(QString version READ version NOTIFY versionChanged)
    Q_PROPERTY(QString release READ release NOTIFY releaseChanged)
    Q_PROPERTY(QString size READ size NOTIFY sizeChanged)
    Q_PROPERTY(QString state READ state NOTIFY stateChanged)
    Q_PROPERTY(QString signature READ signature NOTIFY signatureChanged)
    Q_PROPERTY(QString license READ license NOTIFY licenseChanged)
    Q_PROPERTY(QString url READ url NOTIFY urlChanged)
    Q_PROPERTY(QString summary READ summary NOTIFY summaryChanged)
    Q_PROPERTY(QString description READ description NOTIFY descriptionChanged)

    Q_PROPERTY(QStringList filesList READ filesList NOTIFY filesListChanged)

public:
    explicit RPMInfo(QObject *parent = 0);

    QString name() const {
        return m_name;
    }
    QString version() const {
        return m_version;
    }
    QString release() const {
        return m_release;
    }
    QString size() const {
        return m_size;
    }
    QString state() const {
        return m_state;
    }
    QString signature() const {
        return m_signature;
    }
    QString license() const {
        return m_license;
    }
    QString url() const {
        return m_url;
    }
    QString summary() const {
        return m_summary;
    }
    QString description() const {
        return m_description;
    }
    QStringList filesList() const {
        return m_filesList;
    }

signals:
    void nameChanged();
    void versionChanged();
    void releaseChanged();
    void sizeChanged();
    void stateChanged();
    void signatureChanged();
    void licenseChanged();
    void urlChanged();
    void summaryChanged();
    void descriptionChanged();
    void filesListChanged();

    void loadFinished(bool success);

public slots:
    void load(QString filename);

protected:
    QString getPackageSection(QString filename, QString section);
    QStringList getPackageFiles(QString filesname);

protected:
    QString m_name;
    QString m_version;
    QString m_release;
    QString m_size;
    QString m_state;
    QString m_signature;
    QString m_license;
    QString m_url;
    QString m_summary;
    QString m_description;
    QStringList m_filesList;

};

#endif // RPMINFO_H
