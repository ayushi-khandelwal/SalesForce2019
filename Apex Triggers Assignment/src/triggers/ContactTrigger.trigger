trigger ContactTrigger on Contact (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
     fflib_SObjectDomain.triggerHandler(Contacts.class);
}