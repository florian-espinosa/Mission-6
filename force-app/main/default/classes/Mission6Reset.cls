public with sharing class Mission6Reset {
    public static void resetFields() {
        List<Contact> conList = [SELECT Id FROM Contact];
        List<Contact> updList = new List<Contact>();
        for (Contact con : conList) {
            con.Prior_Qualification__c = null;
            con.Enrolment_Progression__c = null;
            updList.add(con);
        }
        update updList;
    }
}
