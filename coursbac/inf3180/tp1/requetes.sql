/* $Id: requetes.sql,v 1.11 2004/10/15 16:00:49 Yann Exp $ */
SET echo ON
SET term ON

spool requetes.OUT
/* Par Yann Bourdeau BOUY06097202 */

/* requete 1*/
/* (nombre de morceaux dont l'auteur est connu)/(nombre de morceaux dont le compositeur est connu)*/
SELECT round(count(Id_artiste_compositeur)/count(Id_artiste_auteur),3) AS "Rapport auteurs/compositeurs"
FROM morceau_t;

/* requete 2*/
/* Afficher le titre de chaque morceau recense dans la base de donnees,
   suivi du nombre d'artistes distincts ayant joue d'un instrument
   different de VOIX et de CHOEUR dans au moins deux interpretations
   du morceau (afficher le message  aucun artiste et lorsqu'il n'y en a aucun).*/
SELECT m.id_morceau,titre,TO_CHAR(count(DISTINCT(id_artiste))) AS NBARTISTES
FROM interpretation_t i, details_interpretation_t d, instrument_t ins, morceau_t m
WHERE m.id_morceau =i.id_morceau
      AND
      i.id_interpretation = d.id_interpretation
      AND
      d.id_instrument= ins.id_instrument
      AND
      ins.Nom_instrument <> 'VOIX'
      AND
      ins.Nom_instrument <> 'CHOEUR'
      AND
      i.id_interpretation IN (
                              SELECT DISTINCT int.id_interpretation
                              FROM interpretation_t int ,interpretation_t int2
                              WHERE int.id_interpretation <> int2.id_interpretation
                                  AND
                                  int.id_morceau = int2.id_morceau)
     AND
     d.id_artiste IN (SELECT det.id_artiste
                      FROM details_interpretation_t det,interpretation_t int,instrument_t ins2
                      WHERE det.id_interpretation = int.id_interpretation
                            AND
                            int.id_interpretation <> i.id_interpretation
                            AND
                            int.id_morceau = i.id_morceau
                            AND
                            det.id_instrument = ins2.id_instrument
                            AND
                            ins2.Nom_instrument <> 'VOIX'
                            AND
                            ins2.Nom_instrument <> 'CHOEUR'
                      )
GROUP BY m.id_morceau,titre
UNION
   SELECT m.id_morceau,titre,'AUCUN ARTISTE' AS NBARTISTES
   FROM morceau_t m
   WHERE m.id_morceau NOT IN (
      SELECT m.id_morceau
      FROM interpretation_t i, details_interpretation_t d, instrument_t ins, morceau_t m
      WHERE m.id_morceau =i.id_morceau
      AND
      i.id_interpretation = d.id_interpretation
      AND
      d.id_instrument= ins.id_instrument
      AND
      ins.Nom_instrument <> 'VOIX'
      AND
      ins.Nom_instrument <> 'CHOEUR'
      AND
      i.id_interpretation IN (
                              SELECT DISTINCT int.id_interpretation
                              FROM interpretation_t int ,interpretation_t int2
                              WHERE int.id_interpretation <> int2.id_interpretation
                                  AND
                                  int.id_morceau = int2.id_morceau)
     AND
     d.id_artiste IN (SELECT det.id_artiste
                      FROM details_interpretation_t det,interpretation_t int,instrument_t ins2
                      WHERE det.id_interpretation = int.id_interpretation
                            AND
                            int.id_interpretation <> i.id_interpretation
                            AND
                            int.id_morceau = i.id_morceau
                            AND
                            det.id_instrument = ins2.id_instrument
                            AND
                            ins2.Nom_instrument <> 'VOIX'
                            AND
                            ins2.Nom_instrument <> 'CHOEUR')
      GROUP BY m.id_morceau)
GROUP BY m.id_morceau,titre;

/* requete 3 */
/* Afficher les titres des morceaux qui apparaissent dans plus d un album de la base de donnees */
SELECT DISTINCT m.titre
FROM morceau_t m,interpretation_t i, album_t a
WHERE m.id_morceau = i.id_morceau
      AND
      i.id_album = a.id_album
      AND
      2 <= (SELECT count(*)
                     FROM album_t a2,interpretation_t i2
                     WHERE a2.id_album = i2.id_album
                           AND
                           i.id_morceau = i2.id_morceau);


/* requete 4*/
/*  Afficher le titre de chaque morceau recense dans la base de donnees,
    suivi du nombre d'artistes distincts ayant joue d'au moins deux
    instruments distincts dans chacune des interpretations
    du morceau (afficher le message  aucun artiste  lorsqu'il n'y en a aucun). */
SELECT distinct i.id_morceau, m.titre, TO_CHAR(count (distinct(d.id_artiste))) AS NBARTISTES
FROM interpretation_t i, details_interpretation_t d,morceau_t m
WHERE i.id_interpretation=d.id_interpretation
      AND
      m.id_morceau = i.id_morceau
      AND
      EXISTS (SELECT *
            FROM  details_interpretation_t d2
            WHERE d.id_interpretation = d2.id_interpretation
                  AND
                  d.id_instrument <> d2.id_instrument
                  AND
                  d.id_artiste = d2.id_artiste)
      AND
      (SELECT DISTINCT count(i2.id_interpretation)
         FROM morceau_t m2,interpretation_t i2
         WHERE m2.id_morceau=i2.id_morceau
               AND
               i2.id_morceau=i.id_morceau)
      =
       (SELECT count(DISTINCT i2.id_interpretation)
         FROM morceau_t m2,interpretation_t i2,details_interpretation_t d2
         WHERE m2.id_morceau=i2.id_morceau
         AND
         i2.id_interpretation = d2.id_interpretation
         AND
         d2.id_artiste = d.id_artiste
         AND
         m2.id_morceau = m.id_morceau
         AND
         EXISTS (SELECT *
            FROM  details_interpretation_t d3
            WHERE d2.id_interpretation = d3.id_interpretation
                  AND
                  d2.id_instrument <> d3.id_instrument
                  AND
                  d2.id_artiste = d3.id_artiste))
GROUP BY i.id_morceau, m.titre
UNION
SELECT m.id_morceau, m.titre, 'AUCUN ARTISTE' AS NBARTISTES
FROM morceau_t m
WHERE m.id_morceau NOT IN
   (SELECT distinct i.id_morceau
   FROM interpretation_t i, details_interpretation_t d,morceau_t m
   WHERE i.id_interpretation=d.id_interpretation
         AND
         m.id_morceau = i.id_morceau
         AND
         EXISTS (SELECT *
               FROM  details_interpretation_t d2
               WHERE d.id_interpretation = d2.id_interpretation
                     AND
                     d.id_instrument <> d2.id_instrument
                     AND
                     d.id_artiste = d2.id_artiste)
         AND
         (SELECT DISTINCT count(i2.id_interpretation)
            FROM morceau_t m2,interpretation_t i2
            WHERE m2.id_morceau=i2.id_morceau
                  AND
                  i2.id_morceau=i.id_morceau)
         =
          (SELECT count(DISTINCT i2.id_interpretation)
            FROM morceau_t m2,interpretation_t i2,details_interpretation_t d2
            WHERE m2.id_morceau=i2.id_morceau
            AND
            i2.id_interpretation = d2.id_interpretation
            AND
            d2.id_artiste = d.id_artiste
            AND
            m2.id_morceau = m.id_morceau
            AND
            EXISTS (SELECT *
               FROM  details_interpretation_t d3
               WHERE d2.id_interpretation = d3.id_interpretation
                     AND
                     d2.id_instrument <> d3.id_instrument
                     AND
                     d2.id_artiste = d3.id_artiste))
   GROUP BY i.id_morceau)
GROUP BY m.id_morceau,m.titre;

/* requete 5 */
/* Affichez le nombre moyen de morceaux par album */
SELECT TO_CHAR(round(COUNT(id_album)/count(DISTINCT id_album),3),'B99.999') AS "Moyenne"
FROM interpretation_t;

/* requete 6 */
/* Afficher par ordre croissant de nom, la liste des auteurs de morceaux
   ayant joue d'un instrument dans toutes les interpretations de chacun
   de leurs morceaux. Vous devez egalement afficher les titres des morceaux
   de ces auteurs */
SELECT m.id_artiste_auteur,a.nom,a.prenom,TO_CHAR(a.datenaissance,'DD/MM/YYYY') AS DATENAISSANCE,m.titre
FROM morceau_t m,artiste_t a, interpretation_t i
WHERE m.id_morceau = i.id_morceau
      AND
      a.id_artiste = m.id_artiste_auteur
      AND
      (SELECT count(*)
       FROM morceau_t m2,interpretation_t i2
       WHERE m2.id_morceau = i2.id_morceau
             AND
             m2.id_artiste_auteur=m.id_artiste_auteur
             AND
             m2.id_morceau=m.id_morceau
      )
      =
      (SELECT count(*)
       FROM morceau_t m2,interpretation_t i2
       WHERE m2.id_morceau = i2.id_morceau
             AND
             m2.id_artiste_auteur=m.id_artiste_auteur
             AND
             m2.id_morceau = i.id_morceau
             AND EXISTS (SELECT *
                         FROM interpretation_t i3,details_interpretation_t d3
                         WHERE i3.id_interpretation = d3.id_interpretation
                               AND
                               i3.id_interpretation = i2.id_interpretation
                               AND
                               d3.id_artiste = m2.id_artiste_auteur)
      )
ORDER BY a.nom;

/* requete 7 */
/* Afficher les titres des albums comptant au moins 2 morceaux dont les
   compositeurs, nes avant 1970, sont egalement auteurs d'au moins un
   morceau de la base de donnees. Vous devez egalement afficher
   le nombre de morceaux que ces albums comptent effectivement.*/
SELECT al2.titre,count(m2.titre) AS NB_MORCEAUX
FROM album_t al2,interpretation_t i2, morceau_t m2,artiste_t a2
WHERE al2.id_album=i2.id_album
      AND
      m2.id_morceau = i2.id_morceau
      AND
      a2.id_artiste = m2.id_artiste_compositeur
      AND
      a2.datenaissance < TO_DATE('1970', 'YYYY')
      AND
      EXISTS(SELECT *
             FROM album_t al3,interpretation_t i3, morceau_t m3
             WHERE al3.id_album=i3.id_album
               AND
               m3.id_morceau = i3.id_morceau
               AND
               m3.id_artiste_auteur = m2.id_artiste_compositeur)
GROUP BY al2.titre
HAVING count(m2.titre) >= 2;

/* requete 8 */
/* Afficher les codes des catalogues qui comptent le plus grand
   nombre d'albums. Vous devez egalement afficher le nombre d'albums
   que ces catalogues comptent effectivement. */
SELECT a.code_catalogue, COUNT( a.id_album) AS NB_ALBUMS
FROM album_t a
GROUP BY a.code_catalogue
HAVING COUNT( a.id_album) >= ALL (SELECT  COUNT( a2.id_album) FROM album_t a2 GROUP BY a2.code_catalogue);


/* Requete 9 */
/* Afficher par ordre croissant de nom, la liste des artistes qui
   jouent d'au moins 3 instruments distincts avec les identifiants des
   instruments qu'ils jouent. Les artistes qui ne jouent
   d'aucun instrument doivent également figurer dans la liste
   (devant leurs noms afficher le message 'NE JOUE D'AUCUN INSTRUMENT').
   NB : Vous ne devez pas afficher deux lignes identiques */
SELECT DISTINCT a.id_artiste,a.nom,a.prenom,decode(d.id_instrument,NULL,'ne joue d''aucun instrument',d.id_instrument) AS IDINSTRUMENT
FROM details_interpretation_t d,artiste_t a
WHERE a.id_artiste=d.id_artiste(+)
      AND
      ((SELECT count(DISTINCT d2.id_instrument)
       FROM details_interpretation_t d2
       WHERE d2.id_artiste=a.id_artiste)
       >=3
      OR
      (SELECT count(DISTINCT d2.id_instrument)
       FROM details_interpretation_t d2
       WHERE d2.id_artiste=a.id_artiste)
       =0)
ORDER BY a.nom;

/* requete 10 */
/* Parmi les albums qui comptent le plus nombre grand d'exemplaires vendus,
   afficher les titres de ceux qui comptent le plus grand nombre de morceaux.
   Vous devez egalement afficher le nombre d'exemplaires effectivement vendus
   et le nombre de morceaux pour ces albums ainsi que les noms des artistes principaux. */
SELECT a.titre AS "TITRE ALBUM",TO_CHAR(ar.id_Artiste,'9') || ' ' || ar.nom || ' ' || ar.prenom AS "Artiste Principal",a.nbExemplairesVendus AS "NB Exemplaire vendus", count(i.id_morceau) AS NBMORCEAUX
FROM album_t a,artiste_principal_t ap,artiste_t ar,interpretation_t i
WHERE a.id_album=ap.id_album
      AND
      ap.id_artiste=ar.id_artiste
      AND
      i.id_album=a.id_album
      AND
      a.nbExemplairesVendus >= ALL (SELECT a2.nbExemplairesVendus FROM album_t a2)
GROUP BY a.titre,ar.id_Artiste,ar.nom,ar.prenom,a.nbExemplairesVendus
HAVING count(i.id_morceau) >= ALL  (SELECT  count(i2.id_morceau)
                                   FROM album_t a2,artiste_principal_t ap2,artiste_t ar2,interpretation_t i2
                                   WHERE a2.id_album=ap2.id_album
                                   AND
                                    ap2.id_artiste=ar2.id_artiste
                                    AND
                                    i2.id_album=a2.id_album
                                    AND
                                    a2.nbExemplairesVendus >= ALL (SELECT a3.nbExemplairesVendus FROM album_t a3)
                                    GROUP BY a2.titre,ar2.id_Artiste,ar2.nom,a2.nbExemplairesVendus);
   

/* requete 11 */
/* Fournissez la liste des morceaux (vous preciserez leur titre et
   le nom de leur auteur), dont toutes les interpretations n'ont fait
   appel qu'aux instruments VOIX et/ou CHOEUR. */
SELECT m.titre,TO_CHAR(a.id_artiste,'9') || ' ' || a.nom || ' ' ||  a.prenom AS auteur
FROM artiste_t a,morceau_t m,interpretation_t i, details_interpretation_t d
WHERE a.id_artiste=m.id_artiste_auteur
      AND
      m.id_morceau = i.id_morceau
      AND
      i.id_interpretation = d.id_interpretation
      AND
      (
      SELECT count(DISTINCT ins2.id_instrument)
      FROM instrument_t ins2,details_interpretation_t d2,interpretation_t i2
      WHERE d2.id_interpretation = i2.id_interpretation
            AND
            ins2.id_instrument = d2.id_instrument
            AND
            i2.id_morceau = i.id_morceau
      )
      =
      (
      SELECT count(DISTINCT ins2.id_instrument)
      FROM instrument_t ins2,details_interpretation_t d2,interpretation_t i2
      WHERE d2.id_interpretation = i2.id_interpretation
            AND
            ins2.id_instrument = d2.id_instrument
            AND
            i2.id_morceau = i.id_morceau
            AND
            (
            ins2.nom_instrument = 'VOIX'
            OR
            ins2.nom_instrument = 'CHOEUR'
             )
      );



/* Requete 12 */
/* Afficher les titres des morceaux composes par l'artiste qui compte le
   plus grand nombre de compositions de la base de donnees. Le nom de l'artiste
   doit egalement etre affiche, ainsi que le nombre d'interpretations existantes
   pour chaque morceau selectionne. */
SELECT m.titre AS "TITRE MORCEAU", a.nom || ' ' || a.prenom AS COMPOSITEUR, count(DISTINCT i.ID_interpretation) AS "NB INTERPRETATION"
FROM morceau_t m, artiste_t a,interpretation_t i
WHERE m.id_morceau = i.id_morceau
      AND
      m.id_artiste_compositeur = a.id_artiste
      AND
      ((SELECT count(z.id_morceau)
       FROM morceau_t z
       WHERE z.id_artiste_compositeur=m.id_artiste_compositeur)
      >=
      (SELECT  MAX(count(m2.id_morceau))
       FROM morceau_t m2
       GROUP BY m2.id_artiste_compositeur))
GROUP BY m.titre , a.nom , a.prenom;


/* requete 13*/
/* Afficher les noms des artistes principaux repertories dans la base de donnees. Pour chacun
   de ces artistes, vous afficherez le titre du premier et du dernier album auquel il a participe en
   jouant d'au moins un instrument*/
SELECT DISTINCT a.nom || ' ' || a.prenom AS "ARTISTE PRINCIPAL", al1.titre AS "TITRE 1er ALBUM", al2.titre AS "TITRE DERNIER ALBUM", TO_CHAR(al1.date_sortie,'YY-MM-DD') AS "DATE_SOR",TO_CHAR(al2.date_sortie,'YY-MM-DD') AS "DATE_SOR"
FROM album_t al1,album_t al2,artiste_principal_t ap,artiste_t a,interpretation_t i, details_interpretation_t d,interpretation_t i2, details_interpretation_t d2
WHERE a.id_artiste = ap.id_artiste
      AND
      d.id_interpretation = i.id_interpretation
      AND
      d2.id_interpretation = i2.id_interpretation
      AND
      i.id_album = al1.id_album
      AND
      i2.id_album = al2.id_album
      AND
      d.id_artiste=a.id_artiste
      AND
      d2.id_artiste=a.id_artiste
      AND
      al1.date_sortie 
      <= ALL 
       (SELECT al3.date_sortie
        FROM album_t al3,interpretation_t i3,details_interpretation_t d3
        WHERE 
             i3.id_album = al3.id_Album
             AND
             d3.id_interpretation = i3.id_interpretation
             AND
             d3.id_artiste = ap.id_artiste)
      AND
      al2.date_sortie
      >= ALL
      (SELECT al3.date_sortie
       FROM album_t al3,interpretation_t i3,details_interpretation_t d3
        WHERE 
             i3.id_album = al3.id_Album
             AND
             d3.id_interpretation = i3.id_interpretation
             AND
             d3.id_artiste = ap.id_artiste);

/* requete 14 */
/* Afficher les noms des instruments (autres que 'VOIX') les plus utilises dans les
   interpretations (ceux qui sont le plus references dans la table Details_Interpretation) */
SELECT i.nom_instrument AS "nom instrument", count(i.nom_instrument) AS "NOMBRE DE REFERENCES"
FROM instrument_t i, details_interpretation_t d
WHERE i.id_instrument = d.id_instrument
      AND
      i.nom_instrument <> 'VOIX'
GROUP BY i.nom_instrument
HAVING count(i.nom_instrument) >= ALL (SELECT count(i.nom_instrument)
                                       FROM instrument_t i, details_interpretation_t d
                                       WHERE i.id_instrument = d.id_instrument
                                             AND
                                             i.nom_instrument <> 'VOIX'
                                       GROUP BY i.nom_instrument);

                                            
/* requete 15 */
/* Afficher les noms des auteurs de morceaux repertories dans la base de donnees. Pour chacun
   de ces auteurs, vous afficherez le nombre total d'interpretations distinctes de morceaux
   auxquelles il a participe en jouant d'au moins un instrument. */
SELECT a.nom || ' ' || a.prenom AS AUTEUR, count(DISTINCT d.id_interpretation)
FROM artiste_t a, morceau_t m, interpretation_t i, details_interpretation_t d
WHERE a.id_artiste = m.id_artiste_auteur
      AND
      i.id_interpretation = d.id_interpretation
      AND
      d.id_artiste = a.id_artiste
GROUP BY a.nom , a.prenom;


spool off 


