/**
 * Created by DAEU on 2023-09-11.
 */

trigger ClassByLevelTrigger on ClassByLevel__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    new ClassByLevel_tr().run();
}