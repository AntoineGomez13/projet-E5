import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CommandesPage extends StatefulWidget {
  const CommandesPage({super.key});

  @override
  State<CommandesPage> createState() => _CommandesPageState();
}

class _CommandesPageState extends State<CommandesPage> {
  List<dynamic> maillots = [];

  @override
  void initState() {
    super.initState();
    _fetchMaillots();
  }

  void _fetchMaillots() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/maillots'));
    if (response.statusCode == 200) {
      setState(() {
        maillots = json.decode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur lors du chargement des maillots')),
      );
    }
  }



  void _ajouterStock(int id, int stockActuel) {
    final TextEditingController _stockAjout = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Ajouter du stock'),
        content: TextField(
          controller: _stockAjout,
          decoration: const InputDecoration(labelText: 'Quantité à ajouter'),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () async {
              final ajout = int.tryParse(_stockAjout.text);
              if (ajout == null || ajout <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Veuillez entrer une quantité valide')),
                );
                return;
              }

              final nouveauStock = stockActuel + ajout;

              final response = await http.patch(
                Uri.parse('http://10.0.2.2:3000/maillots/$id'),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode({'stock': nouveauStock}),
              );

              Navigator.pop(context);

              if (response.statusCode == 200) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Stock mis à jour')),
                );
                _fetchMaillots();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Erreur : ${response.body}')),
                );
              }
            },
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }

  void _modifierPrix(int id, dynamic prixActuel) {
    final prixActuelDouble = prixActuel is String ? double.tryParse(prixActuel) : prixActuel;
    final TextEditingController _prixModif = TextEditingController(text: prixActuelDouble?.toString() ?? "0");

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Modifier le prix'),
        content: TextField(
          controller: _prixModif,
          decoration: const InputDecoration(labelText: 'Nouveau prix'),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
          ElevatedButton(
            onPressed: () async {
              final nouveauPrix = double.tryParse(_prixModif.text);
              if (nouveauPrix == null || nouveauPrix < 0) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Veuillez entrer un prix valide')));
                return;
              }

              final response = await http.patch(
                Uri.parse('http://10.0.2.2:3000/maillots/$id'),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode({'prix': nouveauPrix}),
              );

              Navigator.pop(context);

              if (response.statusCode == 200) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Prix mis à jour')));
                _fetchMaillots();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur : ${response.body}')));
              }
            },
            child: const Text('Modifier'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: maillots.length,
        itemBuilder: (context, index) {
          final maillot = maillots[index];
          return ListTile(
            leading: Image.network(
              maillot['lien_image'],
              width: 50,
              errorBuilder: (context, _, __) => const Icon(Icons.image_not_supported),
            ),
            title: Text(maillot['nom_equipe']),
            subtitle: Text("Prix : ${maillot['prix']} € | Stock : ${maillot['stock']}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _ajouterStock(maillot['id_maillot'], maillot['stock']),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _modifierPrix(maillot['id_maillot'], maillot['prix']),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
