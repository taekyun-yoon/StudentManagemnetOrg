/**
 * Created by DAEU on 2023-09-11.
 */

public with sharing class Account_tr extends TriggerHandler{
    private List<Account> listNew {get; set;}
    private List<Account> listOld {get; set;}
    private Map<Id, Account> mapNew {get; set;}
    private Map<Id, Account> mapOld {get; set;}

    public Account_tr(){
        listNew = (List<Account>)Trigger.new;
        listOld = (List<Account>)Trigger.old;
        mapNew = (Map<Id,Account>)Trigger.newMap;
        mapOld = (Map<Id,Account>)Trigger.oldMap;
    }
    public override void beforeInsert(){
        doInsertAccount();
    }

    public override void afterInsert(){
    }

    public override void beforeUpdate(){
        doUpdateAccount();
    }

    public override void afterUpdate(){
    }

    public override void beforeDelete(){
        doDeleteAccount();
    }

    public void doInsertAccount(){
        for (Account objNew : listNew){
            if(objNew.Rating == null){
                objNew.Rating = 'Cold';
            }
        }
    }
    public void doUpdateAccount(){
        for (Account objNew : listNew){
            if (mapOld.get(objNew.Id).Rating == 'Hot') {
                objNew.addError('Hot 일때는 수정할 수 없습니다.');
            }
        }
    }
    public void doDeleteAccount(){
        for (Account obj : listOld){
            if (obj.Rating == 'Hot') {
                obj.addError('Hot 일때는 삭제할 수 없습니다.');
            }
        }
    }
}