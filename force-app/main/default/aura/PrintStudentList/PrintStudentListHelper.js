/**
 * Created by DAEU on 2023-09-20.
 */

({
    doSavePdf : function(component){
        var doSaveResult = confirm('pdf파일 형태로 저장하시겠습니까?');
        if(doSaveResult){
            console.log(component.get("v.vfPageUrl"));
            var action = component.get("c.doSavePdf");

            action.setParams({
                 "recordId" : component.get("v.recordId"),
            });

            action.setCallback(this, function(response) {
                var state = response.getState();
                if(state === "SUCCESS") {
                    console.log('success');
                    var returnValue = response.getReturnValue();
                    console.log(returnValue);
                } else if(state === "ERROR") {
                    var errors = response.getError();
                    console.log('errors');
                    console.log(errors);
                    if(errors) {
                        this.showToast('error','오류가 발생했습니다.');
                        //참고 :에러가 났을경우는 주로 ShowToast 함수를 이용하여 토스트 메시지를 띄움
                    } else {}
                }
            });
            $A.enqueueAction(action);
            $A.get("e.force:closeQuickAction").fire();
            $A.get('e.force:refreshView').fire();
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
         }
});