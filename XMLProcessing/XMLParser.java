public class XMLParser {
    public static void parseAndTransform(String xml) {
      try {
        // Parse XML
        DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
        Document doc = builder.parse(new InputSource(new StringReader(xml)));
        
        // Transform using XSL
        Transformer transformer = TransformerFactory.newInstance()
            .newTransformer(new StreamSource("XMLProcessing/transform.xsl"));
        String outputPath = "XMLProcessing/output/result_" + System.currentTimeMillis() + ".html";
        transformer.transform(new DOMSource(doc), new StreamResult(new File(outputPath)));
        
        System.out.println("Transformed to: " + outputPath);
      } catch (Exception e) { e.printStackTrace(); }
    }
  }