package net.homeip.codeyann.metier;
import java.lang.Comparable;

public final class HeritageEnfant extends HeritageParent implements Comparable 
{
	private int index;

    public HeritageEnfant(int indexParent, int indexEnfant) 
	{
		super(indexParent);
		this.index=indexEnfant;
    }

	public int compareTo(Object autre) throws ClassCastException 
	{
    	if (!( autre instanceof HeritageEnfant))
		{
			throw new ClassCastException("A HeritageEnfant object expected.");			
		}
      	if((getIndex() == ((HeritageEnfant) autre).index) && (((HeritageParent)autre ).getIndex() == ((HeritageParent)this).getIndex()))
		{
			return 0;
		}
		else
		{
			if(this.index < ((HeritageEnfant) autre).index)
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
