package net.homeip.codeyann.metier;
import java.util.HashMap;
import java.lang.Comparable;

public final class CollectionTest implements Comparable
{
	private HashMap hMapus;		
	private int index;
	
	public CollectionTest(int index)
	{
		this.index=index;
	} 
	
	public void initCollection()
	{
		hMapus = new HashMap();
		
		Types t1=new Types('F',(byte)1,(short)2,3,(long)4,(float)5.5,(double)6.6,true);
		Types t2=new Types('G',(byte)1,(short)2,3,(long)4,(float)5.5,(double)6.6,true);
		Types t3=new Types('H',(byte)1,(short)2,3,(long)4,(float)5.5,(double)6.6,true);
		hMapus.put(1,t1);
		hMapus.put(2,t2);
		hMapus.put(3,t3);
		
	}
	
	
	
	public int compareTo(Object autre) throws ClassCastException 
	{
    	if (!( autre instanceof CollectionTest))
		{
			throw new ClassCastException("A CollectionTest object expected.");			
		}
      	if(this.index == ((CollectionTest) autre).index)
		{
			if( ((CollectionTest) autre).hMapus.containsKey(1)
			  &&
			((CollectionTest) autre).hMapus.containsKey(2)
			  &&
			((CollectionTest) autre).hMapus.containsKey(3)
			)
			{
				return 0;	
			}
			else
			{
				return 1;
			}
			
		}
		else
		{
			if(this.index < ((CollectionTest) autre).index)
			{
				return -1;
			}
			else
			{
				return 1;
			}
		}
  	}
	
	public int getIndex()
	{
		return index;
	}
	
	private void setIndex(int value)
	{
		index = value;
	}	
	
    private HashMap getTypes() 
    { 
    	return hMapus; 
    }
    
    private void setTypes(HashMap map) 
    { 
    	this.hMapus = map; 
	}  
	
}
