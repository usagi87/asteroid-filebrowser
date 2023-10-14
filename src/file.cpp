#include "file.h"
#include <string>
#include <vector>
#include <sstream>
#include <QImage>
#include <QFile>
#include <QDebug>

using namespace std;

bool File::remove(QString filename) {
	QFile file (filename);
	if(file.exists()) {
    	if(!file.remove()){
    		qDebug() << "Error: couldn't delete file!";
    		return false;
    	} else {
    		qDebug() << "File deleted succesfully.";
    		return true;
    	}
    }else {
    	qDebug() << "Error: file already exist!";
    	return false;
    }
}

bool File::rename(QString oldname, QString newname) {
	QString oldFile = oldname;
	oldname.truncate(oldname.lastIndexOf("/"));
	QString newFile = oldname + "/" + newname;
	QFile file (oldFile);
	if(file.exists()){	
    	if(!file.rename(newFile)){
    		qDebug() << "Error: couldn't rename file!";
    		return false;
    	} else {
    		qDebug() << "File renamed succesfully.";
    		return true;
    	}
    }else{
    	qDebug() << "Error: file already exists!";
    	return false;
    }
}

bool File::copy(QString filename, QString dir){
	QFile file (filename);
	QString str = dir + filename.remove(0,filename.lastIndexOf("/"));
	if(file.exists()) {
		if(!file.copy(str)){
    		qDebug() << "Error: couldn't copy file!";
    		return false;
    	} else {
    		qDebug() << "File copied succesfully.";
    		return true;
    	}
    } else{
    	qDebug() << "Error: file already exists!";
    	return false;
    }
   
}
