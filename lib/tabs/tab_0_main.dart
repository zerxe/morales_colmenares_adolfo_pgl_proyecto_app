import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import '../login.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Bienvenido a la sección principal.\n'
            'En "Fichas" puedes realizar operaciones de crear, editar y eliminar relacionadas con fichas de personajes.\n'
            'En "Datos Ficha" puedes ver detalles específicos de una ficha de personaje.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async {
              final authProvider =
                  Provider.of<AuthProvider>(context, listen: false);
              await authProvider.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: const Text('Cerrar Sesión'),
          ),
        ],
      ),
    );
  }
}
