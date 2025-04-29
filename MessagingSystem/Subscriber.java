import com.rabbitmq.client.*;
import java.nio.charset.StandardCharsets;

public class Subscriber {
    public static void main(String[] args) {
      try {
        ConnectionFactory factory = new ConnectionFactory();
        factory.setHost("localhost");
        factory.setPort(5672);
        factory.setUsername("guest");
        factory.setPassword("guest");
        Connection conn = factory.newConnection();
        Channel channel = conn.createChannel();
        channel.queueDeclare("xml_queue", false, false, false, null);
        channel.queueBind("xml_queue", "xml_exchange", "");
        
        DeliverCallback callback = (consumerTag, delivery) -> {
          String xml = new String(delivery.getBody(), StandardCharsets.UTF_8);
          XMLParser.parseAndTransform(xml); 
        };
        channel.basicConsume("xml_queue", true, callback, consumerTag -> {});
      } catch (Exception e) { e.printStackTrace(); }
    }
  }