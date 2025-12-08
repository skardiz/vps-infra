#!/bin/bash
set -e

echo "🚀 Initializing development environment for ziix.infra collection..."

# 1. Создаем структуру для коллекции (если её нет)
mkdir -p .ansible/collections/ansible_collections/ziix

# 2. Создаем симлинк, если его еще нет
TARGET_LINK=".ansible/collections/ansible_collections/ziix/infra"
if [ ! -L "$TARGET_LINK" ]; then
    # Используем абсолютный путь для надежности, или относительный ../../../..
    # Относительный лучше для переносимости папки проекта
    ln -s ../../../.. "$TARGET_LINK"
    echo "✅ Symlink created: $TARGET_LINK -> root"
else
    echo "ℹ️  Symlink already exists"
fi

# 3. Устанавливаем зависимости из galaxy.yml / requirements.yml
if [ -f "requirements.yml" ]; then
    echo "📦 Installing dependencies from requirements.yml..."
    ansible-galaxy collection install -r requirements.yml -p .ansible/collections
fi

echo "🎉 Done! You can now run:"
echo "   ansible-playbook playbooks/site.yml"
