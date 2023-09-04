package client;

public class PaiementCarteCredit extends Paiement
{
  private String type;
  private String numero;
  private String expirationMois;
  private String expirationAnnee;
  private int numeroAutorisation;
  public PaiementCarteCredit()
  {
  }


  public void setType(String type)
  {
    this.type = type;
  }


  public String getType()
  {
    return type;
  }


  public void setNumero(String numero)
  {
    this.numero = numero;
  }


  public String getNumero()
  {
    return numero;
  }


  public void setExpirationMois(String expirationMois)
  {
    this.expirationMois = expirationMois;
  }


  public String getExpirationMois()
  {
    return expirationMois;
  }


  public void setExpirationAnnee(String expirationAnnee)
  {
    this.expirationAnnee = expirationAnnee;
  }


  public String getExpirationAnnee()
  {
    return expirationAnnee;
  }


  public void setNumeroAutorisation(int numeroAutorisation)
  {
    this.numeroAutorisation = numeroAutorisation;
  }


  public int getNumeroAutorisation()
  {
    return numeroAutorisation;
  }
}