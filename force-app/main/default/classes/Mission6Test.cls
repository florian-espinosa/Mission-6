@isTest
private class Mission6Test {

    // Test creating new records
    @isTest static void TestGetEnrolmentProgressionExtra() {
        Test.startTest();
            // Create 'SA1' course record needed by the Contact Trigger for new Student
            Course__c course = new Course__c();
            course.Name = 'SA1';
            course.Course_Name__c = 'Sprint Training ';
            insert course;
            // Create Student record to test
            Contact con = new Contact();
            con.LastName = 'Test1';
            con.Prior_Qualification__c = 'Tertiary Post-Graduate';
            // Call the method to populate the Enrolment Progression field
            con.Enrolment_Progression__c = Mission6.getEnrolmentProgression(con.Prior_Qualification__c);
            insert con;
            // Assert the value returned by the method 
            System.assertEquals('Extra', con.Enrolment_Progression__c);
        Test.stopTest();
    }

    @isTest static void TestGetEnrolmentProgressionUltimate() {
        Test.startTest();
            // Create 'SA1' course record needed by the Contact Trigger for new Student
            Course__c course = new Course__c();
            course.Name = 'SA1';
            course.Course_Name__c = 'Sprint Training ';
            insert course;
            // Create Student record to test
            Contact con = new Contact();
            con.LastName = 'Test2';
            con.Prior_Qualification__c = 'Tertiary Graduate';
            // Call the method to populate the Enrolment Progression field
            con.Enrolment_Progression__c = Mission6.getEnrolmentProgression(con.Prior_Qualification__c);
            insert con;
            // Assert the value returned by the method 
            System.assertEquals('Ultimate',con.Enrolment_Progression__c);
        Test.stopTest();
    }

    @isTest static void TestGetEnrolmentProgressionAdvanced() {
        Test.startTest();
            // Create 'SA1' course record needed by the Contact Trigger for new Student
            Course__c course = new Course__c();
            course.Name = 'SA1';
            course.Course_Name__c = 'Sprint Training ';
            insert course;
            // Create Student record to test
            Contact con = new Contact();
            con.LastName = 'Test3';
            con.Prior_Qualification__c = 'Below Tertiary';
            // Call the method to populate the Enrolment Progression field
            con.Enrolment_Progression__c = Mission6.getEnrolmentProgression(con.Prior_Qualification__c);
            insert con;
            // Assert the value returned by the method             
            System.assertEquals('Advanced',con.Enrolment_Progression__c);
        Test.stopTest();
    }
    
    // Test mass updating of existing records
    @isTest static void TestMassUpdateEnrolmentProgression() {
        Test.startTest();
            // Create 'SA1' course record needed by the Contact Trigger for new Student
            Course__c course = new Course__c();
            course.Name = 'SA1';
            course.Course_Name__c = 'Sprint Training ';
            insert course;
            // Create the list of Student records
            List<Contact> conList = new List<Contact>();
            Contact con = new Contact();
            con.LastName = 'Test4';
            con.Prior_Qualification__c = 'Tertiary Post-Graduate';
            // Populate with the wrong Enrolment Progression value - should be 'Extra'
            con.Enrolment_Progression__c = 'Advanced';
            // Add the first record to the list
            conList.add(con);
            Contact con2 = new Contact();
            con2.LastName = 'Test5';
            con2.Prior_Qualification__c = 'Below Tertiary';
            // Populate with the wrong Enrolment Progression value - should be 'Advanced'
            con2.Enrolment_Progression__c = 'Ultimate';
            // Add the second record to the list
            conList.add(con2);       
            Contact con3 = new Contact();
            con3.LastName = 'Test6';
            con3.Prior_Qualification__c = 'Tertiary Graduate';
            // Populate with the wrong Enrolment Progression value - should be 'Ultimate'
            con3.Enrolment_Progression__c = 'Extra';
            // Add the third record to the list
            conList.add(con3);  
            // Insert the records
            insert conList; 
            // Call the method to update the Enrolment Progression fields with the right value 
            // by passing the list
            Mission6.updateEnrolmentProgression(conList);
            // Loop through the list to assert the populated Enrolment Progression field
            for (Contact conRec : conList) {
                if (conRec.Prior_Qualification__c == 'Tertiary Post-Graduate') {
                    System.assertEquals('Extra', conRec.Enrolment_Progression__c);
                } else if (conRec.Prior_Qualification__c == 'Below Tertiary') {
                    System.assertEquals('Advanced', conRec.Enrolment_Progression__c);
                } else if (conRec.Prior_Qualification__c == 'Tertiary Graduate') {
                    System.assertEquals('Ultimate', conRec.Enrolment_Progression__c);               
                }
            }
        Test.stopTest();
    }

    // Test updating of existing single record
    @isTest static void TestUpdateEnrolmentProgression() {
        Test.startTest();
            // Create 'SA1' course record needed by the Contact Trigger for new Student
            Course__c course = new Course__c();
            course.Name = 'SA1';
            course.Course_Name__c = 'Sprint Training ';
            insert course;
            // Create Student record        
            Contact con = new Contact();
            con.LastName = 'Test5';
            con.Prior_Qualification__c = 'Tertiary Post-Graduate';
            // Populate with the wrong Enrolment Progression value - should be 'Extra'
            con.Enrolment_Progression__c = 'Advanced';
            // Insert the new record
            insert con;
            // Call the method to update the right Enrolment Progression value by passing the record ID
            Mission6.updateEnrolmentProgression(con.Id);
            // Retrieve the updated record using the record ID
            Contact conUpd = [SELECT Id, Enrolment_Progression__c FROM Contact WHERE Id = :con.Id];
            // Assert the updated Enrolment Progression value
            System.assertEquals('Extra', conUpd.Enrolment_Progression__c);
        Test.stopTest();
    }

}

