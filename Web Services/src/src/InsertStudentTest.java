import static org.junit.Assert.*;

import org.junit.Test;

import com.sforce.soap.enterprise.LoginResult;
import com.sforce.soap.enterprise.QueryResult;
import com.sforce.soap.enterprise.SaveResult;
import com.sforce.soap.enterprise.sobject.SObject;
import com.sforce.soap.enterprise.sobject.Student__c;
import com.sforce.ws.ConnectionException;

public class InsertStudentTest {

	@Test
	public void testMainFunctionality() {
		InsertStudent insertStudentObject = new InsertStudent();
		LoginResult loginResult = new LoginResult();
		Boolean flag=false;
		try{
			loginResult = insertStudentObject.login();
		}catch(Exception e){
			flag =true;
			System.out.println("Exception Occured");
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		if(!flag){
			if(insertStudentObject.setConfigure(loginResult)){
				Student__c[] studentList = testDataStudent();
				SaveResult[] result= insertStudentObject.insertStudents(studentList);
				String[] resultId = new String[10];
				for(int i=0;i<result.length ;i++){
					if(result[i].isSuccess()){
						System.out.println("Result -> "+result[i].getId());
						resultId[i]=result[i].getId();
					}
					else{
						System.out.println("Failed "+result[i].getErrors()[0].getMessage());
					}
				}
				QueryResult queryResult = new QueryResult();
				if (insertStudentObject.connection.getConfig() != null) {
					try {
						queryResult = insertStudentObject.connection.query("SELECT Name FROM Student__c WHERE Id='"+result[0].getId()+"'");
					} catch (ConnectionException e) {
						e.printStackTrace();
					}
				}
				SObject[] studentListQ = queryResult.getRecords();
				assertEquals(1,studentListQ.length);
				assertEquals("Test Name0",((Student__c) studentListQ[0]).getName());
			}
		}
	}
	
	public Student__c[] testDataStudent(){
		Student__c[] studentList = new Student__c[10];
		for(int i=0;i<10;i++){
			Student__c stud = new Student__c();
			stud.setName("Test Name"+i);
			stud.setLast_Name__c("Test Last Name"+i);
			stud.setClass__c("a0110000016LeMLAA0");
			studentList[i] = stud;
		}
		return studentList;
	}

}
