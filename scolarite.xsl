<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <html>
      <head>
        <title>Liste des enseignants</title>
        <style>
          body {
            font-family: Arial, sans-serif;
          }

          h1 {
            text-align: center;
          }

          .center-table {
            margin: 0 auto; /* Centre la table horizontalement */
            max-width: 800px; /* Limite la largeur de la table */
          }

          table {
            border-collapse: collapse;
            width: 80%;
            margin-top: 20px;
            margin-left: 100px;
          }

          th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
          }

          tr:nth-child(even) {
            background-color: #f2f2f2;
          }

          p {
            margin-top: 10px;
            margin-bottom: 10px;
            margin-left: 100px;
          }
        </style>
      </head>
      <body>
        <h1 style="text-align:center">Liste des enseignants :</h1>
        <table border="1">
          <tr>
            <th>NSom</th>
            <th>CIN</th>
            <th>Sexe</th>
            <th>Nom</th>
            <th>Prenom</th>
            <th>Teles</th>
            <th>Emails</th>
          </tr>
          <xsl:for-each select="//Enseignants/Enseignant">
            <tr>
              <td><xsl:value-of select="@NSom" /></td>
              <td><xsl:value-of select="CIN" /></td>
              <td><xsl:value-of select="Sexe" /></td>
              <td><xsl:value-of select="Nom" /></td>
              <td><xsl:value-of select="Prenom" /></td>
              <td>
                <xsl:for-each select="Teles/Tele">
                  <xsl:value-of select="." />
                  <xsl:if test="position() &lt; last()"> <!-- Vérifiez si c'est le dernier élément -->
                    <xsl:text>, </xsl:text>
                  </xsl:if>
                </xsl:for-each>
              </td>
            <td>
              <xsl:for-each select="Emails/Email">
                <xsl:value-of select="." />
                <xsl:if test="position() &lt; last()"> <!-- Vérifiez si c'est le dernier élément -->
                  <xsl:text>, </xsl:text>
                </xsl:if>
              </xsl:for-each>
            </td>
            </tr>
          </xsl:for-each>
        </table>
        <h1 style="text-align:center">Liste des etudiants :</h1>

        <table border="1">
          <tr>
            <th>Numero d'inscription</th>
            <th>CIN</th>
            <th>Sexe</th>
            <th>Nom</th>
            <th>Prenom</th>
            <th>Teles</th>
            <th>Emails</th>
            <th>date de Naissance</th>
            <th>Adreese</th>
          </tr>
          <xsl:for-each select="//Etudiants/Etudiant">
            <tr>
              <td><xsl:value-of select="@NInsc" /></td>
              <td><xsl:value-of select="CIN" /></td>
              <td><xsl:value-of select="Sexe" /></td>
              <td><xsl:value-of select="Nom" /></td>
              <td><xsl:value-of select="Prenom" /></td>
              <td>
                <xsl:for-each select="Teles/Tele">
                  <xsl:value-of select="." />
                  <xsl:if test="position() &lt; last()"> <!-- Vérifiez si c'est le dernier élément -->
                    <xsl:text>, </xsl:text>
                  </xsl:if>
                </xsl:for-each>
              </td>
            <td>
              <xsl:for-each select="Emails/Email">
                <xsl:value-of select="." />
                <xsl:if test="position() &lt; last()"> <!-- Vérifiez si c'est le dernier élément -->
                  <xsl:text>, </xsl:text>
                </xsl:if>
              </xsl:for-each>
            </td>
            <td><xsl:value-of select="dateNaiss" /></td>
            <td>
              <xsl:for-each select="adresse">
              <xsl:value-of select="rue" />
              <xsl:text>-</xsl:text>
              <xsl:value-of select="numero" />
              <xsl:text>-</xsl:text>
              <xsl:value-of select="ville" />
            </xsl:for-each>

            </td>

            </tr>
          </xsl:for-each>
        </table>
        <h1 style="text-align:center">Details des modules:</h1>
        <xsl:for-each select="//Module">
  <!-- Ajoutez la clause xsl:sort pour trier par l'intitulé de la matière -->
  <xsl:sort select="Nom" />
  <p>Module : <xsl:value-of select="Nom" /></p>
  <p>Nom de coordinateur : 
    <xsl:variable name="teacherId" select="@NSom" />
    <xsl:value-of select="//Enseignants/Enseignant[@NSom = $teacherId]/Nom" />
    <xsl:text> </xsl:text> 
    <xsl:value-of select="//Enseignants/Enseignant[@NSom = $teacherId]/Prenom" />
  </p>
  <table border="1">
    <tr>
      <th>Matiere</th>
      <th>Coefficient</th>
      <th>Enseignant de la matiere</th>
    </tr>
    <!-- Utiliser une seule boucle for-each pour afficher les détails de chaque matière -->
    <xsl:for-each select="//Matieres/Matiere[@codeModule = current()/@codeModule]">
      <tr>
        <td><xsl:value-of select="intitule" /></td>
        <td><xsl:value-of select="coeff" /></td>
        <td>
          <!-- Utiliser le @NSom attribut pour rechercher les informations de l'enseignant -->
          <xsl:variable name="teacherId" select="@NSom" />
          <xsl:value-of select="//Enseignants/Enseignant[@NSom = $teacherId]/Nom" />
          <xsl:text> </xsl:text> 
          <xsl:value-of select="//Enseignants/Enseignant[@NSom = $teacherId]/Prenom" />
        </td>
      </tr>
    </xsl:for-each>
  </table>
</xsl:for-each>

        <h1 style="text-align:center">Notes des Etudiants:</h1>

        <table border="1" margin="4">
          <tr>
            <th>Matiere</th>
            <th>NoteType</th>
            <th>valeur</th>
            <th>Etudiant</th>
          </tr>
          <!-- Utiliser une seule boucle for-each pour afficher les détails de chaque matière -->
          <xsl:for-each select="//note">
            <tr>
              <td>
                <!-- Utiliser le @NSom attribut pour rechercher les informations de l'enseignant -->
                <xsl:variable name="matiereId" select="@codeMatiere" />
                <xsl:value-of select="//Matieres/Matiere[@codeMatiere = $matiereId]/intitule" />
              </td>

              <td><xsl:value-of select="NoteType" /></td>
              <td><xsl:value-of select="valeur" /></td>
              <td>
                <!-- Utiliser le @NSom attribut pour rechercher les informations de l'enseignant -->
                <xsl:variable name="etudiantId" select="@NInsc" />              
                <xsl:value-of select="//Etudiants/Etudiant[@NInsc = $etudiantId]/Nom" />
                <xsl:text> </xsl:text> <!-- Ajouter un espace entre le nom et le prénom -->
                <xsl:value-of select="//Etudiants/Etudiant[@NInsc = $etudiantId]/Prenom" />
              
              </td>
            </tr>
          </xsl:for-each>
        </table>


      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>