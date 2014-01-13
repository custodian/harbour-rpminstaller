TEMPLATE = app

TARGET = harbour-rpminstaller
target.path = $$INSTALL_ROOT/usr/bin

CONFIG += sailfishapp
CONFIG += link_pkgconfig
PKGCONFIG += sailfishapp
PKGCONFIG += packagekit-qt5

qml.files = qml
qml.path = $$INSTALL_ROOT/usr/share/harbour-rpminstaller

desktop.files = harbour-rpminstaller.desktop
desktop.path = $$INSTALL_ROOT/usr/share/applications

icon.files = harbour-rpminstaller.png
icon.path = $$INSTALL_ROOT/usr/share/icons/hicolor/86x86/apps

INSTALLS += target qml desktop icon

SOURCES += src/harbour-rpminstaller.cpp \
    src/rpminfo.cpp \
    src/packagekitproxy.cpp

OTHER_FILES += qml/harbour-rpminstaller.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-rpminstaller.spec \
    rpm/harbour-rpminstaller.yaml \
    harbour-rpminstaller.desktop \
    qml/pages/About.qml \
    qml/pages/Package.qml \
    qml/pages/Files.qml

HEADERS += \
    src/rpminfo.h \
    src/packagekitproxy.h

