/**
 * Created by DAEU on 2023-09-14.
 */

/************************************************************************************
 * Description :
 *
 * Ver      Date           Author          Modification
 * ===================================================================================
   1.0      2022-09-06     yr.lee          Create
*************************************************************************************/

public with sharing class PrintStudentListController2 {
    public String recordId { get; set; }
    public List<Contact> listContact {get; set;}
    public List<List<Contact>> listAllContact { get; set;}

    public PrintStudentListController2() {
        recordId = ApexPages.currentPage().GetParameters().get('recordId');
        listContact = [
                SELECT LastName, Birthdate
                FROM Contact
                WHERE Class__c = :recordId
        ];
        listAllContact = new List<List<Contact>>();
        List<Contact>list30Contact = new List<Contact>();

        for (Integer i = 0; i < listContact.size(); i ++) {
            list30Contact.add(listContact.get(i));
            if (Math.mod(i+1,30) == 0 && i != 0) {
                listAllContact.add(new List<Contact>(list30Contact));
                list30Contact.clear();
            } else if (i + 1 == listContact.size()) {
                listAllContact.add(new List<Contact>(list30Contact));
                list30Contact.clear();
            }
        }
    }


    @AuraEnabled
    public static String doSavePdf(String recordId) {
        String result = '';
        String vfPageUrl = '';

        try{
            vfPageUrl = '/apex/PrintStudentList2?Id=' + recordId;
            PageReference templatePageReference = new PageReference(vfPageUrl);

            Blob templateBLOB;
            if (Test.isRunningTest()){
                templateBLOB = Blob.valueOf('Unit test');
            } else {
                templateBLOB = templatePageReference.getContentAsPDF();
            }
            List<AggregateResult> cntDocument = new List<AggregateResult>();
            cntDocument = [
                    SELECT id
                    FROM ContentDocumentLink
                    WHERE LinkedEntityId = :recordId
                    GROUP BY Id
            ];

            List<Class__c> objClass = new List<Class__c>();
            objClass = [
                    SELECT Name
                    FROM Class__c
                    WHERE Id = :recordId
            ];

            ContentVersion objContentVersion = new ContentVersion();
            objContentVersion.Title                     = objClass[0].Name + ' 출석부_' + String.valueOf(System.today());
            objContentVersion.VersionData               = templateBLOB;
            objContentVersion.PathOnClient              = objClass[0].Name + '출석부_' + String.valueOf(System.today()) + 'pdf';
            objContentVersion.FirstPublishLocationId    = recordId;

            insert objContentVersion;

            objContentVersion = [
                    SELECT Id, ContentDocumentId
                    FROM ContentVersion
                    WHERE Id =:objContentVersion.Id
            ];

            List<ContentDocumentLink> listCdl = new List<ContentDocumentLink>([
                    SELECT Id, ShareType, Visibility
                    from ContentDocumentLink
                    where LinkedEntityId = :recordId
                    and ContentDocumentId = :objContentVersion.ContentDocumentId
            ]);

            result = 'success';

        } catch(Exception e){
            System.debug('PrfPDFGenerator line : ' + e.getLineNumber());
            System.debug('PrfPDFGenerator message : ' + e.getMessage());
            System.debug('PrfPDFGenerator cause : ' + e.getCause());
            result = 'error';
        }

        return result;
    }
}