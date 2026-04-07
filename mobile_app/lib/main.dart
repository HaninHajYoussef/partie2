import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/etudiant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Étudiants',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const EtudiantListPage(),
    );
  }
}

class EtudiantListPage extends StatefulWidget {
  const EtudiantListPage({super.key});

  @override
  State<EtudiantListPage> createState() => _EtudiantListPageState();
}

class _EtudiantListPageState extends State<EtudiantListPage> {
  List<Etudiant> _etudiants = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchEtudiants();
  }

  Future<void> _fetchEtudiants() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // REMPLACEZ PAR VOTRE IP MACHINE !!!
      final response = await http.get(
        Uri.parse('http://192.168.1.X:8080/api/etudiants'),
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        setState(() {
          _etudiants = jsonResponse.map((e) => Etudiant.fromJson(e)).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Erreur: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erreur de connexion: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Étudiants'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_errorMessage!),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _fetchEtudiants,
                        child: const Text('Réessayer'),
                      ),
                    ],
                  ),
                )
              : _etudiants.isEmpty
                  ? const Center(child: Text('Aucun étudiant trouvé'))
                  : ListView.builder(
                      itemCount: _etudiants.length,
                      itemBuilder: (context, index) {
                        final e = _etudiants[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(e.cin.substring(0, 1)),
                            ),
                            title: Text(e.nom),
                            subtitle: Text('CIN: ${e.cin}'),
                            trailing: Text(e.dateNaissance),
                          ),
                        );
                      },
                    ),
    );
  }
}