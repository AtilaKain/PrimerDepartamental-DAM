import 'package:flutter/material.dart';  // Importa Flutter para la creación de interfaces
import 'package:sqflite/sqflite.dart';  // Importa Sqflite para manejar bases de datos SQLite
import 'package:path/path.dart' as path;  // Importa el paquete 'path' para manejar rutas de archivos
import 'dart:async';  // Importa dart:async para trabajar con temporizadores

class Practica6 extends StatefulWidget {
  @override
  _Practica6State createState() => _Practica6State();  // Crea el estado para el widget Practica6
}

class _Practica6State extends State<Practica6> {
  int _counter = 0;  // Contador para contar los clics del usuario
  bool _isRunning = false;  // Indicador de si el temporizador está corriendo
  int _timeLeft = 10;  // Tiempo restante en segundos
  Timer? _timer;  // Instancia de un temporizador
  Database? _database;  // Instancia de la base de datos
  List<Map<String, dynamic>> _history = [];  // Lista para almacenar el historial de contadores
  List<int> _scores = [];  // Lista de los 5 mejores scores

  @override
  void initState() {
    super.initState();
    _initDatabase();  // Llama a la función para inicializar la base de datos cuando se crea el estado
  }

  // Inicializa la base de datos SQLite
  Future<void> _initDatabase() async {
    final databasePath = await getDatabasesPath();  // Obtiene la ruta donde se almacenarán las bases de datos
    final dbPath = path.join(databasePath, 'counter_history.db');  // Define la ruta completa para la base de datos

    // Abre o crea la base de datos si no existe
    _database = await openDatabase(
      dbPath,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE history(id INTEGER PRIMARY KEY, count INTEGER)',  // Crea la tabla 'history' con un id y un contador
        );
      },
      version: 1,  // Versión de la base de datos, se incrementa si se modifican las tablas
    );

    _loadHistory();  // Carga el historial de la base de datos
  }

  // Carga el historial desde la base de datos
  Future<void> _loadHistory() async {
    final List<Map<String, dynamic>> history = await _database!.query('history');  // Consulta los registros de la tabla 'history'
    setState(() {
      _history = history;  // Actualiza la lista de historial con los registros obtenidos
      _scores = history.map((item) => item['count'] as int).toList();  // Extrae los contadores de cada registro
      _scores.sort((a, b) => b.compareTo(a));  // Ordena la lista de scores de mayor a menor
      _scores = _scores.take(5).toList();  // Toma los primeros 5 scores
    });
  }

  // Guarda un nuevo contador en la base de datos
  Future<void> _saveCount(int count) async {
    await _database!.insert('history', {'count': count});  // Inserta un nuevo contador en la tabla 'history'
    _loadHistory();  // Recarga el historial después de insertar el nuevo contador
  }

  // Inicia el temporizador
  void _startTimer() {
    if (_isRunning) return;  // Si el temporizador ya está corriendo, no hace nada

    setState(() {
      _isRunning = true;  // Establece que el temporizador está en ejecución
      _timeLeft = 10;  // Restablece el tiempo a 10 segundos
      _counter = 0;  // Restablece el contador
    });

    // Crea un temporizador que se ejecuta cada segundo
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;  // Decrementa el tiempo restante
        } else {
          _isRunning = false;  // Detiene el temporizador cuando el tiempo se acaba
          timer.cancel();  // Cancela el temporizador
          _saveCount(_counter);  // Guarda el contador en la base de datos
          _showDialog();  // Muestra un diálogo con el resultado
        }
      });
    });
  }

  // Incrementa el contador cuando el usuario hace clic
  void _incrementCounter() {
    if (_isRunning) {  // Solo incrementa el contador si el temporizador está corriendo
      setState(() {
        _counter++;  // Incrementa el contador
      });
    }
  }

  // Muestra un diálogo cuando el temporizador se detiene
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Temporizador Finalizado'),  // Título del diálogo
          content: Text('Contador final: $_counter'),  // Muestra el contador final
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();  // Cierra el diálogo al presionar 'OK'
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();  // Cancela el temporizador si está corriendo al salir de la vista
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Práctica 6: Historial en SQLite'),  // Título de la aplicación
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Centra los elementos en la pantalla
          children: <Widget>[
            Text('Tiempo restante: $_timeLeft segundos'),  // Muestra el tiempo restante
            SizedBox(height: 20),
            Text('Contador:'),
            Text(
              '$_counter',  // Muestra el contador actual
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startTimer,  // Llama a _startTimer cuando se presiona el botón
              child: Text('Iniciar Temporizador'),
            ),
            ElevatedButton(
              onPressed: _incrementCounter,  // Llama a _incrementCounter cuando se presiona el botón
              child: Text('Haz Clic'),
            ),
            SizedBox(height: 20),
            Text(
              'Mejores 5 Scores:',  // Título para la lista de los mejores scores
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _scores.length,  // Muestra la cantidad de scores en la lista
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${index + 1}. ${_scores[index]}'),  // Muestra la posición y el score
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);  // Regresa al menú principal
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.deepPurple,  // Texto blanco y fondo morado
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),  // Bordes redondeados para el botón
                ),
              ),
              child: Text('Volver al Menú'),  // Texto del botón
            ),
          ],
        ),
      ),
    );
  }
}
