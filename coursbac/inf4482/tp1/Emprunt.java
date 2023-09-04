package beans;

import java.util.Date;

public class Emprunt implements java.io.Serializable
{
	private int numClient;
	private int numArticle;
	private Date dateDebut;
	private Date dateFin;

	public int getNumClient()
	{
		return numClient;
	}

	public void setNumClient(int numClient)
	{
		this.numClient=numClient;
	}

	public int getNumArticle()
        {
                return numArticle;
        }
                                                                                
        public void setNumArticle(int numArticle)
        {
                this.numArticle=numArticle;
        }
	
	public Date getDateDebut()
        {
                return dateDebut;
        }
                                                                                
        public void setDateDebut(Date dateDebut)
        {
                this.dateDebut=dateDebut;
        }
	
	public Date getDateFin()
        {
                return dateFin;
        }
                                                                                
        public void setDateFin(Date dateFin)
        {
                this.dateFin=dateFin;
        }
	
}
