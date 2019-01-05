public class Assignment_3_Stack {
	
    private List<Integer> stackList = new List<Integer>();
    
    private Integer top;
    
    private Integer limitOfStack;
    
    public Assignment_3_Stack(){
        top=-1;
    }
    
    public Assignment_3_Stack(Integer limitValue){
        if(limitValue>0){
            limitOfStack = limitValue;
        }
        top=-1;
    }
    
    public Boolean push(Integer element){
        if(top!=limitOfStack){
           stackList.add(element);
           top++;
           return true;
		}
        return false;
    }
    
    public Integer pop(Integer element){
        Integer  elementPopped;
        if(top>-1){
          elementPopped = stackList.get(top) ;	   
          stackList.remove(top);
          top--;
        }
        return elementPopped;
    }
    
    public Boolean isFull(){
        if(limitOfStack!=null && top>=limitOfStack){
            return true;
        }
        return false;
    }
    
    public Boolean isEmpty(){
        if(top==-1){
            return true;
        }
        return false;
    }
    
}