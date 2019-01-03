public class Assignment_3_1 {

    public static List<Student__c> studentInAClass(ID classId){
        Class__c classOf= [Select (Select Name From Student__r) From Class__c Where ID =: classId];
 		List<Student__c> studentList=classOf.Student__r; 
        return studentList;
    }
    
    public static Map<Class__c,List<ID>> classWithStudentID(){
        List<Class__c> listOfClass = [Select Name,Id,(Select ID From Student__r) From Class__c];
        Map<Class__c,List<ID>> mapOfClassStudent = new Map<Class__c,List<ID>>();
        for(Class__c classObject : listOfClass){
            List<ID> studentIds  =  new List<ID>();
            for(Student__c student  : classObject.Student__r ){
                studentIds.add(student.Id);
            }
            mapOfClassStudent.put(classObject,studentIds);    
        }
        return mapOfClassStudent;
    }
    
     public static Integer workingDaysCalculator(Date date1, Date date2){
        if(date1 == null || date2 == null){
            return null;
        }
        Date constantDateMonday = Date.newInstance(1900, 1, 8) ;
        Integer numberOfDaysBetweendate1AndConstantDate = date1.daysBetween(constantDateMonday);
        Integer numberOfDaysBetweendate2AndConstantDate = date2.daysBetween(constantDateMonday);
        Integer date1WorkingDaysFromConstantDate = 5*(numberOfDaysBetweendate1AndConstantDate/7)+Math.min(5, Math.mod(numberOfDaysBetweendate1AndConstantDate, 7));
        Integer date2WorkingDaysFromConstantDate = 5*(numberOfDaysBetweendate2AndConstantDate/7)+Math.min(5, Math.mod(numberOfDaysBetweendate2AndConstantDate, 7));
        Integer result  = date1WorkingDaysFromConstantDate - date2WorkingDaysFromConstantDate;
        if(result<0){
            result = - result ;
        }
        return result;
    }
}