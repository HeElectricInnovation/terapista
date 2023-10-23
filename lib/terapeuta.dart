import 'package:flutter/material.dart';
//import 'terapeuta.dart';

void main() {
  runApp(const MyApp1());
}

class MyApp1 extends StatelessWidget {
  const MyApp1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Terapeuta App',
      home: TerapeutaOptionsPage(),
    );
  }
}

class TerapeutaOptionsPage extends StatelessWidget {
  const TerapeutaOptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opciones de Terapeuta'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HistorialPage(),
                  ),
                );
              },
              child: const Text('Historial de Aciertos y Desaciertos'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatProfesionalPage(),
                  ),
                );
              },
              child: const Text('Chat Profesional'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CaseNotesPage(),
                  ),
                );
              },
              child: const Text('Notas del Caso'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateAccountPage(),
                  ),
                );
              },
              child: const Text('Crear Cuentas'),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Cuentas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300.0,
              width: 180,
              child: Image.asset('assets/logo_h_e.png'),
            ),
            const CreateAccountButtons(),
          ],
        ),
      ),
    );
  }
}

class CreateAccountButtons extends StatelessWidget {
  const CreateAccountButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateUserForm(userType: 'Usuario'),
              ),
            );
          },
          child: const Text('Usuario'),
        ),
        const SizedBox(height: 10.0),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const CreateUserForm(userType: 'Administrador'),
              ),
            );
          },
          child: const Text('Administrador'),
        ),
      ],
    );
  }
}

class CreateUserForm extends StatefulWidget {
  final String userType;

  const CreateUserForm({Key? key, required this.userType}) : super(key: key);

  @override
  CreateUserFormState createState() => CreateUserFormState();
}

class CreateUserFormState extends State<CreateUserForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  String? _nombre;
  String? _idUsuario;
  String? _verificacionUsuario;

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final nombre = _usernameController.text;
      final idUsuario = generateId();
      final verificacionUsuario = generateVerification();

      setState(() {
        _nombre = nombre;
        _idUsuario = idUsuario;
        _verificacionUsuario = verificacionUsuario;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario/Administrador creado')),
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
        title: Text('Crear ${widget.userType}'),
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
                controller: _usernameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese un nombre de ${widget.userType}';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Nombre de ${widget.userType}',
                ),
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
                child: Text('Crear ${widget.userType}'),
              ),
              if (_nombre != null &&
                  _idUsuario != null &&
                  _verificacionUsuario != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nombre: ${_nombre!}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('ID de ${widget.userType}: ${_idUsuario!}'),
                      Text(
                          'Verificación de ${widget.userType}: ${_verificacionUsuario!}'),
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

class CaseNotesPage extends StatefulWidget {
  const CaseNotesPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CaseNotesPageState createState() => _CaseNotesPageState();
}

class _CaseNotesPageState extends State<CaseNotesPage> {
  List<String> notes = []; // Lista para almacenar las notas

  TextEditingController noteController = TextEditingController();

  void addNote() {
    if (noteController.text.isNotEmpty) {
      DateTime now = DateTime.now();
      String formattedDate =
          "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}";
      String note = "${noteController.text}\n$formattedDate";
      setState(() {
        notes.add(note);
        noteController.clear(); // Limpiar el campo de texto
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notas del Caso'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ListVie,w para mostrar las notas guardadas
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(notes[index]),
                  );
                },
              ),
            ),
            // Barra para agregar nuevas notas
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: addNote,
                ),
                Expanded(
                  child: TextField(
                    controller: noteController,
                    decoration:
                        const InputDecoration(hintText: 'Escribir nota...'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: addNote,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChatProfesionalPage extends StatelessWidget {
  const ChatProfesionalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Profesional'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Chat Profesional',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView(
                children: const [
                  // Aquí puedes agregar mensajes de chat
                  // Ejemplo de mensaje:
                  // ChatMessage(
                  //   text: 'Hola, ¿en qué puedo ayudarte?',
                  //   isUserMessage: false, // Cambiar a true si el mensaje es del usuario
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      // Aquí se ingresa el texto del mensaje
                      decoration: const InputDecoration(
                        hintText: 'Escribe un mensaje...',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      // Aquí se envía el mensaje
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HistorialPage extends StatelessWidget {
  const HistorialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Aciertos y Desaciertos'),
      ),
      body: const Center(
        child: Text('Contenido de Historial de Aciertos y Desaciertos'),
      ),
    );
  }
}
