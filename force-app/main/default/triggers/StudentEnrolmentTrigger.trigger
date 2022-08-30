trigger StudentEnrolmentTrigger on StudentCourseAssociation__c (before insert) {
    for (StudentCourseAssociation__c studentEnrolment : Trigger.new) {
        if (Trigger.isBefore) {
            if (Trigger.isInsert) {
                // Retrieve the SA1 Course record to get the Id
                Course__c SA1course = [SELECT Id from Course__c WHERE Name = 'SA1'];  
                // Check if record being added is not for SA1 Course
                if (studentEnrolment.Course__c <> SA1course.Id) {
                    // Validate if SA1 course has been completed for this student
                    try {
                        // Proceed with the new Student Enrolment record insert if
                        // student completed the SA1 Course
                        StudentCourseAssociation__c studentCompleted = 
                        [SELECT Id FROM StudentCourseAssociation__c
                        WHERE Student__c = :studentEnrolment.Student__c 
                        AND Course__c = :SA1course.Id 
                        AND Status__c = 'Completed'];
                    } catch (Exception e) {
                        // Else return an error
                        studentEnrolment.addError('SA1 Course must be completed first.');
                    }
                }
            }
        }
    }      
}