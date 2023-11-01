/**
 * Created by DAEU on 2023-09-14.
 */

({
    fnInit : function(component, event, helper){
        console.log('fnInit');
        component.set("v.vfPageUrl" , "/apex/PrintStudentList2?recordId=" + component.get("v.recordId"));
    },

    fnCancel : function(component, event, helper){
        $A.get("e.force:closeQuickAction").fire();
    },

    fnSave : function(component, event, helper) {
        console.log('fnSave');
        helper.doSavePdf(component);
    }
});