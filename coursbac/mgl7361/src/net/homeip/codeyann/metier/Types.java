package net.homeip.codeyann.metier;
import java.lang.Comparable;

public class Types implements Comparable 
{
	private char testChar;
	private byte testByte;
	private short testShort;
	private int testInt;
	private long testLong;
	private float testFloat;
	private double testDouble;
	private boolean testBoolean;
	
	public Types(char valeurChar,byte valeurByte,short valeurShort,int valeurInt,long valeurLong,float valeurFloat,double valeurDouble,boolean valeurBoolean)
	{
		testChar=valeurChar;
		testByte=valeurByte;
		testShort=valeurShort;
		testInt=valeurInt;
		testLong=valeurLong;
		testFloat=valeurFloat;
		testDouble=valeurDouble;
		testBoolean=valeurBoolean;
	}
	
	public Types(char valeurChar)
	{
		testChar=valeurChar;
	}
	
	public Types(char valeurChar, byte bitus)
	{
		testChar=valeurChar;
		testByte=bitus;
	}
	
	public Types()
	{
	}
	
	public int compareTo(Object otherAss) throws ClassCastException 
	{
    	if (!(otherAss instanceof Types))
		{
			throw new ClassCastException("A Types object expected.");			
		}
      	if(comparus(((Types) otherAss)))
		{
			return 0;
		}
		else
		{
			return -1;
		}
  	}
	
	private boolean comparus(Types autre)
	{
		if(testChar==autre.testChar
		   &&
		   testByte==autre.testByte
		   &&
		   testShort == autre.testShort
		   &&
		   testInt == autre.testInt
		   &&
		   testLong == autre.testLong
		   &&
		   testFloat == autre.testFloat
		   &&
		   testDouble == autre.testDouble
		   &&
		   testBoolean == autre.testBoolean	
		   )
		{
			
			return true;
		}
		return false;
	}
	
	public char getChar()
	{
		return testChar;
	}
	
	public byte getByte()
	{
		return testByte;
	}
	
	public short getShort()
	{
		return testShort;
	}
	
	public int getInt()
	{
		return testInt;
	}
	
	public long getLong()
	{
		return testLong;
	}
	
	public float getFloat()
	{
		return testFloat;
	}
	
	public double getDouble()
	{
		return testDouble;
	}
	
	public boolean getBoolean()
	{
		return testBoolean;
	}
	
	public void setChar(char value)
	{
		testChar = value;
	}
	
	public void setByte(byte value)
	{
		testByte = value;
	}
	
	public void setShort(short value)
	{
		testShort = value;
	}
	
	public void setInt(int value)
	{
		testInt = value;
	}
	
	public void setLong(long value)
	{
		testLong = value;
	}
	
	public void setFloat(float value)
	{
		testFloat = value;
	}
	
	public void setDouble(double value)
	{
		testDouble = value;
	}
	
	public void setBoolean(boolean value)
	{
		testBoolean = value;
	}
	
	public String toString()
	{
		return "" +  testChar + "," + testByte + "," + testShort + " " + testInt + " " + testLong + " " + testFloat + " " + testDouble + " " + testBoolean;
		
	}
	
}
