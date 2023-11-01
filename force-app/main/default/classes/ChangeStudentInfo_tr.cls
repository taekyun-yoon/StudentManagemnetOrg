/**
 * Created by DAEU on 2023-09-11.
 */

public with sharing class ChangeStudentInfo_tr extends TriggerHandler{
    private List<ChangeStudentInfo__C> listNew {get; set;}
    private List<ChangeStudentInfo__C> listOld {get; set;}
    private Map<Id, ChangeStudentInfo__C> mapNew {get; set;}
    private Map<Id, ChangeStudentInfo__C> mapOld {get; set;}

    public ChangeStudentInfo_tr(){
        listNew = (List<ChangeStudentInfo__C>)Trigger.new;
        listOld = (List<ChangeStudentInfo__C>)Trigger.old;
        mapNew = (Map<Id,ChangeStudentInfo__C>)Trigger.newMap;
        mapOld = (Map<Id,ChangeStudentInfo__C>)Trigger.oldMap;
    }
    public override void beforeInsert(){
    }

    public override void afterInsert(){
    }

    public override void beforeUpdate(){
    }

    public override void afterUpdate(){
        doUpdateContact();
    }

    public override void beforeDelete(){
    }

    public void doUpdateContact(){
        List<ChangeStudentInfo__c> listTarget = new List<ChangeStudentInfo__c>();
        for (ChangeStudentInfo__c obj : listNew) {
            if(obj.IsApproved__c == true && mapOld.get(obj.Id).IsApproved__c == false) {
                listTarget.add(obj);
            }
        }

        if(!listTarget.isEmpty()){
            List<Contact> listContact = new List<Contact>();
            Contact objContact = new Contact();
            for (ChangeStudentInfo__c obj : listTarget) {
                objContact = new Contact();
                objContact.Id = obj.Student__c;
                objContact.Address__c = obj.Address__c;
                objContact.Phone = obj.Phone__c;
                listContact.add(objContact);
            }

            if(!listContact.isEmpty()){
                update listContact;
            }
        }
    }
}