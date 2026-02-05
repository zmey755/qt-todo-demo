set(BACKEND_SOURCES
    todolist.cpp
    todolist.h
    imageprocessor.cpp   
    imageprocessor.h  
    opencvprocessor.cpp
    opencvprocessor.h    
)

qt_add_qml_module(SmartTodoBackend
    URI SmartTodo.Backend
    VERSION 1.0
    SOURCES ${BACKEND_SOURCES}
)