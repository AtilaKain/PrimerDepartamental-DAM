import 'package:flutter/material.dart';  // Importa el paquete Flutter necesario para usar widgets y crear la UI.
import 'dart:async';  // Importa dart:async para trabajar con el temporizador.

class Practica3 extends StatefulWidget {  // Define un StatefulWidget, que permite que la UI se actualice con el estado.
  @override
  _Practica3State createState() => _Practica3State();  // Crea el estado de esta pantalla (Práctica3).
}

class _Practica3State extends State<Practica3> {
  int _counter = 0;  // Variable que almacena el valor del contador (inicialmente en 0).
  bool _isRunning = false;  // Variable que indica si el temporizador está corriendo o no.
  int _timeLeft = 10;  // Variable que guarda el tiempo restante para el temporizador (inicialmente 10 segundos).
  Timer? _timer;  // Instancia de Timer para ejecutar acciones periódicas.

  // Método para iniciar el temporizador.
  void _startTimer() {
    if (_isRunning) return;  // Si el temporizador ya está corriendo, no hace nada.

    setState(() {  // Cambia el estado de la UI.
      _isRunning = true;  // Marca el temporizador como en ejecución.
      _timeLeft = 10;  // Reinicia el tiempo restante a 10 segundos.
      _counter = 0;  // Reinicia el contador.
    });

    // Crea un temporizador que se ejecuta cada segundo.
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {  // Actualiza el estado cada segundo.
        if (_timeLeft > 0) {  // Si hay tiempo restante, decrementa el tiempo.
          _timeLeft--;
        } else {  // Si el temporizador llega a 0, detiene el temporizador.
          _isRunning = false;  // Marca el temporizador como detenido.
          timer.cancel();  // Detiene el temporizador.
          _showDialog();  // Muestra un cuadro de diálogo con el resultado.
        }
      });
    });
  }

  // Método que se llama para incrementar el contador si el temporizador está corriendo.
  void _incrementCounter() {
    if (_isRunning) {  // Solo incrementa el contador si el temporizador está en marcha.
      setState(() {
        _counter++;  // Incrementa el contador.
      });
    }
  }

  // Método para mostrar el cuadro de diálogo cuando el temporizador llega a 0.
  void _showDialog() {
    showDialog(
      context: context,  // Contexto de la pantalla actual.
      builder: (BuildContext dialogContext) {  // Constructor del cuadro de diálogo.
        return AlertDialog(
          title: Text(
            'Temporizador Finalizado',  // Título del cuadro de diálogo.
            style: TextStyle(
              color: Colors.deepPurple,  // Texto morado.
              fontWeight: FontWeight.bold,  // El texto es en negrita.
            ),
          ),
          content: Text(
            'Contador final: $_counter',  // Muestra el contador final después de que el temporizador terminó.
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,  // Color negro del texto.
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();  // Cierra el cuadro de diálogo.
              },
              child: Text(
                'OK',  // Texto del botón para cerrar el cuadro de diálogo.
                style: TextStyle(
                  color: Colors.deepPurple,  // Texto morado.
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Método para cancelar el temporizador cuando se cierra la pantalla.
  @override
  void dispose() {
    _timer?.cancel();  // Cancela el temporizador si está en ejecución.
    super.dispose();  // Llama al método dispose de la clase base.
  }

  // Método que construye la interfaz de usuario de esta pantalla.
  @override
  Widget build(BuildContext context) {
    return Scaffold(  // Scaffold es el contenedor principal de la pantalla.
      appBar: AppBar(  // La barra de navegación superior (AppBar).
        title: Text(
          'Práctica 3: Contador con Temporizador',  // Título de la pantalla.
          style: TextStyle(
            color: Colors.white,  // Color blanco para el texto del título.
            fontSize: 20,
            fontWeight: FontWeight.bold,  // El texto está en negrita.
          ),
        ),
        backgroundColor: Colors.deepPurple,  // Color de fondo de la AppBar (morado).
        elevation: 4,  // La sombra bajo la AppBar.
      ),
      body: Center(  // Centra los elementos en el cuerpo de la pantalla.
        child: Column(  // Utiliza una columna para organizar los widgets verticalmente.
          mainAxisAlignment: MainAxisAlignment.center,  // Alinea los widgets en el centro de la pantalla.
          children: <Widget>[
            Text(
              'Tiempo restante: $_timeLeft segundos',  // Muestra el tiempo restante en segundos.
              style: TextStyle(
                fontSize: 20,
                color: Colors.deepPurple,  // Texto morado.
              ),
            ),
            SizedBox(height: 20),  // Espacio de 20 píxeles entre los widgets.
            Text(
              'Contador:',  // Etiqueta para el contador.
              style: TextStyle(
                fontSize: 20,
                color: Colors.deepPurple,  // Texto morado.
              ),
            ),
            Text(
              '$_counter',  // Muestra el valor actual del contador.
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,  // El texto del contador está en negrita.
                color: Colors.deepPurple,  // Texto morado.
              ),
            ),
            SizedBox(height: 20),  // Espacio adicional entre el contador y los botones.
            ElevatedButton(  // Botón para iniciar el temporizador.
              onPressed: _startTimer,  // Al presionar, inicia el temporizador.
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.deepPurple,  // Texto blanco, fondo morado.
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),  // Padding para el botón.
                shape: RoundedRectangleBorder(  // Define los bordes redondeados del botón.
                  borderRadius: BorderRadius.circular(10),  // Bordes redondeados con radio de 10 píxeles.
                ),
              ),
              child: Text('Iniciar Temporizador'),  // Texto dentro del botón.
            ),
            SizedBox(height: 10),  // Espacio entre los botones.
            ElevatedButton(  // Botón para incrementar el contador.
              onPressed: _incrementCounter,  // Al presionar, incrementa el contador.
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.deepPurple,  // Texto blanco, fondo morado.
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),  // Padding para el botón.
                shape: RoundedRectangleBorder(  // Define los bordes redondeados del botón.
                  borderRadius: BorderRadius.circular(10),  // Bordes redondeados con radio de 10 píxeles.
                ),
              ),
              child: Text('Haz Clic'),  // Texto dentro del botón.
            ),
            SizedBox(height: 20),  // Espacio adicional entre los botones.
            ElevatedButton(  // Botón para volver al menú principal.
              onPressed: () {
                Navigator.pop(context);  // Regresa a la pantalla anterior (menú principal).
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.deepPurple,  // Texto blanco, fondo morado.
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),  // Padding para el botón.
                shape: RoundedRectangleBorder(  // Define los bordes redondeados del botón.
                  borderRadius: BorderRadius.circular(10),  // Bordes redondeados con radio de 10 píxeles.
                ),
              ),
              child: Text('Volver al Menú'),  // Texto dentro del botón.
            ),
          ],
        ),
      ),
    );
  }
}
