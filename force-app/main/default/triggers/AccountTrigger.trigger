/**
 * Created by DAEU on 2023-09-11.
 */

trigger AccountTrigger on Account (before insert, before update, before delete, after insert, after update, after delete ) {
//    if(Trigger.isBefore) {
//        if (Trigger.isInsert) {
//            System.debug('Before Insert Trigger Start...');
//            System.debug('Trigger.Size > ' + Trigger.size);
//            System.debug('Trigger.new > ' + Trigger.new);
//            System.debug('Trigger.newMap >' + Trigger.newMap);
//            System.debug('Trigger.old >' + Trigger.old);
//            System.debug('Trigger.oldMap >' + Trigger.oldMap);
//        } else if (Trigger.isUpdate) {
//            //Before Update Trigger Start..
//        } else if (Trigger.isDelete) {
//            //Before Delete Trigger Start..
//        }
//    }
//    else if(Trigger.isAfter) {
//        if(Trigger.isInsert) {
//            System.debug('After Insert Trigger Start...');
//            System.debug('Trigger.Size > ' + Trigger.size);
//            System.debug('Trigger.new > ' + Trigger.new);
//            System.debug('Trigger.newMap >' + Trigger.newMap);
//            System.debug('Trigger.old >' + Trigger.old);
//            System.debug('Trigger.oldMap >' + Trigger.oldMap);
//        }
//    }
    new Account_tr().run();
}