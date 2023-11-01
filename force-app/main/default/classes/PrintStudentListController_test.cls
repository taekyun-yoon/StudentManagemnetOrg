/**
 * Created by DAEU on 2023-09-19.
 */
@isTest
private class PrintStudentListController_test {
    @isTest
    static void testPrintStudentListController() {

        Test.startTest();

        Class__c testClass = new Class__c(Grade__c = 3,ClassNumber__c = 15);
        insert testClass;

        List<Contact> testContacts = new List<Contact>();
        for (Integer i = 0; i < 3; i++) {
            testContacts.add(new Contact(LastName = '학생' + i, Class__c = testClass.Id));
        }
        insert testContacts;

        PageReference pageRef = Page.PrintStudentList;
        pageRef.getParameters().put('recordId', testClass.Id);

        Test.setCurrentPage(pageRef);

        PrintStudentListController controller = new PrintStudentListController();

        Test.stopTest();
    }
}