#ifndef DIRECTORY_H
#define DIRECTORY_H

#include <QObject>


class Dir : public QObject
{	  
    Q_OBJECT
public:
	
	Q_INVOKABLE bool createDir(QString dirname);
	Q_INVOKABLE bool removeDir(QString dirname);
};

#endif
