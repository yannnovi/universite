package client;

import java.util.*;

public class Paiement 
{
  private int numeroFacture=0;
  private float montantPaye=0;
  private Date dateReception;
  public Paiement()
  {
  }


  public void setNumeroFacture(int numeroFacture)
  {
    this.numeroFacture = numeroFacture;
  }


  public int getNumeroFacture()
  {
    return numeroFacture;
  }


  public void setMontantPaye(float montantPaye)
  {
    this.montantPaye = montantPaye;
  }


  public float getMontantPaye()
  {
    return montantPaye;
  }


  public void setDateReception(Date dateReception)
  {
    this.dateReception = dateReception;
  }


  public Date getDateReception()
  {
    return dateReception;
  }
}