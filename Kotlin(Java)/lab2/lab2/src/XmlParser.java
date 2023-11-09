import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.File;
import java.io.IOException;

public class XmlParser extends Parser {
    @Override
    public AddressList parse(String fileName) throws IllegalArgumentException {
        if (!fileExtensionIsValid(fileName)) {
            throw new IllegalArgumentException();
        }

        AddressList addresses = new AddressList();

        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
//        factory.setNamespaceAware(false);
//        factory.setValidating(false);
//        try {
//            factory.setFeature("http://xml.org/sax/features/namespaces", false);
//            factory.setFeature("http://xml.org/sax/features/validation", false);
//            factory.setFeature("http://apache.org/xml/features/nonvalidating/load-dtd-grammar", false);
//            factory.setFeature("http://apache.org/xml/features/nonvalidating/load-external-dtd", false);
//        } catch (ParserConfigurationException e) {
//            throw new RuntimeException(e);
//        }

        try {
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(new File(fileName));
            NodeList items = doc.getElementsByTagName("item");
            for (int i = 0; i < items.getLength(); i++) {
                NamedNodeMap attributes = items.item(i).getAttributes();
                String city = attributes.getNamedItem("city").getNodeValue();
                String street = attributes.getNamedItem("street").getNodeValue();
                Integer house = Integer.parseInt(attributes.getNamedItem("house").getNodeValue());
                Integer floor = Integer.parseInt(attributes.getNamedItem("floor").getNodeValue());
                addresses.addAddress(city, street, house, floor);
            }
        } catch (ParserConfigurationException | IOException | SAXException e) {
            throw new RuntimeException(e);
        } catch (NumberFormatException e) {
            System.out.println("One or more house or floor attributes in file are not a number");
        }

        return addresses;
    }

    private Boolean fileExtensionIsValid(String fileName) {
        int i = fileName.lastIndexOf('.');
        String extension;
        if (i != -1) {
            extension = fileName.substring(i + 1);
        } else {
            return false;
        }

        return extension.equals("xml");
    }
}
