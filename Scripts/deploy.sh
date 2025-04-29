# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
  echo "Docker is not running. Starting Docker..."
  open -a Docker 
  sleep 30
fi

# Start RabbitMQ if not already running
if [ ! "$(docker ps -q -f name=rabbitmq)" ]; then
  docker start rabbitmq || docker run -d --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3-management
fi

# Build Java apps with Maven
cd MessagingSystem
mvn clean package
java -jar target/*.jar &