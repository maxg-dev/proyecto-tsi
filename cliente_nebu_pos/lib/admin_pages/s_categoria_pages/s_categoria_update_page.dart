import 'package:flutter/material.dart';
import '../../services/s_categorias_provider.dart';

class SCategoriaUpdatePage extends StatefulWidget {
  final int id;
  const SCategoriaUpdatePage(this.id, {super.key});
  @override
  State<SCategoriaUpdatePage> createState() => _SCategoriaUpdatePageState();
}

class _SCategoriaUpdatePageState extends State<SCategoriaUpdatePage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nombreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario para editar categoria de productos'),
      ),
      body: FutureBuilder(
          future: SCategoriasProvider().get(widget.id),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            var categoria = snapshot.data;

            nombreController.text = categoria['nombre'];

            return Padding(
              padding: const EdgeInsets.only(top: 30, left: 150, right: 150),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: campoNombre(),
                    ),
                    campoBoton()
                  ],
                ),
              ),
            );
          }),
    );
  }

  Padding campoBoton() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ElevatedButton(
          style: ButtonStyle(
            maximumSize: MaterialStatePropertyAll(Size(190, 50)),
          ),
          onPressed: () => update(),
          child: Row(
            children: [Icon(Icons.add), Text('Editar categoria')],
          )),
    );
  }

  void update() async {
    var nombre = nombreController.text.trim();
    await SCategoriasProvider().update(widget.id, nombre);
    Navigator.pop(context);
  }

  TextFormField campoNombre() {
    return TextFormField(
      controller: nombreController,
      maxLength: 50,
      decoration: InputDecoration(
          labelText: 'Nombre categoria',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }
}
