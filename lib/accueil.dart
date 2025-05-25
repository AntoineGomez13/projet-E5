// ignore_for_file: unused_import

import 'package:application_e5/commandes.dart';
import 'package:application_e5/messages.dart';
import 'package:flutter/material.dart';
import 'produits.dart'; // Importer la page Produits
import 'profil.dart'; // Importer la page Profil

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maillots2Foot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: const MyHomePage(email: 'email'), // Passer l'email ici
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String email;

  const MyHomePage({Key? key, required this.email}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  // Liste des écrans>
  final List<Widget> _screens = <Widget>[
    const Center(child: Text('Accueil')),
    const ProductsPage(),
    const CommandesPage(), // Page des commandes
    const MessagesPage(),
    ProfilPage(email: ''), // L'email sera ajouté plus tard
  ];

  // Méthode appelée lorsque l'utilisateur clique sur un élément de la barre de navigation.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Mettre à jour la page de profil avec l'email passé depuis MyHomePage
    _screens[4] = ProfilPage(email: widget.email);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maillots2Foot'),
        backgroundColor: Colors.red,
      ),
      body: _screens[_selectedIndex], // Affichage de l'écran sélectionné
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Changer l'écran selon l'élément sélectionné
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Produits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Commandes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

