@isTest
private class ContactTriggerTest {
    @isTest
    private static void testContactInsert() {
        Test.startTest();            
            // Instantiate a new course object
            Course__c course = new Course__c();
            // Create SA1 Course to satisfy trigger requirement
            course.Name = 'SA1';
            course.Course_Name__c = 'Sprint Training ';
            insert course;
            // Create a new Student record
            Contact student = new Contact();
            student.LastName = 'Test1';
            student.Prior_Qualification__c = 'Below Tertiary';
            student.Enrolment_Progression__c = 'Advanced';
            insert student;
            // Retrieve the created Student record from the Student-Course junction object
            List<StudentCourseAssociation__c> studentCourse = [SELECT Id FROM StudentCourseAssociation__c];
            // Assert if the record count is 1 by checking the list size
            System.assertEquals(1, studentCourse.size());
        Test.stopTest();
    }
}
