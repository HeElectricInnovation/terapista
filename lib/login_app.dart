import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp4());
}

class MyApp4 extends StatelessWidget {
  const MyApp4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ),
      ),
      home: const MyHomePage4(
        title: 'Bright Mind Demo',
      ),
    );
  }
}

class MyHomePage4 extends StatelessWidget {
  final String title;

  const MyHomePage4({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 300.0,
              width: 180,
              child: Image.asset('assets/logo_h_e.png'),
            ),
            const SizedBox(height: 20.0),
            const LoginForm(),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreatePage()),
                  );
                },
                child: const Text('Crear cuenta'),
              ),
              TextButton(
                onPressed: () {
                  // Maneja la acción cuando se presiona el botón "Olvidé mi contraseña".
                },
                child: const Text('Olvidé mi contraseña'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CreatePage extends StatelessWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Selecciona tipo de cuenta',
              style: TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CrearAdministradorPage()),
                );
              },
              child: const Text('Administrador'),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Por hacer: Manejar la acción cuando se presiona el botón "Usuario".
              },
              child: const Text('Usuario'),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Por hacer: Manejar la acción cuando se presiona el botón "Terapeuta".
              },
              child: const Text('Terapeuta'),
            ),
          ],
        ),
      ),
    );
  }
}

class CrearAdministradorPage extends StatefulWidget {
  const CrearAdministradorPage({Key? key}) : super(key: key);

  @override
  CrearAdministradorPageState createState() => CrearAdministradorPageState();
}

class CrearAdministradorPageState extends State<CrearAdministradorPage> {
  final _formKey = GlobalKey<FormState>();
  final _fotoController = TextEditingController();
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final Logger _logger = Logger();
  String? _nombre;
  String? _idUsuario;
  String? _verificacionUsuario;

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final nombre = _nombreController.text;
      final idUsuario = generateId();
      final verificacionUsuario = generateVerification();

      setState(() {
        _nombre = nombre;
        _idUsuario = idUsuario;
        _verificacionUsuario = verificacionUsuario;
      });

      _logger.i('Nombre: $nombre');
      _logger.i('ID de Usuario: $idUsuario');
      _logger.i('Verificación de Usuario: $verificacionUsuario');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Administrador creado')),
      );
    }
  }

  String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  String generateVerification() {
    return DateTime.now()
        .millisecondsSinceEpoch
        .toRadixString(16)
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Administrador'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _fotoController,
                decoration:
                    const InputDecoration(labelText: 'Fotos (opcional)'),
              ),
              TextFormField(
                controller: _nombreController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese un nombre';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese un email';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _usernameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese un nombre de usuario';
                  }
                  return null;
                },
                decoration:
                    const InputDecoration(labelText: 'Nombre de usuario'),
              ),
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese una contraseña';
                  }
                  return null;
                },
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Contraseña'),
              ),
              TextFormField(
                controller: _rePasswordController,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: 'Reescribir contraseña'),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => _submitForm(context),
                child: const Text('Crear'),
              ),
              if (_nombre != null &&
                  _idUsuario != null &&
                  _verificacionUsuario != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${_nombre!}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('ID: ${_idUsuario!}'),
                      Text('Verificación: ${_verificacionUsuario!}'),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class Logger {
  void i(String s) {}
}
