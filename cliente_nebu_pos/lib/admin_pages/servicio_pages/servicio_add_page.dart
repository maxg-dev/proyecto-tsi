import 'package:flutter/material.dart';

import '../../services/s_categorias_provider.dart';
import '../../services/servicios_provider.dart';

class ServicioAddPage extends StatefulWidget {
  const ServicioAddPage({super.key});
  @override
  State<ServicioAddPage> createState() => _ServicioAddPageState();
}

class _ServicioAddPageState extends State<ServicioAddPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nombreController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  int selectedCat = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario para agregar servicio'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 150, right: 150),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: const EdgeInsets.all(5), child: campoNombre()),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(child: campoPrecio()),
                    VerticalDivider(),
                    SizedBox(height: 50, width: 200, child: campoCategoria()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: campoDescripcion(),
              ),
              campoBoton()
            ],
          ),
        ),
      ),
    );
  }

  Padding campoBoton() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ElevatedButton(
          style: ButtonStyle(
            maximumSize: MaterialStatePropertyAll(Size(190, 50)),
          ),
          onPressed: () => add(),
          child: Row(
            children: [Icon(Icons.add), Text('Agregar servicio')],
          )),
    );
  }

  void add() async {
    var nombre = nombreController.text.trim();
    var precio = int.parse(precioController.text.trim());
    var descripcion = descripcionController.text.trim();
    var categoria_id = selectedCat;
    await ServiciosProvider().add(nombre, precio, descripcion, categoria_id);
    Navigator.pop(context);
  }

  TextFormField campoNombre() {
    return TextFormField(
      controller: nombreController,
      maxLength: 50,
      decoration: InputDecoration(
          labelText: 'Nombre servicio',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }

  TextFormField campoPrecio() {
    return TextFormField(
      controller: precioController,
      maxLength: 7,
      decoration: InputDecoration(
          labelText: 'Precio',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }

  TextFormField campoDescripcion() {
    return TextFormField(
      controller: descripcionController,
      maxLines: 3,
      maxLength: 100,
      decoration: InputDecoration(
          labelText: 'Descripción',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }

  // Radio Button
  FutureBuilder campoCategoria() {
    return FutureBuilder(
      future: SCategoriasProvider().getAll(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return DropdownButtonFormField<String>(
            hint: Text('Cargando categorías...'),
            items: [],
            onChanged: (value) {},
          );
        }

        var categorias = snapshot.data;

        return DropdownButtonFormField<int>(
          borderRadius: BorderRadius.circular(30),
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              contentPadding: EdgeInsets.only(left: 10, right: 10)),
          hint: Text('Categorías'),
          items: categorias.map<DropdownMenuItem<int>>((categoria) {
            return DropdownMenuItem<int>(
              child: Text(categoria['nombre']),
              value: categoria['id'],
            );
          }).toList(),
          onChanged: (categoria) {
            selectedCat = categoria!;
          },
        );
      },
    );
  }
}
