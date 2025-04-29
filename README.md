Requirements
Java SDK
RabbitMQ

Run RabbitMQ
cd "c:\Users\PARZIV4L\Downloads\avii\Final_Project\"
Scripts\deploy.ps1

Run Subscriber
cd "c:\Users\PARZIV4L\Downloads\avii\Final_Project\MessagingSystem"
java -cp ".;../lib/amqp-client-5.25.0.jar;../lib/slf4j-api-1.7.36.jar;../lib/slf4j-simple-1.7.36.jar" Subscriber

Run Publisher
cd "c:\Users\PARZIV4L\Downloads\avii\Final_Project\MessagingSystem"
java -cp ".;../lib/amqp-client-5.25.0.jar;../lib/slf4j-api-1.7.36.jar;../lib/slf4j-simple-1.7.36.jar" Publisher