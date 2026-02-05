import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SmartTodo.Backend

Page {
    id: processingPage
    padding: 10

    ColumnLayout {
        anchors.fill: parent
        spacing: 15

        Label {
            text: "Демо: Многопоточная обработка изображений"
            font.bold: true
            font.pointSize: 14
            Layout.alignment: Qt.AlignHCenter
        }

        // Объект процессора
        ImageProcessor {
            id: imageProcessor
        }

        // Выбор файла
        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Label {
                text: "Выберите изображение:"
                Layout.fillWidth: true
            }

            Button {
                text: "Загрузить тестовое"
                onClicked: {
                    // Используем встроенное изображение для демо
                    var testImage = Qt.resolvedUrl("assets/test_image.jpg")
                    imageProcessor.processImage(testImage)
                }
            }
        }

        // Прогресс-бар
        ProgressBar {
            id: progressBar
            Layout.fillWidth: true
            from: 0
            to: 100
            value: 0
            visible: false
        }

        // Статус
        Label {
            id: statusLabel
            text: "Готов к работе"
            color: "green"
        }

        // Изображения до/после
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 20

            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Label {
                    text: "Исходное изображение"
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    border.color: "gray"
                    border.width: 1
                    color: "transparent"

                    Image {
                        id: sourceImage
                        anchors.fill: parent
                        anchors.margins: 5
                        fillMode: Image.PreserveAspectFit
                        source: "assets/test_image.jpg"
                    }
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Label {
                    text: "Результат обработки"
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    border.color: "gray"
                    border.width: 1
                    color: "transparent"

                    Image {
                        id: resultImage
                        anchors.fill: parent
                        anchors.margins: 5
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }
        }

        // Кнопка обработки
        Button {
            text: "Запустить обработку"
            Layout.alignment: Qt.AlignHCenter
            enabled: !progressBar.visible

            onClicked: {
                var testImage = Qt.resolvedUrl("assets/test_image.jpg")
                imageProcessor.processImage(testImage)
            }
        }
    }

    // Подключение сигналов процессора
    Connections {
        target: imageProcessor

        function onProcessingStarted() {
            statusLabel.text = "Обработка началась..."
            statusLabel.color = "orange"
            progressBar.visible = true
            progressBar.value = 0
        }

        function onProgressChanged(percent) {
            progressBar.value = percent
            statusLabel.text = "Обработка: " + percent + "%"
        }

        function onProcessingFinished(result) {
            statusLabel.text = "Обработка завершена!"
            statusLabel.color = "green"
            progressBar.visible = false
            resultImage.source = result
        }

        function onErrorOccurred(message) {
            statusLabel.text = "Ошибка: " + message
            statusLabel.color = "red"
            progressBar.visible = false
        }
    }
}