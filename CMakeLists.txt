cmake_minimum_required(VERSION 3.16)
project(QtTodoDemo VERSION 0.1.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_AUTOMOC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Quick)

add_subdirectory(src)