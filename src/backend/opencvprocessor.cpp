#include "opencvprocessor.h"
#include <QDebug>

OpenCVProcessor::OpenCVProcessor(QObject *parent)
    : QObject{parent}
{
}

QImage OpenCVProcessor::detectEdges(const QString &imagePath)
{
    try {
        cv::Mat image = cv::imread(imagePath.toStdString(), cv::IMREAD_COLOR);
        if (image.empty()) {
            qWarning() << "Не удалось загрузить изображение:" << imagePath;
            return QImage();
        }

        cv::Mat gray;
        cv::cvtColor(image, gray, cv::COLOR_BGR2GRAY);

        cv::Mat edges;
        cv::Canny(gray, edges, 100, 200);

        cv::Mat result;
        cv::cvtColor(edges, result, cv::COLOR_GRAY2BGR);

        return matToQImage(result);
    }
    catch (const cv::Exception &e) {
        qCritical() << "OpenCV error:" << e.what();
        return QImage();
    }
}

QImage OpenCVProcessor::blurImage(const QString &imagePath, int kernelSize)
{
    try {
        cv::Mat image = cv::imread(imagePath.toStdString(), cv::IMREAD_COLOR);
        if (image.empty()) {
            return QImage();
        }

        cv::Mat blurred;
        cv::GaussianBlur(image, blurred, 
                        cv::Size(kernelSize, kernelSize), 0);

        return matToQImage(blurred);
    }
    catch (const cv::Exception &e) {
        qCritical() << "OpenCV error:" << e.what();
        return QImage();
    }
}

QString OpenCVProcessor::getOpenCVVersion()
{
    return QString("OpenCV %1").arg(CV_VERSION);
}

cv::Mat OpenCVProcessor::qImageToMat(const QImage &image)
{
    QImage conv = image.convertToFormat(QImage::Format_RGB888);
    return cv::Mat(conv.height(), conv.width(), 
                  CV_8UC3, const_cast<uchar*>(conv.bits()), 
                  conv.bytesPerLine());
}

QImage OpenCVProcessor::matToQImage(const cv::Mat &mat)
{
    if (mat.type() == CV_8UC1) {
        QImage image(mat.data, mat.cols, mat.rows, 
                    mat.step, QImage::Format_Grayscale8);
        return image.copy();
    }
    else if (mat.type() == CV_8UC3) {
        cv::Mat rgb;
        cv::cvtColor(mat, rgb, cv::COLOR_BGR2RGB);
        QImage image(rgb.data, rgb.cols, rgb.rows, 
                    rgb.step, QImage::Format_RGB888);
        return image.copy();
    }
    
    return QImage();
}