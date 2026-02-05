#include "todolist.h"

TodoList::TodoList(QObject *parent)
    : QAbstractListModel(parent)
{
    // Добавим пару начальных задач для демонстрации
    m_tasks << "Изучить Qt QML" << "Создать демо-проект";
}

int TodoList::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_tasks.size();
}

QVariant TodoList::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_tasks.size())
        return QVariant();

    if (role == Qt::DisplayRole || role == Qt::EditRole) {
        return m_tasks.at(index.row());
    }

    return QVariant();
}

QHash<int, QByteArray> TodoList::roleNames() const
{
    return { {Qt::DisplayRole, "display"} };
}

void TodoList::addTask(const QString& taskText)
{
    if (taskText.trimmed().isEmpty())
        return;

    beginInsertRows(QModelIndex(), m_tasks.size(), m_tasks.size());
    m_tasks.append(taskText.trimmed());
    endInsertRows();
}

void TodoList::removeTask(int index)
{
    if (index < 0 || index >= m_tasks.size())
        return;

    beginRemoveRows(QModelIndex(), index, index);
    m_tasks.removeAt(index);
    endRemoveRows();
}