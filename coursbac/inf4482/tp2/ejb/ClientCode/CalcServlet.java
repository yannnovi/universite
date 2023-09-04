import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import javax.naming.*;
import javax.rmi.PortableRemoteObject;
import Beans.*;

public class CalcServlet extends HttpServlet {
	
	// changer init ...
	public void init(ServletConfig config) throws ServletException{
	}

	public void doGet (HttpServletRequest request, HttpServletResponse response) 
								 throws ServletException, IOException
	{
		// variable représentant le résultat du calcul
		double resultat=0;
		
		// préparation de la réponse
		PrintWriter out;
		response.setContentType("text/html");
		out = response.getWriter();
		out.println("<HTML>");
		
		// en-tête de la réponse
		out.println("<HEAD><TITLE>");
		out.println("Le calculateur : résultat");
		out.println("</TITLE></HEAD>");
		
		// le corps de la réponse
		out.println("<BODY>");
		try{
			// obtention des paramètres du formulaire HTML
			double parm1 = Double.parseDouble(request.getParameter("PREMIERNOMBRE"));
			double parm2 = Double.parseDouble(request.getParameter("DEUXIEMENOMBRE"));
			double parm3 = Double.parseDouble(request.getParameter("TROISIEMENOMBRE"));
			double parm4 = Double.parseDouble(request.getParameter("QUATRIEMENOMBRE"));

			// déclaration d'un nouveau contexte
			InitialContext ctx = new InitialContext();
			// obtention de l'interface Home du bean qui fera le calcul
			Object objref = ctx.lookup("CalcUnBean");
			CalcUnHome  homecalc1;
			homecalc1 = (CalcUnHome)PortableRemoteObject.narrow(objref, CalcUnHome.class);
			// obtention de l'interface métier du bean qui fera le calcul
			CalcUn leCalculateur;
			leCalculateur= homecalc1.create();
			// obtention du résultat en appelant la méthode du bean qui fera le calcul
			resultat = leCalculateur.calcPartie1(parm1,parm2,parm3,parm4);
		} catch (Exception e) {
			out.println("excep:"+e);
		}
		
		// affichage du résultat
		out.println("<H1>Présentation du résultat</H1>");
		out.println("<P>résultat: " + resultat + "<P>");
		out.println("</BODY></HTML>");
		out.close();
	}

	public void destroy() {
		System.out.println("Destroy");
	}
}