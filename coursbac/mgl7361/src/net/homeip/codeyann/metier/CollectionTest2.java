package net.homeip.codeyann.metier;

import java.util.Iterator;
import java.util.Map;
import java.util.Set;

public final class CollectionTest2
{
	private Map properties;	
	private int index;
	
	public CollectionTest2(int index)
	{
		this.index=index;
	} 
	
    public void setCollection(Map m) {
        properties = m;
    }
    
    public Map getCollection() {
        return properties;
    }
	
	public boolean equals(Object autre) throws ClassCastException 
	{
    	if (!(autre instanceof CollectionTest2))
		{
			throw new ClassCastException("A CollectionTest2 object expected.");			
		}
    	  	
    	CollectionTest2 collection2 = (CollectionTest2)autre;
    	if (collection2.getCollection().size() == this.getCollection().size())
    	{
    		boolean isKeyEquals = this.getCollection().keySet().containsAll(collection2.getCollection().keySet());
    		boolean isValueEquals = this.getCollection().values().containsAll(collection2.getCollection().values());
    		return isKeyEquals && isValueEquals;
    	}
      		
    	return false;     	
  	}
	
	public int getIndex()
	{
		return index;
	}
	
	private void setIndex(int value)
	{
		index = value;
	}	
}
