import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<dynamic> maillots = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMaillots();
  }

  Future<void> _fetchMaillots() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/maillots'));
      if (response.statusCode == 200) {
        setState(() {
          maillots = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        print('Erreur lors de la récupération des maillots');
      }
    } catch (e) {
      print('Erreur : $e');
    }
  }

  Widget _produitsScreen() {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: maillots.length,
            itemBuilder: (context, index) {
              final maillot = maillots[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MaillotDetailPage(maillot: maillot),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        maillot['lien_image'] ?? '',
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        maillot['nom_equipe'] ?? 'Équipe inconnue',
                        style:
                            const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text('Prix : ${maillot['prix'] ?? 'N/A'} €'),
                      Text(maillot['nom_championnat'] != null
                          ? 'Championnat : ${maillot['nom_championnat']}'
                          : 'Continent : ${maillot['continent'] ?? 'Inconnu'}'),
                      Text('Tailles : ${maillot['taille_disponible'] ?? 'Non spécifié'}'),
                    ],
                  ),
                ),
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _produitsScreen(),
    );
  }
}

class MaillotDetailPage extends StatelessWidget {
  final dynamic maillot;

  const MaillotDetailPage({super.key, required this.maillot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(maillot['nom_equipe'] ?? 'Détail du Maillot'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image centrée avec un border
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  maillot['lien_image'] ?? '',
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                ),
              ),
              const SizedBox(height: 20),
              // Nom de l'équipe
              Text(
                maillot['nom_equipe'] ?? 'Équipe inconnue',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              // Affichage des détails du maillot
              Text(
                'Championnat : ${maillot['nom_championnat'] ?? 'Inconnu'}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 5),
              Text(
                'Continent : ${maillot['continent'] ?? 'Inconnu'}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 5),
              Text(
                'Tailles : ${maillot['taille_disponible'] ?? 'Non spécifié'}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Stock : ${maillot['stock'] ?? 'Inconnu'}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              // Style pour afficher le prix sans possibilité de modification
              Text(
                'Prix : ${maillot['prix'] ?? 'N/A'} €',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
