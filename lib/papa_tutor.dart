import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp5());
}

class MyApp5 extends StatelessWidget {
  const MyApp5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Admin Panel'),
        '/metasRecompensas': (context) => const MetasRecompensasPage(),
        '/chatProfesional': (context) => const ChatProfesionalPage(),
        '/historial': (context) => const HistorialPage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(children: [
            SizedBox(
              height: 300.0,
              width: 180,
              child: Image.asset('assets/logo_h_e.png'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/metasRecompensas');
              },
              child: const Text('Establecer Metas y Recompensas'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/chatProfesional');
              },
              child: const Text('Chat Profesional'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/historial');
              },
              child: const Text('Historial de Aciertos y Desaciertos'),
            ),
          ]),
        ));
  }
}

class MetasRecompensasPage extends StatefulWidget {
  const MetasRecompensasPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MetasRecompensasPageState createState() => _MetasRecompensasPageState();
}

class _MetasRecompensasPageState extends State<MetasRecompensasPage> {
  String selectedReward =
      ''; // Variable para almacenar la recompensa seleccionada
  String selectedPhoto = ''; // Variable para almacenar la foto seleccionada
  List<Task> tasks = []; // Lista de tareas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Establecer Metas y Recompensas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Definir Recompensa:'),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Ingrese la Recompensa',
              ),
            ),
            const SizedBox(height: 20.0),
            const Text('Seleccionar Foto de Recompensa:'),
            DropdownButton<String>(
              value: selectedPhoto.isNotEmpty ? selectedPhoto : null,
              onChanged: (value) {
                setState(() {
                  selectedPhoto = value!;
                });
              },
              items: const [
                DropdownMenuItem(
                  value: '', // Agregar un valor predeterminado
                  child: Text('Seleccione una foto'),
                ),
                DropdownMenuItem(
                  value: 'foto1',
                  child: Text('Imagen 1'),
                ),
                DropdownMenuItem(
                  value: 'foto2',
                  child: Text('Imagen 2'),
                ),
                DropdownMenuItem(
                  value: 'foto3',
                  child: Text('Imagen 3'),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Text('Tareas:'),
            ElevatedButton(
              onPressed: () {
                _showTaskDialog(); // Abre un diálogo para agregar tareas
              },
              child: const Text('Agregar Tarea'),
            ),
            const SizedBox(height: 20.0),
            const Text('Lista de Tareas:'),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Tarea ${index + 1}: ${tasks[index].name}'),
                    subtitle: Text(
                        'Fecha: ${tasks[index].date}, Hora: ${tasks[index].time}, Duración: ${tasks[index].duration} horas'),
                    leading: Image.asset(
                        'assets/${tasks[index].image}'), // Cambia 'assets/' por la ruta real de tus imágenes
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Función para mostrar el diálogo de agregar tarea
  _showTaskDialog() {
    String taskName = '';
    String taskDate = '';
    String taskTime = '';
    String taskDuration = '';
    String taskImage = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar Tarea'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Nombre de la Tarea',
                ),
                onChanged: (value) {
                  taskName = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Fecha',
                ),
                onChanged: (value) {
                  taskDate = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Hora',
                ),
                onChanged: (value) {
                  taskTime = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Duración (horas)',
                ),
                onChanged: (value) {
                  taskDuration = value;
                },
              ),
              DropdownButton<String>(
                value: taskImage.isNotEmpty ? taskImage : null,
                onChanged: (value) {
                  taskImage = value!;
                },
                items: const [
                  DropdownMenuItem(
                    value: '', // Agregar un valor predeterminado
                    child: Text('Seleccione una imagen'),
                  ),
                  DropdownMenuItem(
                    value: 'imagen1.jpg',
                    child: Text('Imagen 1'),
                  ),
                  DropdownMenuItem(
                    value: 'imagen2.jpg',
                    child: Text('Imagen 2'),
                  ),
                  DropdownMenuItem(
                    value: 'imagen3.jpg',
                    child: Text('Imagen 3'),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Agregar la tarea a la lista
                setState(() {
                  tasks.add(Task(
                    name: taskName,
                    date: taskDate,
                    time: taskTime,
                    duration: taskDuration,
                    image: taskImage,
                  ));
                });
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}

class Task {
  final String name;
  final String date;
  final String time;
  final String duration;
  final String image;

  Task({
    required this.name,
    required this.date,
    required this.time,
    required this.duration,
    required this.image,
  });
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
