import 'package:flutter/material.dart';  // Importa el paquete Flutter necesario para usar los widgets y crear la UI.

class Practica2 extends StatefulWidget {  // Define una clase StatefulWidget, que permite actualizar su estado.
  @override
  _Practica2State createState() => _Practica2State();  // Crea el estado del widget para esta pantalla.
}

class _Practica2State extends State<Practica2> {
  int _counter = 0; // Variable que almacena el valor actual del contador (inicialmente en 0).

  // Método que se ejecuta al hacer clic en el botón para incrementar el contador.
  void _incrementCounter() {
    setState(() {  // Llama a setState para que la UI se actualice cuando cambie el estado.
      _counter++; // Incrementa el contador en 1.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  // Scaffold proporciona una estructura básica para la pantalla, incluyendo AppBar y cuerpo.
      appBar: AppBar(  // AppBar es la barra superior de la pantalla, donde se coloca el título.
        title: Text(  // El título que se muestra en la AppBar.
          'Práctica 2: Contador de Clicks',  // Título de la pantalla.
          style: TextStyle(  // Estilo del texto en el título del AppBar.
            color: Colors.white,  // El color del texto del título es blanco.
            fontSize: 20,  // El tamaño del texto es 20.
            fontWeight: FontWeight.bold,  // El texto está en negrita.
          ),
        ),
        backgroundColor: Colors.deepPurple,  // Color de fondo del AppBar (morado).
        elevation: 4,  // La sombra bajo el AppBar para darle un poco de elevación.
      ),
      body: Center(  // El cuerpo de la pantalla, con los elementos centrados.
        child: Column(  // Utiliza un widget Column para apilar los elementos de forma vertical.
          mainAxisAlignment: MainAxisAlignment.center,  // Alinea los elementos verticalmente al centro.
          children: <Widget>[  // Los widgets dentro de la columna.
            Text(  // Primer texto que se muestra en la pantalla.
              'Has hecho clic:',  // Texto que describe la acción.
              style: TextStyle(  // Estilo del texto.
                fontSize: 20,  // Tamaño de la fuente es 20.
                color: Colors.deepPurple,  // El texto será de color morado.
              ),
            ),
            SizedBox(height: 10),  // Espacio vacío de 10 píxeles entre los widgets.
            Text(  // Muestra el valor del contador.
              '$_counter',  // Muestra el valor de la variable _counter (se actualiza con cada clic).
              style: TextStyle(  // Estilo del texto del contador.
                fontSize: 40,  // El tamaño de la fuente es grande (40).
                fontWeight: FontWeight.bold,  // El texto está en negrita.
                color: Colors.deepPurple,  // El color del texto es morado.
              ),
            ),
            SizedBox(height: 20),  // Espacio vacío de 20 píxeles entre el contador y el siguiente botón.
            ElevatedButton(  // Botón elevado para incrementar el contador.
              onPressed: _incrementCounter,  // Al presionar, se ejecuta el método _incrementCounter().
              style: ElevatedButton.styleFrom(  // Establece el estilo del botón.
                foregroundColor: Colors.white,  // Color del texto del botón (blanco).
                backgroundColor: Colors.deepPurple,  // Color de fondo del botón (morado).
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),  // Padding del botón.
                shape: RoundedRectangleBorder(  // Define la forma del botón con bordes redondeados.
                  borderRadius: BorderRadius.circular(10),  // Bordes del botón redondeados con un radio de 10 píxeles.
                ),
              ),
              child: Text('Haz Clic'),  // Texto dentro del botón.
            ),
            SizedBox(height: 20),  // Espacio vacío adicional entre botones.
            ElevatedButton(  // Segundo botón para regresar al menú principal.
              onPressed: () {
                Navigator.pop(context);  // Vuelve a la pantalla anterior (en este caso, el menú principal).
              },
              style: ElevatedButton.styleFrom(  // Establece el estilo del botón.
                foregroundColor: Colors.white,  // Color del texto del botón (blanco).
                backgroundColor: Colors.deepPurple,  // Color de fondo del botón (morado).
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),  // Padding del botón.
                shape: RoundedRectangleBorder(  // Bordes redondeados para el botón.
                  borderRadius: BorderRadius.circular(10),  // Bordes redondeados con un radio de 10 píxeles.
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
