#pragma once

#include <QObject>
#include <QImage>
#include <QString>
#include <opencv2/opencv.hpp>

class OpenCVProcessor : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

public:
    explicit OpenCVProcessor(QObject *parent = nullptr);

public slots:
    Q_INVOKABLE QImage detectEdges(const QString &imagePath);
    Q_INVOKABLE QImage blurImage(const QString &imagePath, int kernelSize);
    Q_INVOKABLE QString getOpenCVVersion();

private:
    cv::Mat qImageToMat(const QImage &image);
    QImage matToQImage(const cv::Mat &mat);
};