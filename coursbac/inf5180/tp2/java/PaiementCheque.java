package client;

public class PaiementCheque  extends Paiement
{
  private int numeroCheque;
  private String dateCheque; // format yyyy/mm/dd
  private int compte;
  private int banque;
  
  
  public PaiementCheque()
  {
    
  }


  public void setNumeroCheque(int numeroCheque)
  {
    this.numeroCheque = numeroCheque;
  }


  public int getNumeroCheque()
  {
    return numeroCheque;
  }


  public void setDateCheque(String dateCheque)
  {
    this.dateCheque = dateCheque;
  }


  public String getDateCheque()
  {
    return dateCheque;
  }


  public void setCompte(int compte)
  {
    this.compte = compte;
  }


  public int getCompte()
  {
    return compte;
  }


  public void setBanque(int banque)
  {
    this.banque = banque;
  }


  public int getBanque()
  {
    return banque;
  }
}