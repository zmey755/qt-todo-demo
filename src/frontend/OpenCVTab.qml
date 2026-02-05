import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SmartTodo.Backend

Page {
    id: opencvPage
    padding: 15

    OpenCVProcessor {
        id: opencvProcessor
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 15

        Label {
            text: "Демо: OpenCV обработка изображений"
            font.bold: true
            font.pointSize: 14
            Layout.alignment: Qt.AlignHCenter
        }

        // Версия OpenCV
        Label {
            text: "Используется " + opencvProcessor.getOpenCVVersion()
            color: "blue"
            Layout.alignment: Qt.AlignHCenter
        }

        // Управление
        GridLayout {
            columns: 2
            Layout.fillWidth: true
            rowSpacing: 10
            columnSpacing: 10

            Label { text: "Операция:" }
            ComboBox {
                id: operationCombo
                Layout.fillWidth: true
                model: ["Детекция граней", "Размытие"]
            }

            Label { 
                text: operationCombo.currentIndex === 1 ? "Сила размытия:" : "" 
                visible: operationCombo.currentIndex === 1
            }
            Slider {
                id: blurSlider
                Layout.fillWidth: true
                from: 3
                to: 31
                stepSize: 2
                value: 11
                visible: operationCombo.currentIndex === 1
            }

            Button {
                text: "Применить"
                Layout.columnSpan: 2
                Layout.fillWidth: true
                onClicked: {
                    var imagePath = Qt.resolvedUrl("assets/test_image.jpg")
                    var result
                    
                    if (operationCombo.currentIndex === 0) {
                        result = opencvProcessor.detectEdges(imagePath)
                    } else {
                        result = opencvProcessor.blurImage(imagePath, blurSlider.value)
                    }
                    
                    if (!result.isNull()) {
                        resultImage.source = result
                        statusLabel.text = "Обработка завершена"
                        statusLabel.color = "green"
                    } else {
                        statusLabel.text = "Ошибка обработки"
                        statusLabel.color = "red"
                    }
                }
            }
        }

        // Статус
        Label {
            id: statusLabel
            text: "Готов к работе"
            color: "green"
            Layout.alignment: Qt.AlignHCenter
        }

        // Изображения
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

                    Image {
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
                    text: "Результат OpenCV"
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    border.color: "gray"
                    border.width: 1

                    Image {
                        id: resultImage
                        anchors.fill: parent
                        anchors.margins: 5
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }
        }
    }
}