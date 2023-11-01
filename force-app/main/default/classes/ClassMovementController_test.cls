/**
 * Created by DAEU on 2023-09-19.
 */
@IsTest
public with sharing class ClassMovementController_test {

    @IsTest
    static void testGetInitData() {
        Class__c class1 = new Class__c(Grade__c = 3, ClassNumber__c = 15);
        Class__c class2 = new Class__c(Grade__c = 3, ClassNumber__c = 10);

        insert new List<Class__c> {class1, class2};

        ClassMovementController.getInitDate();
    }

    @isTest
    static void testCheckClass() {
        Class__c testClass = new Class__c(Grade__c = 3, ClassNumber__c = 10);
        insert testClass;

        Contact testContact = new Contact(LastName = '박도윤', Class__c = testClass.Id);
        insert testContact;

        //같은 학년 반인 경우
        Boolean result1 = ClassMovementController.checkClass(testContact.Id, '2023년 3학년 10반');
        //타 학년인 경우
        Class__c anotherClass = new Class__c(Grade__c = 1, ClassNumber__c = 10);
        insert anotherClass;
        Boolean result2 = ClassMovementController.checkClass(testContact.Id, '2023년 1학년 10반');
        //반 이동 가능한 경우
        Class__c theAnotherClass = new Class__c(Grade__c = 3, ClassNumber__c = 15);
        insert theAnotherClass;
        Boolean result3 = ClassMovementController.checkClass(testContact.Id, '2023년 3학년 15반');

    }

    @isTest
    static void testChangeClass() {
        Class__c class1 = new Class__c(Grade__c = 3, ClassNumber__c = 10);
        Class__c class2 = new Class__c(Grade__c = 3, ClassNumber__c = 15);
        insert new List<Class__c> {class1, class2};

        Contact testContact = new Contact(
                LastName = '박도윤',
                Class__c = class1.Id
        );
        insert testContact;

        ClassMovementController.changeClass(testContact.Id, '2023년 3학년 15반');

        Contact updatedContact = [SELECT Class__c FROM Contact WHERE Id = :testContact.Id];
    }

}