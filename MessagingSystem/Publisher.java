// Add RabbitMQ dependency in pom.xml:
// <dependency>
//   <groupId>com.rabbitmq</groupId>
//   <artifactId>amqp-client</artifactId>
//   <version>5.16.0</version>
// </dependency>

public class Publisher {
    public static void main(String[] args) {
      ConnectionFactory factory = new ConnectionFactory();
      factory.setHost("localhost"); // Read from queue_config.yaml
      try (Connection conn = factory.newConnection();
           Channel channel = conn.createChannel()) {
        channel.exchangeDeclare("xml_exchange", "fanout");
        String xmlData = "<data><item>Sample</item></data>"; 
        channel.basicPublish("xml_exchange", "", null, xmlData.getBytes());
        System.out.println("Sent XML: " + xmlData);
      } catch (Exception e) { e.printStackTrace(); }
    }
  }