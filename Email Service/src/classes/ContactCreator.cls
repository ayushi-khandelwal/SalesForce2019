global class ContactCreator implements Messaging.InboundEmailHandler {
     
     global string myFile{get;set;}
     
	  global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
		  Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
          
         try{
			for (Messaging.Inboundemail.BinaryAttachment tAttachment : email.binaryAttachments) {	
					myFile = tAttachment.body.toString();
                	System.debug(myFile);
            	}
             XmlStreamReader xsr = new XmlStreamReader(myFile);
             List<Contact> contactList = XmlContactReader.readXml(xsr);
             for(Contact contactObject:contactList){
                 System.debug(contactObject);
             }
             if(contactList != null && contactList.size() > 0){
                 insert contactList;
                 result.success = true;
             }
            }catch(DMLException e){
                System.debug(e.getMessage());
                result.success = false;
				result.message = 'Due to Technical Reasons,Your data cannot be Inserted.';
            }
             
          return result;
      }
  }