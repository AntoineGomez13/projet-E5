import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  List<dynamic> maillots = [];
  List<dynamic> logs = [];

  @override
  void initState() {
    super.initState();
    _fetchMaillots();
    fetchLogs();
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

  Future<void> fetchLogs() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/log_maillots'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          logs = data;
        });
      } else {
        print('Erreur serveur : ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors de la récupération des logs : $e');
    }
  }

  Widget buildLogCard(dynamic log) {
    final nouveauContenu = json.decode(log['nouveau_contenu']);
    final ancienContenu = json.decode(log['ancien_contenu']);

    List<Widget> modifications = [];

    nouveauContenu.forEach((key, value) {
      final oldValue = ancienContenu[key];
      if (oldValue != value) {
        modifications.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              '$key : $oldValue → $value',
              style: const TextStyle(fontSize: 14),
            ),
          ),
        );
      }
    });

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        leading: log['lien_image'] != null
            ? Image.network(log['lien_image'], width: 50, height: 50, fit: BoxFit.cover)
            : const Icon(Icons.image_not_supported),
        title: Text(log['nom_equipe'] ?? 'Nom non disponible'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            const Text("Modifications :", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            ...modifications,
            const SizedBox(height: 6),
            Text(
              'Date : ${log['date_action']}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: logs.isEmpty
          ? const Center(child: Text('Aucune notification pour le moment.'))
          : ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                return buildLogCard(logs[index]);
              },
            ),
    );
  }
}
