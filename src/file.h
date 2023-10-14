#ifndef MANAGER_H
#define MANAGER_H

#include <QObject>


class File : public QObject
{	  
    Q_OBJECT
public:
	
	Q_INVOKABLE bool remove(QString filename);
	Q_INVOKABLE bool rename(QString oldname, QString newname);
	Q_INVOKABLE bool copy(QString filename, QString dir);

		
		
};

#endif
