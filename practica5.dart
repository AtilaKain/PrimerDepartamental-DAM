import 'package:flutter/material.dart';  // Importa Flutter para la creación de interfaces
import 'package:sqflite/sqflite.dart';  // Importa Sqflite para la base de datos SQLite
import 'package:path/path.dart' as path;  // Importa el paquete 'path' para manejar rutas de archivos

class Practica5 extends StatefulWidget {
  @override
  _Practica5State createState() => _Practica5State();  // Crea el estado del widget para la práctica 5
}

class _Practica5State extends State<Practica5> {
  Database? _database;  // Instancia de la base de datos
  List<Map<String, dynamic>> _items = [];  // Lista que almacenará los elementos recuperados de la base de datos
  final TextEditingController _nameController = TextEditingController();  // Controlador para el campo de texto de nombre
  final TextEditingController _ageController = TextEditingController();  // Controlador para el campo de texto de edad

  @override
  void initState() {
    super.initState();
    _initDatabase();  // Llama a la función para inicializar la base de datos cuando el estado se crea
  }

  // Método para inicializar la base de datos
  Future<void> _initDatabase() async {
    final databasePath = await getDatabasesPath();  // Obtiene la ruta para las bases de datos
    final dbPath = path.join(databasePath, 'items.db');  // Define la ruta completa para la base de datos

    // Abre o crea la base de datos
    _database = await openDatabase(
      dbPath,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE items(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',  // Crea la tabla 'items'
        );
      },
      version: 1,  // Versión de la base de datos, incrementa si haces cambios en la estructura de la tabla
    );

    _loadItems();  // Carga los elementos almacenados en la base de datos
  }

  // Método para cargar los elementos desde la base de datos
  Future<void> _loadItems() async {
    final List<Map<String, dynamic>> items = await _database!.query('items');  // Consulta todos los registros de la tabla 'items'
    setState(() {
      _items = items;  // Actualiza la lista con los registros obtenidos
    });
  }

  // Método para agregar un nuevo item a la base de datos
  Future<void> _addItem(String name, int age) async {
    try {
      await _database!.insert('items', {'name': name, 'age': age});  // Inserta el nuevo registro en la base de datos
      _loadItems();  // Recarga los elementos después de agregar uno nuevo
      _nameController.clear();  // Limpia el campo de nombre
      _ageController.clear();  // Limpia el campo de edad
    } catch (e) {
      print('Error al agregar el registro: $e');  // Muestra un mensaje de error si falla la inserción
    }
  }

  // Método para eliminar un item de la base de datos
  Future<void> _deleteItem(int id) async {
    await _database!.delete('items', where: 'id = ?', whereArgs: [id]);  // Elimina el item con el ID correspondiente
    _loadItems();  // Recarga los elementos después de eliminar uno
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Práctica 5: Almacenamiento en SQLite',  // Título de la aplicación en el AppBar
          style: TextStyle(
            color: Colors.white,  // Texto blanco en el AppBar
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,  // Color morado para el AppBar
        elevation: 4,  // Sombra en el AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),  // Agrega un padding alrededor del cuerpo de la interfaz
        child: Column(
          children: <Widget>[
            // Campo de texto para ingresar el nombre
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                labelStyle: TextStyle(color: Colors.deepPurple),  // Color morado en el texto del label
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),  // Borde morado para el campo de texto
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),  // Borde morado cuando el campo es enfocado
                ),
              ),
            ),
            SizedBox(height: 10),  // Espacio entre el primer y el segundo campo de texto
            // Campo de texto para ingresar la edad
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                labelText: 'Edad',
                labelStyle: TextStyle(color: Colors.deepPurple),  // Color morado en el texto del label
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),  // Borde morado para el campo de texto
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),  // Borde morado cuando el campo es enfocado
                ),
              ),
              keyboardType: TextInputType.number,  // Permite la entrada solo de números
            ),
            SizedBox(height: 20),  // Espacio antes del botón de agregar
            // Botón para agregar un item a la base de datos
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text.trim();  // Obtiene el nombre ingresado y elimina los espacios
                final age = int.tryParse(_ageController.text.trim()) ?? 0;  // Convierte la edad a un número entero, si no es válido se asigna 0

                if (name.isNotEmpty && age > 0) {  // Si el nombre no está vacío y la edad es mayor que 0
                  _addItem(name, age);  // Llama al método para agregar el item
                } else {
                  // Muestra un mensaje de error si no se ingresa un nombre o edad válida
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Por favor, ingresa un nombre y una edad válida.'),
                      backgroundColor: Colors.deepPurple,  // Fondo morado para el SnackBar
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.deepPurple,  // Texto blanco y fondo morado
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),  // Bordes redondeados para el botón
                ),
              ),
              child: Text('Agregar Item'),  // Texto del botón
            ),
            SizedBox(height: 20),  // Espacio entre el botón y la lista
            // Lista de elementos que se obtienen de la base de datos
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,  // Número de elementos en la lista
                itemBuilder: (context, index) {
                  final item = _items[index];  // Elemento actual de la lista
                  return Card(
                    elevation: 4,  // Sombra en la tarjeta
                    margin: EdgeInsets.symmetric(vertical: 5),  // Margen entre las tarjetas
                    child: ListTile(
                      title: Text(
                        item['name'],  // Muestra el nombre del item
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.deepPurple,  // Texto morado
                        ),
                      ),
                      subtitle: Text(
                        'Edad: ${item['age']}',  // Muestra la edad del item
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),  // Icono de eliminar en rojo
                        onPressed: () {
                          _deleteItem(item['id']);  // Llama al método para eliminar el item
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            // Botón para regresar al menú principal
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

  @override
  void dispose() {
    _nameController.dispose();  // Libera el controlador de nombre
    _ageController.dispose();  // Libera el controlador de edad
    super.dispose();  // Llama al método dispose del super
  }
}
