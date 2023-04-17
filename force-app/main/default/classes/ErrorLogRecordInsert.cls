public with sharing class ErrorLogRecordInsert {
    public static void insertErrorLog(String logDetails,String processName) {
    Error_Log__c errorLog=new Error_Log__c();
    errorLog.Log__c=Datetime.now();
    errorLog.Log_Details__c=logDetails;
    errorLog.Process_Name__c=processName;
    insert errorLog;
    }
}