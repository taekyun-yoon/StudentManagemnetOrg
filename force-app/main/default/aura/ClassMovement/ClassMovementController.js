/**
 * Created by DAEU on 2023-09-12.
 */

({
    fnInit : function(component, event, helper) {
        helper.getInitData(component);
    },
    chooseClass: function (component, event, helper) {
        var selectedOptionValue = event.getParam("value");
        helper.checkClass(component, selectedOptionValue);
    },
    clickMove : function (component, event, helper) {
        helper.moveClass(component);
    },
    clickCancel : function (component, event, helper) {
        console.log('clickCancel')
        $A.get("e.force:closeQuickAction").fire();
    },
});