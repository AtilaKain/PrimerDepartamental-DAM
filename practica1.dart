import 'package:flutter/material.dart';  // Importa el paquete Flutter para usar widgets y construir la interfaz de usuario.

class Practica1 extends StatelessWidget {  // Define un widget sin estado (StatelessWidget) para la primera práctica.
  @override
  Widget build(BuildContext context) {  // Método que construye la interfaz gráfica de esta pantalla.
    return Scaffold(  // Scaffold proporciona una estructura básica de la interfaz, con AppBar y Body.
      appBar: AppBar(  // AppBar es la barra superior que muestra el título de la pantalla.
        title: Text(  // Título que aparece en el AppBar.
          'Práctica 1: Hola Mundo',  // El texto que se muestra en el título del AppBar.
          style: TextStyle(  // Estilo del texto del título del AppBar.
            color: Colors.white,  // Color del texto del título, blanco.
            fontSize: 20,  // Tamaño de la fuente del título.
            fontWeight: FontWeight.bold,  // Grosor de la fuente, negrita.
          ),
        ),
        backgroundColor: Colors.deepPurple,  // Color de fondo del AppBar (morado).
        elevation: 4,  // Elevación para dar sombra al AppBar.
      ),
      body: Center(  // El cuerpo de la pantalla, centrado en la pantalla.
        child: Column(  // Utiliza un widget Column para organizar los elementos de forma vertical.
          mainAxisAlignment: MainAxisAlignment.center,  // Centra los elementos verticalmente en la pantalla.
          children: [
            Text(  // Texto que se muestra en el cuerpo de la pantalla.
              'Hola Mundo',  // Texto que aparece en el centro de la pantalla.
              style: TextStyle(  // Estilo del texto.
                fontSize: 24,  // Tamaño de la fuente del texto.
                fontWeight: FontWeight.bold,  // Grosor de la fuente, negrita.
                color: Colors.deepPurple,  // Color del texto (morado).
              ),
            ),
            SizedBox(height: 20),  // Espacio vacío de 20 píxeles entre el texto y el botón.
            ElevatedButton(  // Un botón elevado que realiza una acción cuando se presiona.
              onPressed: () {  // Acción que se ejecuta cuando el botón es presionado.
                Navigator.pop(context);  // Navega hacia atrás (regresa al menú principal).
              },
              style: ElevatedButton.styleFrom(  // Establece el estilo del botón.
                foregroundColor: Colors.white,  // Color del texto del botón (blanco).
                backgroundColor: Colors.deepPurple,  // Color de fondo del botón (morado).
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),  // Relleno dentro del botón.
                shape: RoundedRectangleBorder(  // Define la forma del botón (bordes redondeados).
                  borderRadius: BorderRadius.circular(10),  // Establece los bordes redondeados con radio de 10 píxeles.
                ),
              ),
              child: Text('Volver al Menú'),  // El texto que aparece en el botón.
            ),
          ],
        ),
      ),
    );
  }
}
