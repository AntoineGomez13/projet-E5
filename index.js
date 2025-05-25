const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const bcrypt = require('bcrypt'); // Ajoute bcrypt pour le hachage des mots de passe

const app = express();
const port = 3000;

// Middleware pour parser le body des requêtes en JSON
app.use(bodyParser.json());

// Configuration de la connexion à MySQL
const db = mysql.createConnection({
  host: '10.50.0.80', // Remplacez par l'IP de votre serveur MySQL
  user: 'antoine', // Nom d'utilisateur de la base de données
  password: '050405Ag', // Mot de passe de la base de données
  database: 'maillots2foot', // Nom de la base de données
  connectTimeout: 10000
});

// Connexion à MySQL
db.connect((err) => {
  if (err) {
    console.error('Erreur de connexion à MySQL:', err);
    return;
  }
  console.log('Connecté à la base de données MySQL');
});

// Route pour enregistrer un nouvel utilisateur
app.post('/register', async (req, res) => {
  const { email, password } = req.body;
  if (!email || !password) {
    return res.status(400).send('Email et mot de passe requis');
  }

  // Hachage du mot de passe avant de l'enregistrer
  const hashedPassword = await bcrypt.hash(password, 10);

  const query = 'INSERT INTO users (email, password) VALUES (?, ?)';
  db.query(query, [email, hashedPassword], (err, result) => {
    if (err) {
      console.error('Erreur lors de l\'insertion de l\'utilisateur:', err);
      return res.status(500).send('Erreur lors de l\'inscription');
    }
    res.status(200).send('Inscription réussie');
  });
});

// Route pour la connexion de l'utilisateur
app.post('/login', async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).send('Email et mot de passe requis');
  }

  const query = 'SELECT * FROM users WHERE email = ?';
  db.query(query, [email], async (err, results) => {
    if (err) {
      console.error('Erreur lors de la requête :', err);
      return res.status(500).send('Erreur serveur');
    }

    if (results.length === 0) {
      return res.status(401).send('Email non trouvé');
    }

    const user = results[0];
    
    // Vérification du mot de passe avec bcrypt.compare()
    const passwordMatch = await bcrypt.compare(password, user.password);
    if (!passwordMatch) {
      return res.status(401).send('Mot de passe incorrect');
    }

    // Si l'email et le mot de passe sont corrects
    res.status(200).send('Connexion réussie');
  });
});

// Route pour récupérer les maillots
app.get('/maillots', (req, res) => {
  const query = `
    SELECT 
      maillots.id_maillot,
      maillots.nom_equipe,
      championnats.nom AS nom_championnat,
      pays.nom AS nom_pays,
      pays.continent,
      maillots.prix,
      maillots.taille_disponible,
      maillots.lien_image,
      maillots.stock
    FROM 
      maillots
    LEFT JOIN 
      championnats ON maillots.id_championnat = championnats.id_championnat
    LEFT JOIN 
      pays ON maillots.id_pays = pays.id_pays
  `;

  db.query(query, (err, results) => {
    if (err) {
      console.error('Erreur lors de la récupération des maillots :', err);
      return res.status(500).send('Erreur serveur');
    }
    res.json(results);
  });
});

// Route pour modifier le prix et/ou le stock d'un maillot
app.patch('/maillots/:id', (req, res) => {
  const { id } = req.params;
  const { prix, stock } = req.body;

  console.log(`Requête PATCH reçue - ID: ${id}, Prix reçu: ${prix}, Stock reçu: ${stock}`);

  const fields = [];
  const values = [];

  if (prix !== undefined) {
    if (isNaN(prix)) {
      console.log('Prix invalide fourni.');
      return res.status(400).send('Un prix valide est requis');
    }
    fields.push('prix = ?');
    values.push(prix);
  }

  if (stock !== undefined) {
    if (isNaN(stock)) {
      console.log('Stock invalide fourni.');
      return res.status(400).send('Un stock valide est requis');
    }
    fields.push('stock = ?');
    values.push(stock);
  }

  if (fields.length === 0) {
    console.log('Aucun champ valide à mettre à jour.');
    return res.status(400).send('Aucun champ valide à mettre à jour');
  }

  const query = `UPDATE maillots SET ${fields.join(', ')} WHERE id_maillot = ?`;
  values.push(id);

  db.query(query, values, (err, result) => {
    if (err) {
      console.error('Erreur lors de la mise à jour :', err);
      return res.status(500).send('Erreur serveur');
    }

    if (result.affectedRows === 0) {
      console.log(`Aucun maillot trouvé pour l'ID : ${id}`);
      return res.status(404).send('Maillot non trouvé');
    }

    console.log(`Maillot ID ${id} mis à jour avec succès.`);
    res.status(200).send('Maillot mis à jour avec succès');
  });
});

// Route pour récupérer les logs depuis log_maillots
app.get('/logs', (req, res) => {
  const query = `
    SELECT 
      log_maillots.id,
      log_maillots.id_maillot,
      log_maillots.date_action,
      log_maillots.ancien_contenu,
      log_maillots.nouveau_contenu,
      maillots.nom_equipe,
      maillots.lien_image
    FROM 
      log_maillots
    JOIN 
      maillots ON log_maillots.id_maillot = maillots.id_maillot
    ORDER BY log_maillots.date_action DESC
  `;

  db.query(query, (err, results) => {
    if (err) {
      console.error('Erreur lors de la récupération des logs :', err);
      return res.status(500).send('Erreur serveur');
    }
    res.json(results);
  });
});



// Démarrage du serveur
app.listen(port, () => {
  console.log(`Serveur API en écoute sur http://localhost:${port}`);
});
