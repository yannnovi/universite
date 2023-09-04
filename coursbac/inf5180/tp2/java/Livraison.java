package client;
import java.util.*;
public class Livraison 
{
  private int numeroLivraison;
  private int numeroFacture;
  private Set articles= new HashSet(); 
  
  public Livraison()
  {
    numeroLivraison=0;
    numeroFacture=0;
  }
  
  public void setNumeroFacture(int numeroFacture)
  {
    this.numeroFacture=numeroFacture;
  }
  
  public int getNumeroFacture()
  {
    return numeroFacture;
  }
  
  public void setNumeroLivraison(int numeroLivraison)
  {
    this.numeroLivraison=numeroLivraison;
  }
  
  public int getNumeroLivraison()
  {
    return numeroLivraison;    
  }
  
  public void ajoutArticleLivraison(ArticleLivraison a)
  {
    articles.add(a);
  }
  
  public Set getArticles()
  {
    return articles;
  }
}