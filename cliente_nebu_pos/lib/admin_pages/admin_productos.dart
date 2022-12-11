import 'package:cliente_nebu_pos/admin_pages/producto_pages/producto_add_page.dart';
import 'package:cliente_nebu_pos/admin_pages/producto_pages/producto_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../services/productos_provider.dart';

class AdminProductos extends StatefulWidget {
  const AdminProductos({super.key});

  @override
  State<AdminProductos> createState() => _AdminProductosState();
}

class _AdminProductosState extends State<AdminProductos> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder(
              future: ProductosProvider().getAll(),
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
                      var producto = snapshot.data[index];
                      return ListTile(
                        leading: Icon(MdiIcons.dropbox),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'id#${producto['id'].toString().padLeft(3, '0')} ${producto['producto_categoria']['nombre']} - ${producto['nombre']}'),
                            Text(
                                'Precio: \$ ${producto['precio'].toString().padRight(6)} Stock: ${producto['stock'].toString()}'),
                            barraBotones(producto),
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
                  onPressed: () => pageSwap(context, ProductoAddPage()),
                  child: Row(
                      children: [Icon(Icons.add), Text('Agregar Producto')])),
            ),
          ),
        ],
      ),
    );
  }

  Row barraBotones(objeto) {
    return Row(children: [
      // Boton detalle
      Padding(
        padding: const EdgeInsets.only(right: 5),
        child: ElevatedButton(
            child: Icon(MdiIcons.eye),
            onPressed: () =>
                pageSwap(context, ProductoDetailPage(objeto['id']))),
      ),
      // Boton editar
      Padding(
        padding: const EdgeInsets.only(right: 5),
        child: ElevatedButton(child: Icon(Icons.edit), onPressed: () {}),
      ),
      // Boton eliminar
      ElevatedButton(child: Icon(MdiIcons.delete), onPressed: () {})
    ]);
  }

  pageSwap(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page))
        .then((value) => setState(() {}));
  }
}
