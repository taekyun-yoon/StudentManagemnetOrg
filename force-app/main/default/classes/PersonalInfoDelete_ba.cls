/**
 * Created by DAEU on 2023-09-14.
 */

global with sharing class PersonalInfoDelete_ba implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
    global Boolean isError = false;
    global String strId;

//    public PersonalInfoDelete_ba(String type) {
//        strId = type;
//    }
    public PersonalInfoDelete_ba( ) {}

    global Database.QueryLocator start(Database.BatchableContext BC) {

        String strQuery = 'SELECT Id ';
        strQuery += '   FROM Contact';
        strQuery += '   WHERE IsGraduated__c = true ';

        return DataBase.getQueryLocator(strQuery);
    }

    global void execute(Database.BatchableContext BC, List<Contact> listTarget){
        try {
            if(!listTarget.isEmpty()){
                for(Contact obj : listTarget){
                    obj.Birthdate = null;
                    obj.MobilePhone = null;
                }

                update listTarget;
            }
        }catch(Exception e) {
            this.isError = true;
            System.debug('Error ===================> Error : ' + e.getMessage() + '/' + e.getLineNumber());
        }
    }

    global void finish(Database.BatchableContext BC) {
        System.debug('batch finish');
    }
}