global class ContactCreator implements Messaging.InboundEmailHandler {
     
     global string myFile{get;set;}
     
	  global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
		  Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
          
         try{
			for (Messaging.Inboundemail.BinaryAttachment tAttachment : email.binaryAttachments) {	
					myFile = tAttachment.body.toString();
            	}
             XmlStreamReader xsr = new XmlStreamReader(myFile);
             List<Contact> contactList = XmlContactReader.readXml(xsr);
             if(contactList != null && contactList.size() > 0){
                 insert contactList;
                 result.success = true;
             }
            }catch(DMLException e){
                result.success = false;
				result.message = 'Due to Technical Reasons,Your data cannot be Inserted.';
            }
             
          return result;
      }
  }
