/*
################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  Please refer to the README for information about making permanent changes.  #
################################################################################
*/

#ifndef QML_HYDRA_LEDGER_H
#define QML_HYDRA_LEDGER_H

#include <QtQml>

#include <hydra.h>
#include "qml_hydra_plugin.h"


class QmlHydraLedger : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isNULL READ isNULL)
    
public:
    hydra_ledger_t *self;
    
    QmlHydraLedger() { self = NULL; }
    bool isNULL() { return self == NULL; }
    
    static QObject* qmlAttachedProperties(QObject* object); // defined in QmlHydraLedger.cpp
    
public slots:
    //  Return ledger size, i.e. number of posts stored in the ledger.
    size_t size ();

    //  Load the ledger data from disk, from the specified directory. Returns 
    //  the number of posts loaded, or -1 if there was an error reading the   
    //  directory.                                                            
    int load ();

    //  Save a post via the ledger. This saves the post to disk, adds the post
    //  to the ledger, and then destroys the post. Use in place of            
    //  hydra_post_save to ensure post filenames are correctly generated.     
    int store (QmlHydraPost *postP);

    //  Return post at specified index; if the index does not refer to a valid
    //  post, returns NULL.                                                   
    QmlHydraPost *fetch (int index);

    //  Lookup post in ledger and return post index (0 .. size - 1); if the post
    //  does not exist, returns -1.                                             
    int index (const QString &postId);
};

class QmlHydraLedgerAttached : public QObject
{
    Q_OBJECT
    QObject* m_attached;
    
public:
    QmlHydraLedgerAttached (QObject* attached) {
        Q_UNUSED (attached);
    };
    
public slots:
    //  Self test of this class
    void test (bool verbose);

    //  Create a new empty ledger instance.
    QmlHydraLedger *construct ();

    //  Destroy the ledger
    void destruct (QmlHydraLedger *qmlSelf);
};


QML_DECLARE_TYPEINFO(QmlHydraLedger, QML_HAS_ATTACHED_PROPERTIES)

#endif
/*
################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  Please refer to the README for information about making permanent changes.  #
################################################################################
*/
