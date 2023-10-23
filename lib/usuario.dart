import 'package:flutter/material.dart';
//import 'usuario.dart';

void main() {
  runApp(const MyApp3());
}

class MyApp3 extends StatelessWidget {
  const MyApp3({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nombre del Usuario"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                for (int day = 1; day <= 4; day++)
                  Column(
                    children: [
                      Text(
                        "Día $day",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int task = 1; task <= 4; task++)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TaskPage(
                                        title: "Tarea $task del Día $day",
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(180.0, 100.0),
                                  backgroundColor: getColorForDay(day),
                                ),
                                child: Text("Tarea $task"),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(width: 20.0), // Espacio entre las dos columnas
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Alineación a la izquierda
              children: [
                const SizedBox(
                    height: 56.0), // Espacio desde la barra de la aplicación
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TaskPage(
                          title: "Recompensa",
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        const Size(160.0, 160.0), // Botón más grande y cuadrado
                  ),
                  child: const Text("Recompensa"),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(160.0, 60.0),
                  ),
                  child: const Text("Chat"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color getColorForDay(int day) {
    switch (day) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.grey;
      case 4:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

class TaskPage extends StatelessWidget {
  final String title;

  const TaskPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          width: 500.0,
          height: 500.0,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: const Center(
        child: Text("Página de Chat"),
      ),
    );
  }
}
