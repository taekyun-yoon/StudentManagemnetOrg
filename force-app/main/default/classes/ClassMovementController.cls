/**
 * Created by DAEU on 2023-09-12.
 */

public with sharing class ClassMovementController {

    @AuraEnabled
    public static List<Map<String, String>> getInitDate(){
        List<Class__c> listClassName = new List<Class__c>();
        listClassName = [
                SELECT Name
                FROM Class__c
                ORDER BY Grade__c, ClassNumber__c
        ];
        List<Map<String, String>> listClass = new List<Map<String, String>>();
        if (!listClassName.isEmpty()){
            for (Class__c className : listClassName) {
                Map<String, String> classOption = new Map<String, String>();
                classOption.put('label', className.Name);
                classOption.put('value', className.Id);
                listClass.add(classOption);
            }
        }
        System.debug(listClass);
        return listClass;
    }

    @AuraEnabled
    public static Boolean checkClass(String recordId, String selectClassId) {
        List<Contact> listContact =new List<Contact>();
        //해당 학생의 반 ID, 학년
        listContact = [
                SELECT Id, Class__c, Class__r.Grade__c
                FROM Contact
                WHERE Id = :recordId
        ];
        //선택한 반의 ID, 학년
        List<Class__c> listClass = new List<Class__c>();
        listClass = [
                SELECT Id, Grade__c
                FROM Class__c
                WHERE Id = :selectClassId
        ];

        Boolean result = false;

        //같은 학년 반인 경우
        if (listContact[0].Class__c == listClass[0].Id) {
            result = false;
        }//타 학년인 경우
        else if (listContact[0].Class__r.Grade__c != listClass[0].Grade__c) {
            result = false;
        }else {
            result = true;
        }
        return result;
    }

    @AuraEnabled
    public static void changeClass(String recordId, String selectedClassId) {
        System.debug('[changeClass start]');
        System.debug('recordId :' + recordId);
        System.debug('selectedClassId :' + selectedClassId);

        List<Contact> listUpdateContact = new List<Contact>();
        Contact updateContact = new Contact();

        //해당 학생의 반 수정
        updateContact.Id = recordId;
        updateContact.Class__c = selectedClassId;
        listUpdateContact.add(updateContact);

        if (!listUpdateContact.isEmpty()) {
            update listUpdateContact;
        }
    }
}