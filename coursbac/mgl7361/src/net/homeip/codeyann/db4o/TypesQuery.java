package net.homeip.codeyann.db4o;
import com.db4o.query.Predicate;
import net.homeip.codeyann.metier.*;

public class TypesQuery extends Predicate <Types> 
{
	private char testChar;
	private byte testByte;
	
	public TypesQuery(char testChar, byte testByte)
	{
		this.testChar=testChar;
		this.testByte=testByte;
	} 
	
	public boolean match(Types comparus) 
	{
		if(comparus.getByte()==testByte
		    &&
		   comparus.getChar()>=testChar)
		{
			return true;
		}
		return false;
	}
}
