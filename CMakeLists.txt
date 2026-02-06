cmake_minimum_required(VERSION 3.16)
project(QtTodoDemo VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Quick)
find_package(OpenCV REQUIRED)

add_subdirectory(src/backend)
add_subdirectory(src/frontend)

add_executable(QtTodoDemo src/main.cpp)

target_link_libraries(QtTodoDemo PRIVATE
    SmartTodoBackend
    SmartTodoFrontend
    Qt6::Core
    Qt6::Quick
    ${OpenCV_LIBS}
)