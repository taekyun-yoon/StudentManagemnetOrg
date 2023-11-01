/**
 * Created by DAEU on 2023-09-11.
 */

public with sharing class ClassByLevel_tr extends TriggerHandler {
    private List<ClassByLevel__c> listNew { get; set; }
    private List<ClassByLevel__c> listOld { get; set; }
    private Map<Id, ClassByLevel__c> mapNew { get; set; }
    private Map<Id, ClassByLevel__c> mapOld { get; set; }

    public ClassByLevel_tr() {
        listNew = (List<ClassByLevel__c>) Trigger.new;
        listOld = (List<ClassByLevel__c>) Trigger.old;
        mapNew = (Map<Id, ClassByLevel__c>) Trigger.newMap;
        mapOld = (Map<Id, ClassByLevel__c>) Trigger.oldMap;
    }
    public override void beforeInsert() {
        doInsertName();
    }

    public override void afterInsert() {
    }

    public override void beforeUpdate() {
    }

    public override void afterUpdate() {
    }

    public override void beforeDelete() {
    }

    public void doInsertName() {
        for (ClassByLevel__c obj : listNew) {
            if (obj.Grade__c != null && obj.Subject__c != null && obj.Level__c != null) {
                obj.Name = obj.Grade__c + '학년_' + obj.Subject__c + '_' + obj.Level__c;
            }
            else {
                obj.addError('성적과 과목과 레벨이 작성되어 있지 않습니다.');
            }
        }
    }
}