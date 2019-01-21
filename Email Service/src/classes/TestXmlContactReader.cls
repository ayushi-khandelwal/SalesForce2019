@isTest
private class TestXmlContactReader {
    // Test that the XML string contains specific values
    static testMethod void testBookParser() {

        XmlContactReader demo = new XmlContactReader();

        String str = '<contacts><contact><name>Sankalp</name><phone>75970839</phone><title>XXX</title><email>sankalp.vyas@gmail.com</email></contact>' +
            '<contact><name>Vyas</name><phone>7412589</phone><title>YYY</title><email>xyz@hji.com</email></contact></contacts>';

        XmlStreamReader reader = new XmlStreamReader(str);
        List<Contact> contacts = XmlContactReader.readXml(reader);

        System.debug(contacts.size());

        for (Contact book : contacts) {
            System.debug(book.FirstName);
        }
    }
}