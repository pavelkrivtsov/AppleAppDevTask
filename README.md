# AppleAppDevTask

<img src="https://github.com/pavelkrivtsov/AppleAppDevTask/assets/72617749/16745d62-b7e0-403f-a1cc-18a8328ad6e2" width="250" height="500" /> <img src="https://github.com/pavelkrivtsov/AppleAppDevTask/assets/72617749/1b344536-e3b4-45e8-8990-9a635caeef3d" width="250" height="500" /> <img src="https://github.com/pavelkrivtsov/AppleAppDevTask/assets/72617749/e06de995-c146-48c4-8ac6-f28798ad6c15" width="250" height="500" />

Требуется реализовать экран загрузки карт компаний. 

Экран – это динамический список карт компаний, который подгружается
порционно с сервера. Верстка экрана осуществляется согласно
Макету

Подгрузка с сервера
осуществляется с параметром offset – текущее суммарное количество загруженных карт.
При первичном запуске приложения во время подгрузки показывается прелоудер.
При пролистывании до конца массива показывается прелоудер (внизу списка) и идет
подгрузка следующей порции данных. Если с сервера пришел пустой массив,
то подгрузка завершена, больше ее осуществлять не нужно при пролистывании до конца списка.

Запросы к серверу находятся в файле TaskForAppleAppDelelopers.postman_collection.json
На финальной версии требуется подключить только один запрос getAllCards
Для тестировки имеется 3 дополнительных запроса Ideal – не выдает ошибок при подгрузке,
Long – с задержкой ответа для тестирования прелоудера и Error – выдает ошибки.
Финальный запрос getAllCards с определенной вероятностью моделирует ожидание и ошибки.

При подключении необходимо корректно обрабатывать различные ошибки:
код ответа 401 (требуется вывести стандартный алерт с текстом «ошибка авторизации»)
код ответа 400 (требуется вывести стандартный алерт с текстом message – из ответа с сервера)
код ответа 500 (требуется вывести стандартный алерт с текстом «все упало»)
стандартный алерт с кнопкой окей – его закрывающей.