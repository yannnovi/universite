package net.homeip.codeyann.metier;
import java.lang.Comparable;

public final class AssociationB implements Comparable
{
	int index;
	
	public AssociationB()
	{
		
	}
	
    public AssociationB(int index) 
    {
        this.index=index;
    }


	public String toString()
	{
		return "" + index;
	}
	
	public int compareTo(Object otherAss) throws ClassCastException 
	{
    	if (!(otherAss instanceof AssociationB))
		{
			throw new ClassCastException("A AssociationB object expected.");			
		}

      	if(this.index == ((AssociationB) otherAss).index)
		{
			return 0;
		}
		else
		{
			if(this.index < ((AssociationB) otherAss).index)
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
