package net.homeip.codeyann.metier;
import java.lang.Comparable;

public class HeritageParent implements Comparable 
{
    
	private int index;

	public HeritageParent(int index) 
	{
        this.index=index;
    }

	public int compareTo(Object autre) throws ClassCastException 
	{
    	if (!( autre instanceof HeritageParent))
		{
			throw new ClassCastException("A HeritageParent object expected.");			
		}
      	if(this.index == ((HeritageParent) autre).index)
		{
			return 0;
		}
		else
		{
			if(this.index < ((HeritageParent) autre).index)
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
}
