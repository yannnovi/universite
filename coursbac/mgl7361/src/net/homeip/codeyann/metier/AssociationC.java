package net.homeip.codeyann.metier;
import java.lang.Comparable;

public final class AssociationC  implements Comparable 
{
	private int index;
    
	public AssociationC()
	{
		
	}

	public AssociationC(int index) 
	{
        this.index=index;
    }

	public int compareTo(Object otherAss) throws ClassCastException 
	{
    	if (!(otherAss instanceof AssociationC))
		{
			throw new ClassCastException("A AssociationC object expected.");			
		}
      	if(this.index == ((AssociationC) otherAss).index)
		{
			return 0;
		}
		else
		{
			if(this.index < ((AssociationC) otherAss).index)
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
	
	public void setIndex(int value)
	{
		index = value;
	}	
	
}
