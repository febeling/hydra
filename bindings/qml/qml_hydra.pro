################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  Please refer to the README for information about making permanent changes.  #
################################################################################

TEMPLATE = lib

CONFIG += plugin
QT += qml quick

TARGET = $$qtLibraryTarget(qml_hydra)
uri = QmlHydra

DESTDIR   = $$[QT_INSTALL_QML]/$$replace(uri, \., /)
SRCDIR    = $$PWD/src
BUILDDIR  = $$PWD/build/native

android {
  # Use a default value assuming the hydra project sits outside this one
  isEmpty(HYDRA_ROOT) {
    HYDRA_ROOT = $$clean_path($$PWD/../..)
  }
  !exists($$HYDRA_ROOT) {
    error(The HYDRA_ROOT directory does not exist: $$HYDRA_ROOT)
  }
  # Build the hydra library for android unless it is already built
  !system($$HYDRA_ROOT/builds/qt-android/build.sh) {
    error(Failed to build the hydra C library with $$HYDRA_ROOT/builds/qt-android/build.sh)
  }
  
  VENDOR_PREFIX = $$HYDRA_ROOT/builds/qt-android/prefix/$(TOOLCHAIN_NAME)
  BUILDDIR  = $$PWD/build/$(TOOLCHAIN_NAME)
  QMAKE_LIBDIR += $$VENDOR_PREFIX/lib
  QMAKE_INCDIR += $$VENDOR_PREFIX/include
}

LIBS += -lhydra

HEADERS += \
  $$SRCDIR/qml_hydra_plugin.h \
  $$SRCDIR/QmlHydra.h 

SOURCES += \
  $$SRCDIR/QmlHydra.cpp 

OBJECTS_DIR = $$BUILDDIR/.obj
MOC_DIR     = $$BUILDDIR/.moc
RCC_DIR     = $$BUILDDIR/.rcc
UI_DIR      = $$BUILDDIR/.ui

target.path  = $$DESTDIR
qmldir.files = $$PWD/qmldir
qmldir.path  = $$DESTDIR

OTHER_FILES += $$SRCDIR/qmldir \
               $$SRCDIR/qml/*
#*/

INSTALLS    += target qmldir

# Copy the qmldir file to the same folder as the plugin binary
QMAKE_POST_LINK += \
  $$QMAKE_COPY $$replace($$list($$quote($$SRCDIR/qmldir) $$DESTDIR), /, $$QMAKE_DIR_SEP)

# Copy the dependency shared libraries to the plugin folder (on android only)
android {
  QMAKE_POST_LINK += \
  && $$QMAKE_COPY $$replace($$list($$quote($$VENDOR_PREFIX/lib/*.so)  $$DESTDIR), /, $$QMAKE_DIR_SEP)
}
#*/

# Copy the qml implementation directory to the plugin folder
copyqml.commands = $(COPY_DIR) $$SRCDIR/qml $$DESTDIR
first.depends = $(first) copyqml
export(first.depends)
export(copyqml.commands)
QMAKE_EXTRA_TARGETS += first copyqml

################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  Please refer to the README for information about making permanent changes.  #
################################################################################
