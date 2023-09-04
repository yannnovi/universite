package net.homeip.codeyann.db4o;

import java.io.File;
import net.homeip.codeyann.metier.*;
import com.db4o.Db4o;
import com.db4o.ObjectContainer;
import com.db4o.ObjectSet;
import java.util.*;

public class TestImplementationDB4O implements TestInterface
{
	private static String nomBD="testdb4o";
    private ObjectContainer db=null;
	private boolean classeRequetageCree=false;

	Types classeEcriture1;
	Types classeEcriture2;
	Types classeEcriture3;

	public boolean init()
	{
		System.out.println("DB4O test debut ================");
	
		db=Db4o.openFile(nomBD);
		
		return true;
	}
	
	public boolean testTypeDonneesPersistes()
	{
		//Types(char valeurChar,byte valeurByte,short valeurShort, valeurInt,long valeurLong,float valeurFloat,double valeurDouble,boolean valeurBoolean)
		Types test = new Types('a',(byte)1,(short)2,3,(long)4,(float)5.5,(double)6.6,true);
		db.set(test);
		
		Types testLecture = new Types('a');
		ObjectSet resultat=db.get(testLecture);
		if(resultat.hasNext())
		{
			Types resultatType=(Types)resultat.next();
			if(test.compareTo(resultatType)==0 )
			{
				return true;
			}
		}
		return false;
	}
	
	public boolean testRestrictionTypeDonnesPersistes()
	{
		// même chose que le test précédent
		return testTypeDonneesPersistes();
	}
	
	public boolean testConversionTypeDonneesAutomatique()
	{
		// même chose que le test précédent
		
		return testTypeDonneesPersistes();
	}
	
	public boolean testSauvegardeAssociation()
	{
		AssociationA assA= new AssociationA(123);
		AssociationB assB= new AssociationB(666);
		assA.setAssociationB(assB);
		db.set(assA);
		
		AssociationA testLecture = new AssociationA(123);
		ObjectSet resultat=db.get(testLecture);
		if(resultat.hasNext())
		{
			AssociationA resultatAss=(AssociationA)resultat.next();
			if(resultatAss.getAssociationB().compareTo(assB)==0 )
			{
				return true;
			}
			else
			{
				
			}
		}
		
		return false;
	}
	
	public boolean testSuppression1N()
	{
		AssociationA assA= new AssociationA(524);
		AssociationB assB= new AssociationB(525);
		AssociationC assC= new AssociationC(526);
		assA.setAssociationB(assB);
		assA.setAssociationC(assC);
		
		db.set(assA);
		
		AssociationA assA2 = new AssociationA(524);
		ObjectSet resultat=db.get(assA2);
		if(resultat.hasNext())
		{
			AssociationA assALecture=(AssociationA)resultat.next();
			db.delete(assALecture);
			
			AssociationB testAssB = new AssociationB(525);
			ObjectSet resultat2 = db.get(testAssB);
			if(!resultat2.hasNext())
			{
				return true;
			}
			else
			{
				AssociationB resTestAssB = (AssociationB)resultat2.next();
				
				if(resTestAssB.compareTo(assB)!=0)
				{
					return true;
				}
			}
		}
		return false;
	}
	
	public boolean testHeritage()
	{
	 
		HeritageEnfant enfant=new HeritageEnfant(130,131);
		db.set(enfant);
		
		HeritageParent lectureParent=new HeritageParent(130);
		ObjectSet resultat=db.get(lectureParent);
		if(resultat.hasNext())
		{
			HeritageParent resParent=(HeritageParent) resultat.next();
			if(resParent.compareTo((HeritageParent) enfant)==0)
			{
				return true;
			}
		}
		return false;
	}
	
	public boolean testPolymorphisme()
	{
		HeritageEnfant enfant= new HeritageEnfant(132,133);
		db.set((HeritageParent)enfant);
		
		HeritageEnfant lectureParent=new HeritageEnfant(132,133);
		
		ObjectSet resultat = db.get(lectureParent);
		if(resultat.hasNext())
		{
			HeritageEnfant enfantLu= (HeritageEnfant)resultat.next();
			if (enfantLu.compareTo(enfant)==0)
			{
				return true;
			}
			
		} 
		return false;
	}
	
	public boolean testSauvegardeCollection()
	{
		CollectionTest col = new CollectionTest(136);
		col.initCollection();
		db.set(col);
		
		CollectionTest colLect= new CollectionTest(136);
		ObjectSet resultat = db.get(colLect);
		if(resultat.hasNext())
		{
			CollectionTest resCol=(CollectionTest)resultat.next();
			if(resCol.compareTo(col)==0)
			{
				return true;
			}
		}
		return false;
	}
	
	private boolean testRequete(Types classeEcriture1, Types classeEcriture2, Types classeEcriture3)
	{
		int nbTrouve=0;
		try
		{
			List<Types> result = db.query(new TypesQuery('x',(byte)9));
			for(Iterator<Types> iter = result.iterator(); iter.hasNext();)
			{
				Types current=iter.next();
				if(current.compareTo(classeEcriture1)==0)
				{
					nbTrouve++;
				}
				
				if(current.compareTo(classeEcriture2)==0)
				{
					nbTrouve++;
				}
				
				if(current.compareTo(classeEcriture3)==0)
				{
					nbTrouve++;
				}
			}
			if(nbTrouve==3)
			{
				return true;
			}	
		}
		catch (Exception e)
		{
			System.out.println("KABOOOM! ");
			
			return false;
		}
		return false;
	}
	
	private void creerClasseRequete()
	{
		if(classeRequetageCree)
			return;
		classeEcriture1=new Types('x',(byte)9,(short)8,7,(long)6,(float)5.5,(double)6.6,false);
		classeEcriture2=new Types('y',(byte)9,(short)8,7,(long)6,(float)5.5,(double)6.6,false);
		classeEcriture3=new Types('z',(byte)9,(short)8,7,(long)6,(float)5.5,(double)6.6,false);
		
		db.set(classeEcriture1);
		db.set(classeEcriture2);
		db.set(classeEcriture3);
			
		classeRequetageCree=true;
	}
	public boolean testRequetageObjet()
	{
		// Les deux sont la même chose!
		return testRequeteDynamique();
	}
	
	public boolean testRequeteDynamique()
	{
		creerClasseRequete();
		return testRequete(classeEcriture1,classeEcriture2,classeEcriture3);
	}
	
	public boolean testRequetePolymorphes()
	{
		HeritageEnfant enfant = new HeritageEnfant(199,200);
		db.set(enfant);
		
		try
		{
			List<HeritageParent> result = db.query(new HeritageQuery(200));
			for(Iterator<HeritageParent> iter = result.iterator(); iter.hasNext();)
			{
				HeritageParent current=iter.next();
				
				if(((HeritageEnfant)current).compareTo(enfant)==0)
				{
					return true;
				}
			}
		}
		catch (Exception e)
		{
			System.out.println("KABOOOM! ");
		}
		
		return false;
	}
	
	
	public void terminate()
	{
		db.close();
		File toDelete=new File(nomBD);
		toDelete.delete();
		System.out.println("DB4O test fin ================");
	}
	
	
}