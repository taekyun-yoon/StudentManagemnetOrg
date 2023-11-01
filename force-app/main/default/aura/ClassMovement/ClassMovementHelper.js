/**
 * Created by DAEU on 2023-09-12.
 */

({
    getInitData : function(component) {
        var action = component.get("c.getInitDate");
        action.setParams({});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                var returnValue = response.getReturnValue();
                component.set("v.classes", returnValue);
            }
            else if(state === "ERROR") {
                var errors = response.getError();
                if(errors) {
                    showToast('error','에러');
                } else {
                }
            }
        });
        $A.enqueueAction(action);
    },

    checkClass : function(component, selectedOptionValue) {
        var selectClassId = selectedOptionValue;
        var action = component.get("c.checkClass")
        action.setParams({
            "recordId" : component.get("v.recordId"),
            "selectClassId" : selectClassId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                //Boolean
                var returnValue = response.getReturnValue();

                //타 학년 또는 같은 반을 선택한 경우
                if (!returnValue) {
                    this.showToast('error', '타 학년 또는 같은 반으로 이동 불가');
                    component.set('v.selectedClass', "반 선택..");
                }
            }
            else if(state === "ERROR") {
                var errors = response.getError();
                if(errors) {
                    this.showToast('error','에러');
                }
            }
        });
        $A.enqueueAction(action);
    },

    moveClass : function(component) {
        if(component.get("v.selectedClass") == null || component.get("v.selectedClass") == "" || component.get("v.selectedClass") == "반 선택.."){
            this.showToast('error','반을 선택하십시오.');
        }
        else {
            var result = confirm("정말 반 이동을 하시겠습니까?");
            if(result){
                var action = component.get("c.changeClass");
                action.setParams({
                    "recordId" : component.get('v.recordId'),
                    "selectedClassId" : component.get('v.selectedClass')
                });
                action.setCallback(this, function(response) {
                    if(state === "SUCCESS") {
                        this.showToast("success", "성공");
                        $A.get('e.force:refreshView').fire();
//                                $A.get('e.force:refreshView').fire();
                    }
                    else if(state === "ERROR") {
                        var errors = response.getError();
                        if(errors) {
                            this.showToast('error','반 이동 에러');
                        }
                    }
                });
                $A.enqueueAction(action);
                $A.get("e.force:closeQuickAction").fire();
                $A.get('e.force:refreshView').fire();

            }else{
                component.set("v.selectedClass", "반 선택..");
            }
        }
    },

    showToast : function(type, message) {
            var evt = $A.get("e.force:showToast");
            evt.setParams({
                key : "info_alt"
                , type : type
                , message : message
            });
            evt.fire();
        },
});