## Описание
![GMS v2.3](1.png)

> Бесплатный движок мониторинга игровых серверов **с открытым исходным кодом**.

> **Основные возможности**:   
> Покупка платных услуг, регистрация, авторизация, восстановление пароля.   
> Модуль буста, листинг, банлист.   
> Пополнение счета: **Unitpay**, **Robokassa**, **FreeKassa**, **UnitPay**, **Qiwi**.   
> Интеграция с хостинг провайдерами.

> **Панель управления администратора**:   
> Управления пользователями, серверами, создание статистических страниц, основные настройки, способы оплаты, резервные копии, отслеживание логов с фильтром.



## Cистемные требования
* php 7.4 или выше
* mysql 5.6 или выше
* Curl
* Планировщик задач
* Открытыие udp/tcp порты
* curl, mbstring, bz2, short_tags (короткие теги), gd
* Данные доступа: **логин:** admin@gamems.ru **пароль:**  admin123

\newpage
## Настройка крон задач
php bin/console cron - обновления игровых серверов
php bin/console payment - проверка истекших счетов
php bin/console qiwi - проверка платежей киви
php bin/console services - проверка платных услуг на истечение

**Страница успешной оплаты:** [https://mysite.ru/result/success](https://mysite.ru/result/success)  
**Страница провальной оплаты:** [https://mysite.ru/result/fail](https://mysite.ru/result/fail)


## API
Запрос отправляется на адрес [https://mysite.ru/api](https://mysite.ru/api) методом `POST` либо `GET`   
**Список обязательных параметров:**

1. login – логин пользователя
2. sv – Адрес сервера Ип:порт
3. services – ид услуги
4. key – ключ апи
5. game - игра(Список доступных игр п1.2)


### Список доступных игр

| Название игры                    | Кодовое значение |
|----------------------------------|------------------|
| Counter Strike 1.6               | cs               |
| Counter-Strike: Global Offensive | csgo             |
| Counter Strike Sourse            | css              |
| Team Fortress 2                  | tf2              |
| Left 4 Dead 2                    | ld2              |


Ответ возвращается в json формате

В случае успешного запроса возвращается ответ: `{“status”: “success”}`

В противном случае: {“status”: “error”}
с сообщением **message** и **code**


### Список кодовых ответов

| Код ответа (code) | Описание                                          |
|-------------------|---------------------------------------------------|
| server_is_banned  | Сервер забанен в сервиск                          |
| purchased         | Услуга успешно куплена                            |
| no_money          | Недостаточно средств на счете партнера            |
| no_service        | Услуга не найдно                                  |
| no_valid_key      | Неверный Апи ключ                                 |
| no_params         | Не передан 1 или более из обязательных параметров |



## Документация
[https://game-ms.ru/documentation.html](https://game-ms.ru/documentation.html)
	
