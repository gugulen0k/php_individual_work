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
git clone https://github.com/gugulen0k/php_individual_work.git
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

## Описание проекта

Проект представляет собой современное веб-приложение электронной коммерции, разработанное с использованием Ruby on Rails 8 и современных веб-технологий. Приложение позволяет пользователям просматривать товары, осуществлять поиск, регистрироваться и совершать покупки.

### Использованные технологии
- Ruby on Rails 8.0.1
- PostgreSQL
- Devise (аутентификация)
- Tailwind CSS
- Hotwire (Turbo & Stimulus)
- Kaminari (пагинация)

## Документация проекта

### Функциональные возможности

#### Для пользователей
- Регистрация и авторизация
- Просмотр каталога товаров
- Поиск товаров
- Просмотр детальной информации о товаре

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

### Структура базы данных

#### Таблица Users (Пользователи)

##### Описание
Таблица `users` управляет учетными записями пользователей и аутентификацией с использованием Devise. Включает в себя поля для аутентификации и личной информации пользователя.

##### Поля
- `id`: Уникальный идентификатор пользователя
- `email`: Адрес электронной почты (уникальный, обязательный)
- `encrypted_password`: Зашифрованный пароль, управляемый Devise (обязательный)
- `reset_password_token`: Токен для сброса пароля
- `reset_password_sent_at`: Время отправки запроса на сброс пароля
- `remember_created_at`: Время создания токена "запомнить меня"
- `first_name`: Имя пользователя
- `last_name`: Фамилия пользователя
- `name`: Полное имя пользователя
- `role`: Роль пользователя (enum: 'user' или 'admin')
- `created_at`: Время создания записи
- `updated_at`: Время последнего обновления записи

#### Таблица Products (Товары)

##### Описание
Таблица `products` хранит информацию о товарах в каталоге магазина.

##### Поля
- `id`: Уникальный идентификатор товара
- `name`: Название товара
- `description`: Подробное описание товара
- `price`: Цена товара
- `image_url`: URL изображения товара
- `featured`: Флаг для отмеченных товаров
- `active`: Флаг активности товара (доступен/недоступен)
- `created_at`: Время создания записи
- `updated_at`: Время последнего обновления записи

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

![image](https://github.com/user-attachments/assets/6d75e913-382c-4013-82f6-dcebb1996dc2)
![image](https://github.com/user-attachments/assets/fb5ef291-94d9-4827-b072-3201ece63efe)
![image](https://github.com/user-attachments/assets/a153a15f-3ead-42d4-a8f7-5f11e577102c)
![image](https://github.com/user-attachments/assets/825c0102-cdc0-4699-af71-800477350462)
![image](https://github.com/user-attachments/assets/54ddf485-e95e-4dee-9739-dcf667562fb2)
![image](https://github.com/user-attachments/assets/302b9057-1041-439d-83d5-a8ef57b0efc5)
![image](https://github.com/user-attachments/assets/d8b5c928-31d8-438a-8168-1bcd1b5d64ed)
![image](https://github.com/user-attachments/assets/4b01e499-1311-44fb-bc7c-98f9fde023ff)

## Список использованных источников

1. [Ruby on Rails Guides](https://guides.rubyonrails.org/)
2. [Devise Documentation](https://github.com/heartcombo/devise)
3. [Tailwind CSS Documentation](https://tailwindcss.com/docs)
4. [Hotwire](https://hotwired.dev/)
5. [Kaminari Documentation](https://github.com/kaminari/kaminari)
