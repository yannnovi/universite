package net.homeip.codeyann.db4o;

import com.db4o.query.Predicate;
import net.homeip.codeyann.metier.*;

public class HeritageQuery extends Predicate <HeritageParent> 
{
	private int index;

	
	public HeritageQuery(int index)
	{
		this.index=index;
	} 
	
	public boolean match(HeritageParent comparus) 
	{
	
		
		if(comparus.getIndex()==index)
		{
			return true;
		}
		return false;
	}
}
