#include "imageprocessor.h"
#include <QDebug>

ImageProcessor::ImageProcessor(QObject *parent)
    : QObject{parent}
{
}

void ImageProcessor::processImage(const QString &imagePath)
{
    // Эмитируем сигнал начала обработки
    emit processingStarted();
    
    // Имитация прогресса
    for (int i = 0; i <= 100; i += 10) {
        QThread::msleep(50); // Имитация задержки
        emit progressChanged(i);
    }

    // Загружаем изображение
    QImage inputImage(imagePath);
    if (inputImage.isNull()) {
        emit errorOccurred("Не удалось загрузить изображение: " + imagePath);
        return;
    }

    // "Тяжёлая" обработка
    QImage result = simulateHeavyProcessing(inputImage);

    // Сигнал о завершении с результатом
    emit processingFinished(result);
    emit progressChanged(100);
}

QImage ImageProcessor::simulateHeavyProcessing(const QImage &input)
{
    // Инвертируем цвета - это наша "тяжёлая операция"
    QImage result = input.convertToFormat(QImage::Format_ARGB32);
    
    for (int y = 0; y < result.height(); ++y) {
        for (int x = 0; x < result.width(); ++x) {
            QColor color = result.pixelColor(x, y);
            color.setRgb(255 - color.red(), 
                        255 - color.green(), 
                        255 - color.blue());
            result.setPixelColor(x, y, color);
        }
    }
    
    return result;
}