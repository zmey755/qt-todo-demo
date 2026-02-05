#pragma once

#include <QObject>
#include <QImage>
#include <QThread>

class ImageProcessor : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

public:
    explicit ImageProcessor(QObject *parent = nullptr);

public slots:
    // Слот для запуска обработки (будет вызываться из QML)
    Q_INVOKABLE void processImage(const QString &imagePath);

signals:
    void processingStarted();
    void processingFinished(const QImage &result);
    void progressChanged(int percent);
    void errorOccurred(const QString &message);

private:
    // Приватная функция, имитирующая долгую операцию
    QImage simulateHeavyProcessing(const QImage &input);
};