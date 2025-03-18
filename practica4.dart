import 'dart:io';  // Importa las funcionalidades de manejo de archivos
import 'package:flutter/material.dart';  // Importa Flutter para la creación de interfaces
import 'package:path_provider/path_provider.dart';  // Permite obtener la ubicación del almacenamiento local
import 'dart:async';  // Para trabajar con timers y temporizadores

class Practica4 extends StatefulWidget {
  @override
  _Practica4State createState() => _Practica4State();  // Crea el estado del widget de la práctica 4
}

class _Practica4State extends State<Practica4> {
  int _counter = 0;  // Variable que almacena el contador, empieza en 0
  bool _isRunning = false;  // Variable que indica si el temporizador está activo o no
  int _timeLeft = 10;  // Tiempo restante del temporizador, inicia en 10 segundos
  Timer? _timer;  // El objeto Timer para gestionar el temporizador
  List<String> _history = [];  // Lista que guarda el historial de puntajes
  List<int> _scores = [];  // Lista que guarda los mejores puntajes

  // Método para iniciar el temporizador
  void _startTimer() {
    if (_isRunning) return;  // Si el temporizador ya está en ejecución, no hacer nada

    setState(() {
      _isRunning = true;  // Establece que el temporizador está activo
      _timeLeft = 10;  // Reinicia el tiempo a 10 segundos
      _counter = 0;  // Reinicia el contador a 0
    });

    // Crea un temporizador que se ejecuta cada segundo
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;  // Decrementa el tiempo restante por 1 cada segundo
        } else {
          _isRunning = false;  // Detiene el temporizador
          timer.cancel();  // Cancela el temporizador
          _saveHistory();  // Guarda el puntaje en el historial
          _showDialog();  // Muestra el cuadro de diálogo con el puntaje final
        }
      });
    });
  }

  // Método que incrementa el contador solo si el temporizador está activo
  void _incrementCounter() {
    if (_isRunning) {
      setState(() {
        _counter++;  // Incrementa el contador en 1
      });
    }
  }

  // Método para guardar el historial en un archivo de texto
  void _saveHistory() async {
    final directory = await getApplicationDocumentsDirectory();  // Obtiene la ruta del directorio de documentos de la app
    final file = File('${directory.path}/history.txt');  // Crea un archivo de texto llamado 'history.txt'
    _history.add('Contador: $_counter');  // Añade el puntaje final al historial
    await file.writeAsString(_history.join('\n'));  // Guarda todo el historial en el archivo
    _loadScores();  // Carga los puntajes más altos desde el archivo
  }

  // Método para cargar los mejores puntajes desde el archivo
  void _loadScores() async {
    final directory = await getApplicationDocumentsDirectory();  // Obtiene el directorio de documentos
    final file = File('${directory.path}/history.txt');  // Accede al archivo 'history.txt'
    if (await file.exists()) {  // Verifica si el archivo existe
      final content = await file.readAsString();  // Lee el contenido del archivo
      final lines = content.split('\n');  // Separa el contenido por líneas
      final scores = lines
          .where((line) => line.startsWith('Contador: '))  // Filtra las líneas que contienen un puntaje
          .map((line) => int.parse(line.replaceAll('Contador: ', '')))  // Convierte las líneas a números
          .toList();
      scores.sort((a, b) => b.compareTo(a));  // Ordena los puntajes de mayor a menor
      setState(() {
        _scores = scores.take(5).toList();  // Toma los 5 mejores puntajes
      });
    }
  }

  // Método para mostrar un cuadro de diálogo con el puntaje final
  void _showDialog() {
    showDialog(
      context: context,  // Contexto de la aplicación
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            'Temporizador Finalizado',  // Título del cuadro de diálogo
            style: TextStyle(
              color: Colors.deepPurple,  // Establece el color del texto como morado
              fontWeight: FontWeight.bold,  // Texto en negrita
            ),
          ),
          content: Text(
            'Contador final: $_counter',  // Muestra el puntaje final en el contenido
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,  // Color del texto
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();  // Cierra el cuadro de diálogo cuando se presiona OK
              },
              child: Text(
                'OK',  // Texto del botón
                style: TextStyle(
                  color: Colors.deepPurple,  // Establece el color del texto como morado
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadScores();  // Carga los puntajes al iniciar el estado del widget
  }

  @override
  void dispose() {
    _timer?.cancel();  // Cancela el temporizador si está en ejecución
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Práctica 4: Historial en Archivo de Texto',  // Título de la aplicación
          style: TextStyle(
            color: Colors.white,  // Color del texto en blanco
            fontSize: 20,
            fontWeight: FontWeight.bold,  // Establece el texto en negrita
          ),
        ),
        backgroundColor: Colors.deepPurple,  // Color morado para el AppBar
        elevation: 4,  // Sombra en el AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Centra los elementos en el cuerpo
          children: <Widget>[
            Text(
              'Tiempo restante: $_timeLeft segundos',  // Muestra el tiempo restante
              style: TextStyle(
                fontSize: 20,
                color: Colors.deepPurple,  // Texto en color morado
              ),
            ),
            SizedBox(height: 20),  // Espacio entre el texto y el contador
            Text(
              'Contador:',  // Etiqueta del contador
              style: TextStyle(
                fontSize: 20,
                color: Colors.deepPurple,  // Texto en color morado
              ),
            ),
            Text(
              '$_counter',  // Muestra el valor del contador
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,  // Texto en negrita
                color: Colors.deepPurple,  // Texto en color morado
              ),
            ),
            SizedBox(height: 20),  // Espacio entre el contador y los botones
            ElevatedButton(
              onPressed: _startTimer,  // Inicia el temporizador al presionar el botón
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,  // Color del texto en blanco
                backgroundColor: Colors.deepPurple,  // Color de fondo morado
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),  // Bordes redondeados
                ),
              ),
              child: Text('Iniciar Temporizador'),  // Texto del botón
            ),
            SizedBox(height: 10),  // Espacio entre los botones
            ElevatedButton(
              onPressed: _incrementCounter,  // Incrementa el contador al presionar el botón
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,  // Color del texto en blanco
                backgroundColor: Colors.deepPurple,  // Color de fondo morado
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),  // Bordes redondeados
                ),
              ),
              child: Text('Haz Clic'),  // Texto del botón
            ),
            SizedBox(height: 20),  // Espacio adicional
            Text(
              'Mejores 5 Scores:',  // Título para los mejores puntajes
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,  // Texto en negrita
                color: Colors.deepPurple,  // Texto en color morado
              ),
            ),
            Expanded(
              child: ListView.builder(  // Construye una lista de puntajes
                itemCount: _scores.length,  // Número de elementos en la lista
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      '${index + 1}. ${_scores[index]}',  // Muestra el rank y el puntaje
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurple,  // Texto en color morado
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),  // Espacio adicional
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);  // Vuelve al menú principal
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,  // Color del texto en blanco
                backgroundColor: Colors.deepPurple,  // Color de fondo morado
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),  // Bordes redondeados
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
