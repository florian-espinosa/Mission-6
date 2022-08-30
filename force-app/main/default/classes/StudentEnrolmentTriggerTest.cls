@isTest
private class StudentEnrolmentTriggerTest {
    @isTest
    private static void testStudentEnrolmentInsert() {
        Test.startTest();            
            // Instantiate a new course object
            Course__c course = new Course__c();
            // Create SA1 Course to satisfy trigger requirement
            course.Name = 'SA1';
            course.Course_Name__c = 'Sprint Training';
            insert course;
            // Create a new Student record
            Contact student = new Contact();
            student.LastName = 'Test1';
            student.Prior_Qualification__c = 'Below Tertiary';
            student.Enrolment_Progression__c = 'Advanced';
            insert student;
            // Create the 'AA1' Course to get the Id
            Course__c AA1course = new Course__c();
            AA1course.Name = 'AA1';
            AA1course.Course_Name__c = 'Advanced Sprint Training';
            insert AA1course;
            // Create a new Student Enrolment record for 'AA1' Course 
            StudentCourseAssociation__c newRecord = new StudentCourseAssociation__c();
            newRecord.Course__c = AA1course.Id;
            newRecord.Student__c = student.Id;
            NewRecord.Status__c = 'Enrolled';
            // Try inserting the new Student Enrolment record without the SA1 Course completed first
            try {
                insert newrecord;
            } catch (Exception e) {
                // Check for the exception if related to student not completed the SA1 Course                
                Boolean expectedExceptionThrown =  (e.getMessage().contains('SA1 Course must be completed first.')) ? true : false; 
                System.AssertEquals(true, expectedExceptionThrown); 
                // Return an error            
                newRecord.addError('SA1 Course must be completed first.');
            }
        Test.stopTest();
    }
}

