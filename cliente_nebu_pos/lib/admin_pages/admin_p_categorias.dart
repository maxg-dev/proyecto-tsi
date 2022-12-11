import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../services/p_categorias_provider.dart';
import 'p_categoria_pages/p_categoria_add_page.dart';
import 'p_categoria_pages/p_categoria_update_page.dart';

class AdminPCategorias extends StatefulWidget {
  const AdminPCategorias({super.key});

  @override
  State<AdminPCategorias> createState() => _AdminPCategoriasState();
}

class _AdminPCategoriasState extends State<AdminPCategorias> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder(
              future: PCategoriasProvider().getAll(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var categoria = snapshot.data[index];
                      return ListTile(
                        leading: Icon(MdiIcons.dropbox),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Nombre: ${categoria['nombre'].toString().padRight(20)}'),
                            barraBotones(categoria),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              width: 170,
              child: ElevatedButton(
                  style: ButtonStyle(),
                  onPressed: () => pageSwap(context, PCategoriaAddPage()),
                  child: Row(
                      children: [Icon(Icons.add), Text('Agregar categoria')])),
            ),
          ),
        ],
      ),
    );
  }

  Row barraBotones(objeto) {
    return Row(children: [
      // Boton editar
      Padding(
        padding: const EdgeInsets.only(right: 5),
        child: ElevatedButton(
            child: Icon(Icons.edit),
            onPressed: () =>
                pageSwap(context, PCategoriaUpdatePage(objeto['id']))),
      ),
      // Boton eliminar
      ElevatedButton(
          child: Icon(MdiIcons.delete),
          onPressed: () async =>
              PCategoriasProvider().delete(objeto['id']).then(
                    (value) => setState(() {}),
                  ))
    ]);
  }

  pageSwap(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page))
        .then((value) => setState(() {}));
  }
}
