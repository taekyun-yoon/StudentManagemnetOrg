///**
// * Created by DAEU on 2''23-''9-18
// */
public with sharing class SearchStudentController {

    @AuraEnabled
    public static List<Map<String, String>> getFetchData(String str_searchGrade, String str_searchClass, String searchName){

        String searchNameText = '%'+searchName+'%';
        List<Contact> listContact;

        Decimal searchGrade;
        Decimal searchClass;

        if (str_searchGrade == '' || str_searchGrade == null) { searchGrade = 0;}
        else { searchGrade = Decimal.valueOf(str_searchGrade); }

        if (str_searchClass == '' || str_searchClass == null) { searchClass = 0;}
        else { searchClass = Decimal.valueOf(str_searchClass); }

        String strQuery = 'SELECT Id, Name, Class__r.Grade__c, Class__r.ClassNumber__c FROM Contact WHERE ';

        if ((str_searchGrade == null || str_searchGrade == '' ) &&
                (str_searchClass == null || str_searchClass == '')) {
            strQuery += ('Name LIKE ' + '\'' + searchNameText + '\'');
            listContact = Database.query(strQuery);
        }
        else if ((str_searchGrade == null || str_searchGrade == '') &&
                (searchName == null || searchName == '')) {
            strQuery += ('Class__r.ClassNumber__c = :searchClass');
        }
        else if ((str_searchClass == null || str_searchClass == '') &&
                (searchName == null || searchName == '')) {
            strQuery += ('Class__r.Grade__c =  :searchGrade');
        }
        else if (str_searchGrade == null || str_searchGrade == '') {
            strQuery += ('Class__r.ClassNumber__c = :searchClass AND Name LIKE '+ '\'' + searchNameText + '\'');
        }
        else if (str_searchClass == null || str_searchClass == '') {
            strQuery += ('Class__r.Grade__c =  :searchGrade AND Name LIKE '+ '\'' + searchNameText + '\'');
        }
        else if (searchName == null || searchName == '') {
            strQuery += ('Class__r.Grade__c =  :searchGrade AND Class__r.ClassNumber__c = :searchClass');
        }
        else if ((str_searchGrade == null || str_searchGrade == '') &&
                (str_searchClass == null || str_searchClass == '') &&
                (searchName == null || searchName == '')) {
            System.debug('helper에서 필터링 안된 경우');
        }
        else {
            System.debug('모든 조건이 입력됨');
            strQuery += ('Class__r.Grade__c =  :searchGrade AND Class__r.ClassNumber__c = :searchClass AND Name LIKE '+ '\'' + searchNameText + '\'');
        }
        strQuery += ' ORDER BY Class__r.Grade__c ASC, Class__r.ClassNumber__c ASC, LastName ASC ';
        listContact = Database.query(strQuery);


        List<Map<String, String>> mapListContact = new List<Map<String, String>>();
        Map<String, String> mapContact;
        Integer i = 1;
        for (Contact contact : listContact){
            mapContact = new Map<String, String>();
            mapContact.put('idx', String.valueOf(i));
            mapContact.put('studentId',contact.Id);
            mapContact.put('studentGrade',String.valueOf(contact.Class__r.Grade__c));
            mapContact.put('studentClass',String.valueOf(contact.Class__r.ClassNumber__c));
            mapContact.put('studentName',contact.Name);
            mapContact.put('linkInfo','');
            mapListContact.add(mapContact);
            i ++;
        }
        return mapListContact;
    }
}