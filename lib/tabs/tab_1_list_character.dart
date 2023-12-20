import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:universal_html/html.dart' as html;
import '../model/character.dart';
import '../character_form.dart';
import '../provider/auth_provider.dart';
import 'package:provider/provider.dart';
import '../provider/tab_index_provider.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  Page2State createState() => Page2State();
}

class Page2State extends State<Page2> {
  List<Character> characters = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      String data = '';

      if (kIsWeb) {
        data = (await html.window.localStorage['characters']) ?? '[]';
      } else {
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/characters.json');
        data = await file.readAsString();
      }

      setState(() {
        characters = (jsonDecode(data) as List<dynamic>)
            .map((e) => Character.fromJson(e))
            .toList();
      });
    } catch (e) {
      //print('Error loading characters: $e');
    }
  }

  Future<void> _saveData() async {
    try {
      final data = jsonEncode(characters.map((e) => e.toJson()).toList());

      if (kIsWeb) {
        (html.window.localStorage as html.Storage)['characters'] = data;
      } else {
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/characters.json');
        await file.writeAsString(data);
      }
    } catch (e) {
      //print('Error saving character: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de personajes'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => _openCharacterForm(null),
            child: const Text('Crear Personaje'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];
                return ListTile(
                  title: Text(character.charaName),
                  subtitle: Text(
                    'Clase: ${character.charaClass}, Nivel: ${character.level}',
                  ),
                  onTap: () => _openCharacterDetails(character),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _openCharacterForm(character),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteCharacter(character),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _openCharacterForm(Character? character) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final updatedCharacter = await Navigator.of(context).push<Character?>(
      MaterialPageRoute(
        builder: (context) => CharacterForm(
          character: character,
          authProvider: authProvider,
        ),
      ),
    );

    if (updatedCharacter != null) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      String? userEmail = authProvider.getUserEmail();
      updatedCharacter.userEmail = userEmail;

      final index = characters
          .indexWhere((c) => c.charaName == updatedCharacter.charaName);
      if (index != -1) {
        setState(() {
          characters[index] = updatedCharacter;
          _saveData();
        });
      } else {
        _saveCharacter(updatedCharacter);
      }
    }
  }

  void _saveCharacter(Character character) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    String? userEmail = authProvider.getUserEmail();
    character.userEmail = userEmail;

    setState(() {
      characters.add(character);
      _saveData();
    });
  }

  void _deleteCharacter(Character character) {
    setState(() {
      characters.remove(character);
      _saveData();
    });
  }

  void _openCharacterDetails(Character character) async {
    final tabIndexProvider = context.read<TabIndexProvider>();

    tabIndexProvider.currentCharacter = character;
    tabIndexProvider.setTabIndex(2);
    DefaultTabController.of(context).animateTo(2);
  }
}
