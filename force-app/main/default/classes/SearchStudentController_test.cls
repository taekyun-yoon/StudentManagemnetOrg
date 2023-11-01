/**
 * Created by DAEU on 2023-09-19.
 */

@IsTest
public with sharing class SearchStudentController_test {
    @IsTest
    static void SearchStudentController_test(){

        Test.startTest();

        Class__c testClass = new Class__c(
                Grade__c = 3,
                ClassNumber__c = 15
        );
        insert testClass;

        Contact objContact = new Contact(
                LastName = '김',
                Class__c = testClass.Id
        );
        insert objContact;

        SearchStudentController.getFetchData('3','15','김');

        Test.stopTest();
    }
}