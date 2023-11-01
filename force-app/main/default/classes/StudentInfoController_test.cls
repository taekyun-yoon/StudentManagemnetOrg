/**
 * Created by DAEU on 2023-09-12.
 */

@IsTest
public with sharing class StudentInfoController_test {
    @IsTest
    static void StudentInfoController_test(){


        Test.startTest();

        Awards__c objAward = new Awards__c();
        objAward.Name = '123';
        objAward.AwardDate__c = Date.today();
        insert objAward;

        StudentInfoController.getInitData(objAward.Id);
        Test.stopTest();
    }
}