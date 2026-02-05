import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SmartTodo.Backend

ApplicationWindow {
    width: 800
    height: 600
    visible: true
    title: qsTr("Демо: C++/Qt/QML Приложение")

    TodoList {
        id: todoList
    }

    TabBar {
    id: tabBar
    width: parent.width

    TabButton {
        text: "Список задач"
    }
    TabButton {
        text: "Многопоточность"
    }
    TabButton {
        text: "OpenCV"
              }
    }    

    StackLayout {
        anchors.top: tabBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        currentIndex: tabBar.currentIndex

        // Вкладка 1: Список задач
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            TextField {
                id: taskInput
                Layout.fillWidth: true
                placeholderText: "Введите новую задачу..."
                onAccepted: addButton.clicked()
            }

            Button {
                id: addButton
                text: "Добавить"
                Layout.fillWidth: true
                onClicked: {
                    todoList.addTask(taskInput.text)
                    taskInput.clear()
                }
            }

            Label {
                text: "Список задач:"
                font.bold: true
            }

            ListView {
                id: listView
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: todoList
                clip: true

                delegate: RowLayout {
                    width: listView.width
                    spacing: 10

                    Label {
                        text: model.display
                        Layout.fillWidth: true
                    }

                    Button {
                        text: "Удалить"
                        onClicked: todoList.removeTask(index)
                    }
                }
            }
        }

        // Вкладка 2: Обработка изображений
        Loader {
            source: "ImageProcessingTab.qml"
        }
		// Вкладка 3: OpenCV
        Loader {
        source: "OpenCVTab.qml"
        }
    }
}