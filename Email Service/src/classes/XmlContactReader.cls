public class XmlContactReader {
    
    public static List<Contact> readXml(XmlStreamReader reader){
        List<Contact> contactList = new List<Contact>();
        boolean isSafeToGetNextXmlElement = true;
        while(isSafeToGetNextXmlElement) {
            if (reader.getEventType() == XmlTag.START_ELEMENT) {  
                if ('contact' == reader.getLocalName()) {
                    Contact contactObj = parseContact(reader);
                    contactList.add(contactObj);
                }
            }
            if (reader.hasNext()) {
                reader.next();
            } else {
                isSafeToGetNextXmlElement = false;
                break;
            }
        }
        return contactList;
    }
    
    public static Contact parseContact(XmlStreamReader reader){
        Contact contactObject = new Contact();
        boolean isSafeToGetNextXmlElement = true;
        while(isSafeToGetNextXmlElement) {
            if (reader.getEventType() == XmlTag.END_ELEMENT && 'contact' == reader.getLocalName()) {
                break;
            }else if(reader.getEventType() == XmlTag.START_ELEMENT && 'name' == reader.getLocalName()){
                if (reader.hasNext()) {
                    reader.next();
                    if(reader.getEventType() == XmlTag.CHARACTERS){
                        contactObject.LastName = reader.getText();
                    }
                }
            }else if(reader.getEventType() == XmlTag.START_ELEMENT && 'phone' == reader.getLocalName()){
                if (reader.hasNext()) {
                    reader.next();
                    if(reader.getEventType() == XmlTag.CHARACTERS){
                        contactObject.Phone = reader.getText();
                    }
                }
            }else if(reader.getEventType() == XmlTag.START_ELEMENT && 'title' == reader.getLocalName()){
                if (reader.hasNext()) {
                    reader.next();
                    if(reader.getEventType() == XmlTag.CHARACTERS){
                        contactObject.Title = reader.getText();
                    }
                }
            }else if(reader.getEventType() == XmlTag.START_ELEMENT && 'email' == reader.getLocalName()){
                if (reader.hasNext()) {
                    reader.next();
                    if(reader.getEventType() == XmlTag.CHARACTERS){
                        contactObject.Email = reader.getText();
                    }
                }
            }
            
            if (reader.hasNext()) {
                reader.next();
            } else {
                isSafeToGetNextXmlElement = false;
                break;
            }
        }
        return contactObject;
    }
    
}
