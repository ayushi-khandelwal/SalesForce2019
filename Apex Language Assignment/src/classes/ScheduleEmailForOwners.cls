global class ScheduleEmailForOwners implements Schedulable{
    
      global void execute(SchedulableContext ctx) {
       		OpportunityService opportunityServiceObject = new OpportunityService();
       		List<Opportunity> opportunityList = opportunityServiceObject.opportunityLastModifiedLastMonth();
       		Map<Id,Opportunity> userIdOpportunity = new Map<Id,Opportunity>();
       		for(Opportunity opportunityObject:OpportunityList){
       			userIdOpportunity.put(opportunityObject.ownerId,opportunityObject);
       		}
       		List<User> userList = [Select Id,Name,email From User Where Id In : userIdOpportunity.keyset()];
       		String[] addresses = new String[]{},
            	 subjects = new String[]{},
                 messages = new String[]{};
        	for(User userObject: userList){
            addresses.add(userObject.email);
            subjects.add('Speaker Confirmation');
            messages.add('Dear ' + userObject.Name +
                    ',\nYour Opportunity "' + userIdOpportunity.get(userObject.Id) + '" hasn\'t been updated since last month\n\n' +
                    'Please take required action.');
        	}
        	EmailManager.sendMail(addresses, subjects, messages);
    	}
}