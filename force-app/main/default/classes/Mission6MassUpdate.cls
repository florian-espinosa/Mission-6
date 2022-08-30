public with sharing class Mission6MassUpdate {

    public static void updateAllStudents() {
        // Create and populate the list of Contacts/Students with null Prior Qualification value
        List<Contact> conList = [SELECT Id FROM Contact WHERE Prior_Qualification__c = null];
        // Create the list to store the Contacts/Students to be updated
        List<Contact> updList = new List<Contact>();
        // Iterate through the list of retrieved Contacts/Students
        for (Contact conRec : conList) {
            Integer randomNumber = 0;
            // Generate random number from 1 to 3
            while (randomNumber == 0) {
                randomNumber = Integer.valueof((Math.random() * 4));
            }
            // Update the Prior Qualification field based on the random number generated
            if (randomNumber == 1) {
                conRec.Prior_Qualification__c = 'Below Tertiary';
            } else if (randomNumber == 2) {
                conRec.Prior_Qualification__c = 'Tertiary Graduate';
            } else {
                conRec.Prior_Qualification__c = 'Tertiary Post-Graduate';
            }
            // Call the Apex Class (Class Name: Mission6, Method Name: getEnrolmentProgression)
            // to assign the Enrolment Progression value by passing the Prior Qualification 
            conRec.Enrolment_Progression__c = Mission6.getEnrolmentProgression(conRec.Prior_Qualification__c);
            // Add the updated record to the list
            updList.add(conRec);
        }
        // Apply the update to the org using the list
        update updList;
    }

}
