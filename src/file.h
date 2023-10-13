#ifndef EXPORT_H
#define EXPORT_H

#include <QObject>


class File : public QObject
{	  
    Q_OBJECT
public:
	
	Q_INVOKABLE void remove(QString filename);
	Q_INVOKABLE void rename(QString oldname, QString newname);
	Q_INVOKABLE void copy(QString filename, QString dir);

		
		
};

#endif
