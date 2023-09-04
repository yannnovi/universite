package client;

public class ArticleLivraison 
{
  private int numeroArticle;
  private int quantite;
  private float prixUnitaire;
  private float prixUnitaireRabais;
  
  public ArticleLivraison()
  {
    numeroArticle=0;
    quantite=0;
    prixUnitaire=0;
    prixUnitaireRabais=0;  
  }
  
  public void setNumeroArticle(int numeroArticle)
  {
    this.numeroArticle=numeroArticle;
  }
  
  public int getNumeroArticle()
  {
    return numeroArticle;
  }
  
  public void setQuantite(int quantite)
  {
    this.quantite=quantite;
  }
  
  public int getQuantite()
  {
    return quantite;
  }
  
  public void setPrixUnitaire(float prixUnitaire)
  {
    this.prixUnitaire=prixUnitaire;
  }
  
  public float getPrixUnitaire()
  {
    return prixUnitaire;
  }
  
  public void setPrixUnitaireRabais(float prixUnitaireRabais)
  {
    this.prixUnitaireRabais=prixUnitaireRabais;
  }
  
  public float getPrixUnitaireRabais()
  {
    return prixUnitaireRabais;
  }
  public String toString()
    {
        return  "" + numeroArticle + "," + quantite + ","+ prixUnitaire + "," + (prixUnitaireRabais*100) +'%' ;
    }


}