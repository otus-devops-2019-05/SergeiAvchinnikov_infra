# SergeiAvchinnikov_infra
## **Оглавление:**
- [Знакомство с облачной инфраструктурой и облачными сервисами (ДЗ №3)](#ДЗ3)

## <a name="ДЗ3"></a>Знакомство с облачной инфраструктурой и облачными сервисами (ДЗ №3)
+ создаем ветку cloud-bastion
+ регистрируемся в GCP
+ создаем проект Infra
+ генерируем ключи ssh и добавляем в метаданные проекта
+ создаем экземпляр VM bastion
+ подключаемся к bastion по внешнему IP
+ создаем экземпляр VM someinternahost (без внешней сети)
+ заходим по SSH на bastion, оттуда по внутреннему адресу пытаемся зайти на someinternalhost (так не работает)
+ настраиваем и проверяем ssh forwarding
+ выполняем самостоятельное задание:
  1. `ssh -A -t appuser@35.228.245.152 -A -t 10.166.0.3` - подключение в одну строку
  2.  создаем файл ssh config:
``` 
  cat <<EOF> ~/.ssh/config
  Host bastion
    Hostname 35.228.245.152
    IdentityFile  ~/.ssh/appuser
    User appuser
  
  Host someinternalhost
    Hostname 10.166.0.3
    IdentityFile  ~/.ssh/appuser
    ForwardAgent yes
    User appuser
    ProxyCommand ssh -W %h:%p appuser@bastion
  EOF
```
делаем `chmod 400 ~/.ssh/config (с другими правами не работаем)`

подключаемся `ssh someinternalhost`

+ настраиваем VPN
+ добавляем параметры подключения в README.md

```
bastion_IP = 35.228.245.152
someinternalhots_IP = 10.166.0.3
```
