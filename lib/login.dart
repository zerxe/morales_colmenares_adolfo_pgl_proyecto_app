import 'package:flutter/material.dart';
import 'flut_tab.dart';
import 'register_page.dart';
import 'main.dart';
import 'provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _handleLogin() async {
    String username = usernameController.text;
    String password = passwordController.text;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      await authProvider.signInWithEmailAndPassword(username, password);
      navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: (context) => const FlutTab()),
      );
    } catch (e) {
      print('Error al iniciar sesión: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error de inicio de sesión'),
          content: const Text('Datos de usuario introducidos incorrectos.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
    }
  }

  void _handleRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creador de Personajes de Juegos de Mesa de Rol '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _handleLogin,
              child: const Text('Iniciar Sesión'),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: _handleRegister,
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
