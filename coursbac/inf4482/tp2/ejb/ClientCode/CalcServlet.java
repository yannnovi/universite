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
		// variable repr�sentant le r�sultat du calcul
		double resultat=0;
		
		// pr�paration de la r�ponse
		PrintWriter out;
		response.setContentType("text/html");
		out = response.getWriter();
		out.println("<HTML>");
		
		// en-t�te de la r�ponse
		out.println("<HEAD><TITLE>");
		out.println("Le calculateur : r�sultat");
		out.println("</TITLE></HEAD>");
		
		// le corps de la r�ponse
		out.println("<BODY>");
		try{
			// obtention des param�tres du formulaire HTML
			double parm1 = Double.parseDouble(request.getParameter("PREMIERNOMBRE"));
			double parm2 = Double.parseDouble(request.getParameter("DEUXIEMENOMBRE"));
			double parm3 = Double.parseDouble(request.getParameter("TROISIEMENOMBRE"));
			double parm4 = Double.parseDouble(request.getParameter("QUATRIEMENOMBRE"));

			// d�claration d'un nouveau contexte
			InitialContext ctx = new InitialContext();
			// obtention de l'interface Home du bean qui fera le calcul
			Object objref = ctx.lookup("CalcUnBean");
			CalcUnHome  homecalc1;
			homecalc1 = (CalcUnHome)PortableRemoteObject.narrow(objref, CalcUnHome.class);
			// obtention de l'interface m�tier du bean qui fera le calcul
			CalcUn leCalculateur;
			leCalculateur= homecalc1.create();
			// obtention du r�sultat en appelant la m�thode du bean qui fera le calcul
			resultat = leCalculateur.calcPartie1(parm1,parm2,parm3,parm4);
		} catch (Exception e) {
			out.println("excep:"+e);
		}
		
		// affichage du r�sultat
		out.println("<H1>Pr�sentation du r�sultat</H1>");
		out.println("<P>r�sultat: " + resultat + "<P>");
		out.println("</BODY></HTML>");
		out.close();
	}

	public void destroy() {
		System.out.println("Destroy");
	}
}