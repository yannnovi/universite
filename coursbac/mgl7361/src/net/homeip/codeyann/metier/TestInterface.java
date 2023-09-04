package net.homeip.codeyann.metier;
public interface TestInterface
{
	public boolean init();
	
	public boolean testTypeDonneesPersistes();
	public boolean testRestrictionTypeDonnesPersistes(); // c'est pas la même chose que celui avant?
	public boolean testConversionTypeDonneesAutomatique();
	public boolean testSauvegardeAssociation();
	public boolean testSuppression1N();
	public boolean testHeritage();
	public boolean testPolymorphisme();
	public boolean testSauvegardeCollection();
	public boolean testRequetageObjet();
	public boolean testRequeteDynamique();
	public boolean testRequetePolymorphes();
	
	
	public void terminate();
	
	
}
