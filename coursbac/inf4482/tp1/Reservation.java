package beans;
                                                                                                      
public class Reservation implements java.io.Serializable
{
        private int numClient;
        private int numArticle;
	private int position;
                                                                                                      
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

	public int getPosition()
        {
                return position;
        }
                             
                             
        public void setPosition(int position)
        {
                this.position=position;
        }
	
}
