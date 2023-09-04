package net.homeip.codeyann.metier;

/**
 * <<Class summary>>
 *
 * @author Yann Bourdeau &lt;&gt;
 * @version $Rev$
 */
public final class AssociationA 
{
	private AssociationB assB=null;
	private AssociationC assC=null;
	private int index;
	
	public AssociationA()
	{
		
	}
	
    public AssociationA(int index) 
    {
        this.index=index;
    }

	public void setAssociationB(AssociationB assB)
	{
		this.assB=assB;
	}
	
	public AssociationB getAssociationB()
	{
		return assB;
	}
	
	public void setAssociationC(AssociationC assC)
	{
		this.assC=assC;
	}
	
	public AssociationC getAssociationC()
	{
		return assC;
	}
	
	public int getIndex()
	{
		return index;
	}
	
	private void setIndex(int value)
	{
		index = value;
	}
	
	/*private int getIndexB()
	{
		return getAssociationB().getIndex();
	}
	
	private void setIndexB(int value)
	{
		getAssociationB().setIndex(value);
	}
	
	private int getIndexC()
	{
		return getAssociationC().getIndex();
	}
	
	private void setIndexC(int value)
	{
		getAssociationC().setIndex(value);
	}	*/
}
