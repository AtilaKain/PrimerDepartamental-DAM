import 'package:flutter/material.dart';  // Importa el paquete de Flutter para usar widgets y crear la interfaz de usuario.
import 'screens/practica1.dart';  // Importa la pantalla de la práctica 1.
import 'screens/practica2.dart';  // Importa la pantalla de la práctica 2.
import 'screens/practica3.dart';  // Importa la pantalla de la práctica 3.
import 'screens/practica4.dart';  // Importa la pantalla de la práctica 4.
import 'screens/practica5.dart';  // Importa la pantalla de la práctica 5.
import 'screens/practica6.dart';  // Importa la pantalla de la práctica 6.

void main() {
  runApp(MyApp());  // Inicia la aplicación ejecutando el widget MyApp.
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prácticas Flutter',  // Título de la aplicación que se mostrará en el sistema operativo.
      theme: ThemeData(  // Establece el tema de la aplicación.
        primarySwatch: Colors.deepPurple,  // Establece el color principal de la aplicación a morado.
        visualDensity: VisualDensity.adaptivePlatformDensity,  // Ajusta la densidad visual según la plataforma (Android o iOS).
        scaffoldBackgroundColor: Colors.grey[100],  // Establece el color de fondo de la pantalla a gris claro.
        appBarTheme: AppBarTheme(  // Personaliza la apariencia del AppBar.
          color: Colors.deepPurple,  // Cambia el color del AppBar a morado.
          elevation: 4,  // Establece la sombra del AppBar.
          titleTextStyle: TextStyle(  // Cambia el estilo del texto del título del AppBar.
            color: Colors.white,  // Establece el color del texto a blanco.
            fontSize: 20,  // Tamaño del texto del título.
            fontWeight: FontWeight.bold,  // Establece el grosor del texto a negrita.
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(  // Personaliza los botones elevados (ElevatedButton).
          style: ElevatedButton.styleFrom(  // Aplica un estilo a los botones elevados.
            foregroundColor: Colors.white,  // Color del texto en el botón.
            backgroundColor: Colors.deepPurple,  // Color de fondo del botón.
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),  // Establece el relleno dentro del botón.
            shape: RoundedRectangleBorder(  // Establece la forma del botón (bordes redondeados).
              borderRadius: BorderRadius.circular(10),  // Define los bordes redondeados del botón.
            ),
          ),
        ),
        textTheme: TextTheme(  // Personaliza el estilo global del texto en la aplicación.
          titleLarge: TextStyle(  // Establece el estilo para los textos grandes.
            fontSize: 18,  // Tamaño de la fuente del título grande.
            fontWeight: FontWeight.bold,  // Define el grosor de la fuente (negrita).
            color: Colors.deepPurple,  // Color del texto a morado.
          ),
        ),
      ),
      home: MainMenu(),  // Establece la pantalla principal de la aplicación (MainMenu).
    );
  }
}

// Define el widget para el menú principal (MainMenu).
class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(  // Scaffold es la estructura básica de la pantalla con una barra superior.
      appBar: AppBar(
        title: Text('Menú Principal'),  // Establece el título del AppBar.
      ),
      body: Center(  // Centra los elementos dentro de la pantalla.
        child: Column(  // Usamos un widget Column para apilar elementos verticalmente.
          mainAxisAlignment: MainAxisAlignment.center,  // Centra los elementos de forma vertical.
          children: <Widget>[  // Lista de widgets dentro de la columna.
            ElevatedButton(  // Botón elevado para la práctica 1.
              onPressed: () {  // Acción cuando el botón es presionado.
                Navigator.push(  // Navega a otra pantalla (Práctica 1).
                  context,
                  MaterialPageRoute(builder: (context) => Practica1()),  // Llama a la pantalla Practica1.
                );
              },
              child: Text('Práctica 1'),  // Texto que aparecerá en el botón.
            ),
            SizedBox(height: 10),  // Espacio de 10 píxeles entre botones.
            ElevatedButton(  // Botón para la práctica 2.
              onPressed: () {  // Acción cuando el botón es presionado.
                Navigator.push(  // Navega a la pantalla de Practica2.
                  context,
                  MaterialPageRoute(builder: (context) => Practica2()),  // Llama a la pantalla Practica2.
                );
              },
              child: Text('Práctica 2'),  // Texto que aparecerá en el botón.
            ),
            SizedBox(height: 10),  // Espacio de 10 píxeles entre botones.
            ElevatedButton(  // Botón para la práctica 3.
              onPressed: () {  // Acción cuando el botón es presionado.
                Navigator.push(  // Navega a la pantalla de Practica3.
                  context,
                  MaterialPageRoute(builder: (context) => Practica3()),  // Llama a la pantalla Practica3.
                );
              },
              child: Text('Práctica 3'),  // Texto que aparecerá en el botón.
            ),
            SizedBox(height: 10),  // Espacio de 10 píxeles entre botones.
            ElevatedButton(  // Botón para la práctica 4.
              onPressed: () {  // Acción cuando el botón es presionado.
                Navigator.push(  // Navega a la pantalla de Practica4.
                  context,
                  MaterialPageRoute(builder: (context) => Practica4()),  // Llama a la pantalla Practica4.
                );
              },
              child: Text('Práctica 4'),  // Texto que aparecerá en el botón.
            ),
            SizedBox(height: 10),  // Espacio de 10 píxeles entre botones.
            ElevatedButton(  // Botón para la práctica 5.
              onPressed: () {  // Acción cuando el botón es presionado.
                Navigator.push(  // Navega a la pantalla de Practica5.
                  context,
                  MaterialPageRoute(builder: (context) => Practica5()),  // Llama a la pantalla Practica5.
                );
              },
              child: Text('Práctica 5'),  // Texto que aparecerá en el botón.
            ),
            SizedBox(height: 10),  // Espacio de 10 píxeles entre botones.
            ElevatedButton(  // Botón para la práctica 6.
              onPressed: () {  // Acción cuando el botón es presionado.
                Navigator.push(  // Navega a la pantalla de Practica6.
                  context,
                  MaterialPageRoute(builder: (context) => Practica6()),  // Llama a la pantalla Practica6.
                );
              },
              child: Text('Práctica 6'),  // Texto que aparecerá en el botón.
            ),
          ],
        ),
      ),
    );
  }
}
