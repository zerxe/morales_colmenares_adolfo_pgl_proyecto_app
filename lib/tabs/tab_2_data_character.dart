import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/character.dart';
import '../provider/tab_index_provider.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    final Character? character =
        Provider.of<TabIndexProvider>(context).currentCharacter;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos de la Ficha de Personaje'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Detalles del personaje:\n'
                  'Nombre: ${character?.charaName ?? 'N/A'}\n'
                  'Clase: ${character?.charaClass ?? 'N/A'}\n'
                  'Fuerza: ${character?.str ?? 'N/A'}\n'
                  'Destreza: ${character?.dex ?? 'N/A'}\n'
                  'Constitución: ${character?.cons ?? 'N/A'}\n'
                  'Inteligencia: ${character?.inte ?? 'N/A'}\n'
                  'Sabiduría: ${character?.wis ?? 'N/A'}\n'
                  'Carisma: ${character?.cha ?? 'N/A'}\n'),
            ),
          ),
        ],
      ),
    );
  }
}
