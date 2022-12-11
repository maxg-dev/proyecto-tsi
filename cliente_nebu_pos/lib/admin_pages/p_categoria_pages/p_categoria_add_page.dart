import 'package:cliente_nebu_pos/services/p_categorias_provider.dart';
import 'package:flutter/material.dart';

class PCategoriaAddPage extends StatefulWidget {
  const PCategoriaAddPage({super.key});
  @override
  State<PCategoriaAddPage> createState() => _PCategoriaAddPageState();
}

class _PCategoriaAddPageState extends State<PCategoriaAddPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nombreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario para agregar categoria'),
      ),
      body: Padding(
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
            children: [Icon(Icons.add), Text('Agregar categoria')],
          )),
    );
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

  void add() async {
    var nombre = nombreController.text.trim();
    await PCategoriasProvider().add(nombre);
    Navigator.pop(context);
  }
}
