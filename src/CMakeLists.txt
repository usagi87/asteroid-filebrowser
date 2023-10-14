add_library(asteroid-filebrowser main.cpp resources.qrc
	file.cpp 
	dir.cpp 
)

target_link_libraries(asteroid-filebrowser PUBLIC
	AsteroidApp)

install(TARGETS asteroid-filebrowser
	DESTINATION ${CMAKE_INSTALL_LIBDIR})
