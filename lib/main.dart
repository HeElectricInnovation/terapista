import 'package:flutter/material.dart';
import 'package:terapista/login_app.dart';
import 'package:terapista/papa_tutor.dart';
import 'terapeuta.dart';
import 'usuario.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main Page',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Página Principal'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  runApp(const MyApp4()); // Iniciar la aplicación del usuario
                },
                child: const Text('Login'),
              ),
              ElevatedButton(
                onPressed: () {
                  runApp(const MyApp1()); // Iniciar la aplicación del terapeuta
                },
                child: const Text('Terapeuta'),
              ),
              ElevatedButton(
                onPressed: () {
                  runApp(const MyApp3()); // Iniciar la aplicación del usuario
                },
                child: const Text('Usuario'),
              ),
              ElevatedButton(
                onPressed: () {
                  runApp(const MyApp5()); // Iniciar la aplicación del usuario
                },
                child: const Text('Administrador'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp2 {
  const MyApp2();
}
