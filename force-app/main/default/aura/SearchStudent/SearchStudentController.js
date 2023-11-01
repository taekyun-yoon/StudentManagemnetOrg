/**
 * Created by DAEU on 2023-09-17.
 */

({
    init: function (component, event, helper) {
        component.set('v.columns', [
            {label: '순번', fieldName: 'idx', type: 'text', initialWidth: 70},
            {label: '학생정보', fieldName: 'linkInfo', type: 'url', typeAttributes: { label: {fieldName: 'studentId'}, target: '_blank'}},
            {label: '학년', fieldName: 'studentGrade', type: 'text'},
            {label: '반', fieldName: 'studentClass', type: 'text'},
            {label: '이름', fieldName: 'studentName', type: 'text'}
        ]);
    },

    clickSearch: function (component, event, helper) {
        console.log('clickSearch');
        helper.fetchData(component);
    },

    onFirst : function(component, event, helper){
        component.set("v.currentPageNumber", 1);
        helper.setPagination(component);
    },
    onPrev : function(component, event, helper){
        let pageNumber = component.get("v.currentPageNumber");
        component.set("v.currentPageNumber", pageNumber - 1);
        helper.setPagination(component);
    },
    onLast : function(component, event, helper){
        component.set("v.currentPageNumber", component.get("v.totalPages"));
        helper.setPagination(component);
    },
    onNext : function(component, event, helper){
        let pageNumber = component.get("v.currentPageNumber");
        component.set("v.currentPageNumber", pageNumber + 1);
        helper.setPagination(component);
    }
});