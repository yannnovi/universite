package net.homeip.codeyann.hibernate;

import org.hibernate.*;
import org.hibernate.cfg.*;

public class HibernateUtil 
{	
    public static final SessionFactory sessionFactory;
    public static final ThreadLocal session = new ThreadLocal();
    
    public static SessionFactory getSessionFactory() 
    {
        return sessionFactory;
    }
    
    static 
    {
        try 
        {
            // Création de la SessionFactory à partir de hibernate.cfg.xml
            sessionFactory = new Configuration().configure().buildSessionFactory();
        } 
        catch (Throwable ex) 
        {
            System.err.println("Initial SessionFactory creation failed." + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }
}