Сделайте скрипт исполняемым:
chmod +x /usr/local/bin/check_fail2ban.sh

Добавьте пользовательский параметр В конфигурационный файл Zabbix агента (и классического, и Agent2) добавьте строку:

Для классического агента (zabbix_agentd.conf):
UserParameter=service.status.fail2ban,/usr/local/bin/check_fail2ban.sh

Для Agent2 (zabbix_agent2.conf):
UserParameter=service.status.fail2ban,/usr/local/bin/check_fail2ban.sh

После этого перезапустите агент:
sudo systemctl restart zabbix-agent  # Для классического агента
sudo systemctl restart zabbix-agent2  # Для Agent2

Проверьте работу параметра Проверьте вручную, возвращает ли пользовательский параметр корректные значения:
zabbix_agentd -t service.status.fail2ban  # Для классического агента
zabbix_agent2 -t service.status.fail2ban  # Для Agent2

Ожидаемые результаты:

1 — Служба работает.
0 — Служба остановлена.
-1 — Неизвестный статус (например, fail2ban не установлен).


Добавьте элемент данных в Zabbix В веб-интерфейсе Zabbix:
Имя: Статус службы fail2ban.
Тип: Zabbix агент.
Ключ: service.status.fail2ban.
Тип информации: Числовое (целое).


Создайте триггер для отображения текста Задайте триггер, который будет конвертировать числовое значение в текст:

Для значений 1 (активная служба):


{host:service.status.fail2ban.last()}=1
Имя триггера: "Fail2ban работает"
Сообщение: "Служба fail2ban активна на {HOST.NAME}"
Для значений 0 (служба остановлена):

{host:service.status.fail2ban.last()}=0
Имя триггера: "Fail2ban не работает"
Сообщение: "Служба fail2ban неактивна на {HOST.NAME}"
Для значений -1 (неизвестный статус):

{host:service.status.fail2ban.last()}=-1
Имя триггера: "Неизвестный статус fail2ban"
Сообщение: "Неизвестный статус службы fail2ban на {HOST.NAME}"


dos2unix /usr/local/bin/check_fail2ban.sh - при необохдиости


