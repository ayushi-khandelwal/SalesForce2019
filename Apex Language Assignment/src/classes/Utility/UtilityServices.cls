public with sharing class UtilityServices {
    
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