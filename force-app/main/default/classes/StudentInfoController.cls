/**
 * Created by DAEU on 2023-09-12.
 */

public with sharing class StudentInfoController {

    @AuraEnabled
    public static Map<String, String> getInitData(String recordId){

        List<Awards__c> listContact = new List<Awards__c>();
        listContact = [
                SELECT Id, ContactId__r.LastName, ContactId__r.Class__r.Name
                FROM Awards__c
                WHERE Id = :recordId
        ];

        Map<String, String> mapReturn = new Map<String, String>();
        if(!listContact.isEmpty()){
            mapReturn.put('LastName', listContact[0].ContactId__r.LastName);
            mapReturn.put('ClassName', listContact[0].ContactId__r.Class__r.Name);
        }

        return mapReturn;

    }
}