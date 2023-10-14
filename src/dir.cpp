#include "dir.h"
#include <string>
#include <vector>
#include <sstream>
#include <QImage>
#include <QDir>
#include <QDebug>

using namespace std;


bool Dir::createDir(QString dirname){
	QDir dir;
	if(!dir.exists(dirname)) {
		if(!dir.mkdir(dirname)){
			qDebug() << "Error creating directory!";
			return false;
		} else {
			qDebug() << "Directory created succesfully.";
			return true;
		}
	}else {
		qDebug() << "Error directory already exits!";
		return false; 
	}
}

bool Dir::removeDir(QString dirname){
	QDir tmp (dirname);
	QDir dir;
	if (tmp.isEmpty()) {
		if(!dir.rmdir(dirname)){
			qDebug() << "Error deleting directory!";
			return false;
		}else {
			qDebug() << "Directory deleted succesfully.";
			return true;
		}
	}else {
		qDebug() << "Error: directory is not empty";
		return false;
	}
}
