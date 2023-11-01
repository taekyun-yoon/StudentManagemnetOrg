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

public with sharing class PrintStudentListController {
    public String recordId { get; set; }
    public List<Contact> listContact {get; set;}

    public PrintStudentListController() {
        //url속 파라미터를 가져오는 코드
        recordId = ApexPages.currentPage().GetParameters().get('recordId');
        //해당 학급의 학생정보를 가져오는 쿼리
        listContact = [
                SELECT LastName, Birthdate
                FROM Contact
                WHERE Class__c = :recordId
        ];
    }
}