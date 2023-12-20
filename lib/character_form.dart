import 'package:flutter/material.dart';
import '../model/character.dart';
import 'provider/auth_provider.dart';

class CharacterForm extends StatefulWidget {
  final Character? character;
  final AuthProvider authProvider;

  const CharacterForm({super.key, this.character, required this.authProvider});

  @override
  CharacterFormState createState() => CharacterFormState();
}

class CharacterFormState extends State<CharacterForm> {
  late TextEditingController _charaNameController;
  late TextEditingController _charaClassController;
  late TextEditingController _levelController;
  late TextEditingController _strController;
  late TextEditingController _dexController;
  late TextEditingController _consController;
  late TextEditingController _inteController;
  late TextEditingController _wisController;
  late TextEditingController _chaController;

  @override
  void initState() {
    super.initState();

    _charaNameController =
        TextEditingController(text: widget.character?.charaName ?? '');
    _charaClassController =
        TextEditingController(text: widget.character?.charaClass ?? '');
    _levelController =
        TextEditingController(text: widget.character?.level.toString() ?? '');
    _strController =
        TextEditingController(text: widget.character?.str.toString() ?? '');
    _dexController =
        TextEditingController(text: widget.character?.dex.toString() ?? '');
    _consController =
        TextEditingController(text: widget.character?.cons.toString() ?? '');
    _inteController =
        TextEditingController(text: widget.character?.inte.toString() ?? '');
    _wisController =
        TextEditingController(text: widget.character?.wis.toString() ?? '');
    _chaController =
        TextEditingController(text: widget.character?.cha.toString() ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.character == null ? 'Crear Personaje' : 'Editar Personaje'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Nombre', _charaNameController),
            _buildTextField('Clase', _charaClassController),
            _buildTextField('Nivel', _levelController),
            _buildTextField('Fuerza', _strController),
            _buildTextField('Destreza', _dexController),
            _buildTextField('Constitución', _consController),
            _buildTextField('Inteligencia', _inteController),
            _buildTextField('Sabiduría', _wisController),
            _buildTextField('Carisma', _chaController),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _saveCharacter,
              child: Text(widget.character == null ? 'Crear' : 'Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
    );
  }

  void _saveCharacter() {
    String? userEmail = widget.authProvider.getUserEmail();

    final Character updatedCharacter = Character(
      userEmail: userEmail,
      charaName: _charaNameController.text,
      charaClass: _charaClassController.text,
      level: int.tryParse(_levelController.text) ?? 1,
      str: int.tryParse(_strController.text) ?? 10,
      dex: int.tryParse(_dexController.text) ?? 10,
      cons: int.tryParse(_consController.text) ?? 10,
      inte: int.tryParse(_inteController.text) ?? 10,
      wis: int.tryParse(_wisController.text) ?? 10,
      cha: int.tryParse(_chaController.text) ?? 10,
    );

    if (widget.character != null) {
      widget.character!.copyFrom(updatedCharacter);
    }

    Navigator.of(context).pop(updatedCharacter);
  }
}
