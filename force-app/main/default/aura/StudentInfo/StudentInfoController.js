/**
 * Created by DAEU on 2023-09-12.
 */

({
    fnInit : function(component, event, helper) {
        console.log('recordId ::' + component.get("v.recordId"));
        helper.getInitData(component);
       //Console log 찍고 확인해보기
       //helper로 이동
    }
});