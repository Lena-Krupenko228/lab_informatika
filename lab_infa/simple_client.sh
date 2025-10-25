SERVER_IP="localhost"
PORT=12345
MESSAGE="Привет, сервер!"
echo "Отправка сообщения на $SERVER_IP:$PORT..."
echo "$MESSAGE" | nc $SERVER_IP $PORT
