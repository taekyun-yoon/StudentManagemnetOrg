/**
 * Created by DAEU on 2023-09-19.
 */

@isTest
private class PrintStudentListController2_test {
    @isTest
    static void testPrintStudentListController2() {

        Test.startTest();

        Class__c testClass = new Class__c(Grade__c = 3,ClassNumber__c = 15);
        insert testClass;

        List<Contact> testContacts = new List<Contact>();
        for (Integer i = 0; i < 75; i++) {
            testContacts.add(new Contact(LastName = '학생' + i, Class__c = testClass.Id));
        }
        insert testContacts;

        PageReference pageRef = Page.PrintStudentList2;
        pageRef.getParameters().put('recordId', testClass.Id);

        Test.setCurrentPage(pageRef);

        PrintStudentListController2 controller = new PrintStudentListController2();

        for (Integer i = 0; i < controller.listAllContact.size(); i++) {
            Integer expectedSize = (i == controller.listAllContact.size() - 1) ? 15 : 30;
        }

        Test.stopTest();
    }
}