# SergeiAvchinnikov_infra
## **Оглавление:**
- [Знакомство с облачной инфраструктурой и облачными сервисами (ДЗ №3)](#ДЗ3)
- [Основные сервисы GCP (ДЗ №4)](#ДЗ4)
- [Модели управления инфраструктурой. Знакомство с Packer. (ДЗ №5)](#ДЗ5)


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
someinternalhost_IP = 10.166.0.3
```
## <a name="ДЗ4"></a>Основные сервисы GCP (ДЗ №4)
+ создаем ветку cloud-testapp
+ переносим файлы из предыдущего задания в папку VPN
+ устанавливаем и проверяем gcloud на рабочую машину
+ создаем новый инстанс (reddit-app), настраиваем ssh config, подключаемся
+ устанавливаем ruby, bundler, mongodb
+ деплоим приложение
+ настраиваем файрволл
+ проверяем доступность приложения
+ создаем скрипты install_ruby.sh, install_mongodb.sh, deploy.sh
+ сoздаем startup script startup.sh
+ все проверяем

```
testapp_IP = 35.228.80.6
testapp_port = 9292
```

+ создаем правило для файрволла из консоли с помощью gcloud:
```
gcloud compute firewall-rules create default-puma-server\
  --description="rules for puma-server for test app"\
  --direction=INGRESS\
  --priority=1000\
  --network=default\
  --action=ALLOW\
  --rules=tcp:9292\
  --source-ranges=0.0.0.0/0\
  --target-tags=puma-server
```

## <a name="ДЗ5"></a> Модели управления инфраструктурой. Знакомство с Packer.(ДЗ №5)
+ создаем новую ветку packer-base
+ переносим файлы прошлого задания в папку config-scripts
+ скачиваем, распаковываем и проверяем рабуту packer
+ создаем ADC
+ собираем образ по примеру ubuntu16.json, создаем на его основе экземпляр VM, деплоим приложение, проверяем его работу
+ параметризуем ubuntu16.json переменными variables.json, добавляем в гитигнор, создаем variables.json.example
+ собираем образ, на его основе экземпляр VM, деплоим приложение, проверяем его работу
+ пробуем bake подход: образ reddit-full создаем на базе reddit-base, добавляя туда деплой плиложения и настройку его автозапуска, создаем VM, проверяем
+ создаем скрипт create-reddit-vm.sh для создания VM с помощью командной строки
и утилиты gcloud

