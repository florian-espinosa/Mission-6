public with sharing class Mission6 {

    // Method to update Enrolment Progression field using a list as input parameter (mass update)
    public static void updateEnrolmentProgression(List<Contact> conList) {
        List<Contact> updList = new List<Contact>();
        for(Contact con : conList) {
            con.Enrolment_Progression__c = getEnrolmentProgression(con.Prior_Qualification__c);
            updList.add(con);
        }
        update updList;
    }

    // Method to update Enrolment Progression field using a record ID as input parameter (single update)
    public static void updateEnrolmentProgression(Id conId) {
        Contact conRec = [SELECT Id, Prior_Qualification__c FROM Contact WHERE Id = :conid];
        conRec.Enrolment_Progression__c = getEnrolmentProgression(conRec.Prior_Qualification__c);
        update conRec;
    }

    // Method to return the Enrolment Progression value based on the Prior Qualification input parameter
    public static String getEnrolmentProgression(String varPriorQualification) {
        String varEnrolmentProgression;
        switch on varPriorQualification {
            when 'Below Tertiary' {
                varEnrolmentProgression = 'Advanced';
            }
            when 'Tertiary Graduate' {
                varEnrolmentProgression = 'Ultimate';
            }
            when 'Tertiary Post-Graduate' {
                varEnrolmentProgression = 'Extra';
            }
        }
        return varEnrolmentProgression;
    }
}
