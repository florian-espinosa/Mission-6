trigger ContactTrigger on Contact (after insert) {
    for (Contact student : Trigger.new) {
        if (Trigger.isAfter) {
            if (Trigger.isInsert) {
                // Retrieve the SA1 Course record to get the Id
                Course__c course = [SELECT Id from Course__c WHERE Name = 'SA1'];      
                // Instantiate a new Student-Course junction object record
                StudentCourseAssociation__c studentCourse = new StudentCourseAssociation__c();
                // Assign the SA1 Course ID to the record
                studentCourse.Course__c = course.Id;
                // Assign the Student ID to the record
                studentCourse.Student__c = student.Id;
                // Insert the record in the Student-Course junction object
                insert studentCourse;      
            }
        }
    }
}