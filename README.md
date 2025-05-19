# 🤖 Telegram Kbot на Go

Це Telegram-бот, написаний на Go з використанням [Cobra](https://github.com/spf13/cobra) та [Telebot](https://gopkg.in/telebot.v4).  
Він обробляє текстові повідомлення, відповідає на команди та виводить версію бота.

---

## 📦 Функціональність

- Обробка текстових команд (`hello`, `help`, `ping`)
- Вивід версії через `kbot version`
- Відповідь на запити у Telegram
- Приклад основи CLI застосунку на Go

---

## 🚀 Запуск

1. Отримай токен у [@BotFather](https://t.me/BotFather)
2. Збережи токен у змінну середовища:

```bash
export TELE_TOKEN=123456:ABC-DEF...

go build -ldflags "-X=github.com/artur-nikitenko/telegram-kbot-go/cmd.appVersion=v0.1.0"
```
or

```bash
# Побудувати бінарник під Linux AMD64
make linux
make arm
make macos
make windows
# Побудувати Docker-образ для AMD64
make image
# Запушити його в ghcr.io
make push
# Чистка
make clean
```

## Команди у Telegram
```bash

hello
Hello! I’m Kbot v0.1.0 👋
help
Список доступних команд
ping
pong
.....
🤖 I don’t understand…
```


🔗 Посилання на бота

👉 t.me/artur_kbot_go_bot





