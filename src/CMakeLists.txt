add_library(asteroid-filebrowser main.cpp file.cpp file.h resources.qrc)

target_link_libraries(asteroid-filebrowser PUBLIC
	AsteroidApp)

install(TARGETS asteroid-filebrowser
	DESTINATION ${CMAKE_INSTALL_LIBDIR})
