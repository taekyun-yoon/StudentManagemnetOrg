({
    fnInit : function(component, event, helper){
        component.set("v.vfPageUrl" , "/apex/PrintStudentList?recordId=" + component.get("v.recordId"));
    },

    fnCancel : function(component, event, helper){
        //취소(창닫기)
        $A.get("e.force:closeQuickAction").fire();
    }
});