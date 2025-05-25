# E-commerce Rails Application

## Содержание
1. [Инструкции по запуску проекта](#инструкции-по-запуску-проекта)
2. [Описание проекта](#описание-проекта)
3. [Документация проекта](#документация-проекта)
4. [Примеры использования](#примеры-использования)
5. [Список использованных источников](#список-использованных-источников)

## Инструкции по запуску проекта

### Системные требования
- Ruby 3.3.0
- Rails 8.0.1
- PostgreSQL
- Node.js и Yarn
- Docker (опционально)

### Установка и запуск
1. Клонирование репозитория:
```bash
git clone <repository-url>
cd individual_work
```

2. Установка зависимостей:
```bash
bundle install
yarn install
```

3. Настройка базы данных:
```bash
rails db:create
rails db:migrate
```

4. Запуск сервера:
```bash
bin/dev
```

### Docker установка
```bash
docker-compose build
docker-compose up
```

## Описание проекта

Проект представляет собой современное веб-приложение электронной коммерции, разработанное с использованием Ruby on Rails 8 и современных веб-технологий. Приложение позволяет пользователям просматривать товары, осуществлять поиск, регистрироваться и совершать покупки.

### Использованные технологии
- Ruby on Rails 8.0.1
- PostgreSQL
- Devise (аутентификация)
- Tailwind CSS
- Hotwire (Turbo & Stimulus)
- Kaminari (пагинация)
- RSpec (тестирование)

## Документация проекта

### Функциональные возможности

#### Для пользователей
- Регистрация и авторизация
- Просмотр каталога товаров
- Поиск товаров
- Просмотр детальной информации о товаре
- Управление профилем

#### Для администраторов
- Управление товарами (CRUD)
- Управление пользователями
- Просмотр статистики

### Сценарии взаимодействия

#### Регистрация пользователя
1. Переход на страницу регистрации
2. Заполнение формы (имя, email, пароль)
3. Подтверждение регистрации

#### Поиск товаров
1. Ввод поискового запроса
2. Просмотр результатов
3. Применение фильтров (если есть)

### Структура базы данных

#### Таблица Users
- id (primary key)
- name (string)
- email (string)
- encrypted_password (string)
- role (string) - user/admin
- created_at (datetime)
- updated_at (datetime)

#### Таблица Products
- id (primary key)
- name (string)
- description (text)
- price (decimal)
- image_url (string)
- created_at (datetime)
- updated_at (datetime)

## Примеры использования

### Код контроллера продуктов
```ruby
class ProductsController < ApplicationController
  def index
    @products = Product.order(created_at: :desc).page(params[:page]).per(12)
  end

  def search
    @products = Product.search(params[:query]).page(params[:page]).per(12)
    render :index
  end
end
```

### Модель пользователя
```ruby
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :role, presence: true, inclusion: { in: %w[user admin] }
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }

  def admin?
    role == 'admin'
  end
end
```

## Список использованных источников

1. [Ruby on Rails Guides](https://guides.rubyonrails.org/)
2. [Devise Documentation](https://github.com/heartcombo/devise)
3. [Tailwind CSS Documentation](https://tailwindcss.com/docs)
4. [Hotwire](https://hotwired.dev/)
5. [Kaminari Documentation](https://github.com/kaminari/kaminari)
