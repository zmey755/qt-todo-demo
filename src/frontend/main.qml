import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SmartTodo.Backend // Импортируем наш C++ модуль

ApplicationWindow {
    width: 400
    height: 500
    visible: true
    title: qsTr("Демо: Список задач")

    // Создаём экземпляр нашего C++ класса - он доступен в QML
    TodoList {
        id: todoList
    }

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
            model: todoList // Связываем с нашей C++ моделью
            clip: true

            delegate: RowLayout {
                width: listView.width
                spacing: 10

                Label {
                    text: model.display // Роль "display" из C++ модели
                    Layout.fillWidth: true
                }

                Button {
                    text: "Удалить"
                    onClicked: todoList.removeTask(index)
                }
            }
        }
    }
}