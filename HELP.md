Тестовое задание

Поднимает три контейнера: приложение с рест контроллером, кафка и бд постгрес

не доделаны: функции связанные с исполнителем таски

урл http://localhost:8080/api/tasks?page=0




#sudo docker-compose up -d

#с пересборкой приложения
#sudo docker-compose up --build -d

#(если docker-compose не работает)
#sudo docker start testproject-postgres
#sudo docker start testproject-kafka
#sudo docker start testproject-app

#Проверка что всё работает
#sudo docker ps

#Проврка
#curl http://localhost:8080/testproject/api/tasks

#Остановка всех контейнеров
#sudo docker-compose down

#или 
#sudo docker stop testproject-app testproject-postgres testproject-kafka

#Перезапуск конкретного контейнера
#sudo docker restart testproject-app

#Логи
#sudo docker logs -f testproject-app

#Пересборка
#sudo docker-compose down
#sudo docker-compose up --build -d

#удалить и собрать
#sudo docker rm testproject-app
#sudo docker-compose up -d
