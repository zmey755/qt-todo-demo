#pragma once

#include <QAbstractListModel>
#include <QObject>

class TodoList : public QAbstractListModel
{
    Q_OBJECT
    // Это макросы для интеграции с QML 
    QML_ELEMENT
    QML_SINGLETON

public:
    explicit TodoList(QObject *parent = nullptr);

    // Обязательные методы для работы модели в QML
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    // Метод, который можно будет вызывать из QML
    Q_INVOKABLE void addTask(const QString& taskText);
    Q_INVOKABLE void removeTask(int index);

private:
    QStringList m_tasks; // Пока просто список строк
};