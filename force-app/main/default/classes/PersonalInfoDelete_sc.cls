/**
 * Created by DAEU on 2023-09-14.
 */

global class PersonalInfoDelete_sc implements Schedulable{
    global void execute(SchedulableContext sc) {
        // Scheduled job 등록할 때는 아와 같이 입력
        // CRON example ) '0 30 16 * * ? *'  //16:30pm everyday
        // String CRON = '0 0 22 * * ? *';
        // System.schedule('PersonalInfoDelete_ba', CRON, new PersonalInfoDelete_sc());
        Database.executeBatch(new PersonalInfoDelete_ba() , 50);
//        Database.executeBatch(new PersonalInfoDelete_ba('parameter') , 50);

    }
}