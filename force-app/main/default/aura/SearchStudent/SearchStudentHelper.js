/**
 * Created by DAEU on 2023-09-17.
 */

({
    fetchData: function (component) {

        if((component.get("v.searchGrade") == null || component.get("v.searchGrade") == "" )&&
            (component.get("v.searchClass") == null || component.get("v.searchClass") == "" )&&
            (component.get("v.searchName") == null || component.get("v.searchName") == "" )){
                this.showToast('error','검색 조건을 입력하세요');

        }else{
             var gradeNumber = component.get("v.searchGrade");
                var classNumber = component.get("v.searchClass");
                var nameKeyword = component.get("v.searchName");

                console.log('grade :: ' + gradeNumber);
                console.log('Class :: ' + classNumber);
                console.log('name :: ' + nameKeyword);

                var action = component.get("c.getFetchData");
                action.setParams({
                    "str_searchGrade" : gradeNumber,
                    "str_searchClass" : classNumber,
                    "searchName" : nameKeyword
                });

                action.setCallback(this, function(response) {
                    var state = response.getState();
                    if(state === "SUCCESS") {
                        var returnValue = response.getReturnValue();
                        console.log(returnValue);

                        returnValue.forEach(function(returnValue){
                            returnValue.linkInfo = 'https://daeunextier-1c-dev-ed.develop.lightning.force.com/lightning/r/Contact/'+returnValue.studentId+'/view';
                        });

                        //pagination 처리
                        this.preparePagination(component, returnValue);

                        if(returnValue.length == 0){
                            this.showToast('error','검색된 내역이 없습니다.');
                        }


//                        component.set("v.accountList", returnValue)
                        component.set("v.RowsCount", returnValue.length)

                    }else if(state === "ERROR") {
                        var errors = response.getError();
                        console.log(errors);
                        if(errors) {
                            //참고 :에러가 났을경우는 주로 ShowToast 함수를 이용하여 토스트 메시지를 띄움
                        } else {}
                    }
                });
                $A.enqueueAction(action);
        }

    },
    setPagination : function(component){
        console.log("setPagination");
        var data = [];
        var pageNumber = component.get("v.currentPageNumber");
        var pageSize = component.get("v.pageSize");
        var fetchedData = component.get("v.accountList");
        var x = (pageNumber - 1) * pageSize;
        console.log(fetchedData[0]);
        for (; x < (pageNumber) * pageSize; x++){
            console.log(x);
            if (fetchedData[x]) {
                data.push(fetchedData[x]);
            }
        }
        component.set("v.tableData", data);
    },

    preparePagination : function(component, fetchedData) {
        console.log("preparePagination");
        var countTotalPage = Math.ceil(fetchedData.length/ component.get("v.pageSize"));
        var totalPage = countTotalPage > 0 ? countTotalPage : 1;

        component.set("v.totalPages", totalPage);
        component.set("v.currentPageNumber", 1);

        component.set("v.accountList", fetchedData);

        this.setPagination(component);
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