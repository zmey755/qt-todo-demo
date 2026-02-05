set(BACKEND_SOURCES
    todolist.cpp
    todolist.h
)

# Эта команда делает наш C++ класс доступным в QML
qt_add_qml_module(SmartTodoBackend
    URI SmartTodo.Backend
    VERSION 1.0
    SOURCES ${BACKEND_SOURCES}
)