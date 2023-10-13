#include "file.h"
#include <string>
#include <vector>
#include <sstream>
#include <QImage>
#include <QFile>
#include <QDebug>

using namespace std;

void File::remove(QString filename) {
	QFile file (filename);
    if(!file.remove()){
    	qDebug() << "Error: couldn't delete file!";
    } else {
    	qDebug() << "File deleted succesfully.";
    }
}

void File::rename(QString oldname, QString newname) {
	QString oldFile = oldname;
	oldname.truncate(oldname.lastIndexOf("/"));
	QString newFile = oldname + "/" + newname;
	QFile file (oldFile);	
    if(!file.rename(newFile)){
    	qDebug() << "Error: couldn't rename file!";
    } else {
    	qDebug() << "File renamed succesfully.";
    }
}

void File::copy(QString filename, QString dir){
	QFile file (filename);
	QString str = dir + filename.remove(0,filename.lastIndexOf("/"));
	if(!file.copy(str)){
    	qDebug() << "Error: couldn't copy file!";
    } else {
    	qDebug() << "File copied succesfully.";
    }
   
}
