import 'package:cliente_nebu_pos/admin_pages/cliente_pages/cliente_add_page.dart';
import 'package:cliente_nebu_pos/admin_pages/cliente_pages/cliente_detail_page.dart';
import 'package:cliente_nebu_pos/admin_pages/cliente_pages/cliente_update_page.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../services/clientes_provider.dart';

class AdminClientes extends StatefulWidget {
  const AdminClientes({super.key});

  @override
  State<AdminClientes> createState() => _AdminClientesState();
}

class _AdminClientesState extends State<AdminClientes> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder(
              future: ClientesProvider().getAll(),
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
                      var cliente = snapshot.data[index];
                      return ListTile(
                        leading: Icon(MdiIcons.faceAgent),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Nombre: ${cliente['nombre'].toString().padRight(20)} Rut: ${cliente['rut']}'),
                            Text(
                                'Telefono: ${cliente['telefono'].toString().padRight(24)} Correo: ${cliente['correo']}'),
                            barraBotones(cliente),
                          ],
                        ),
                        trailing: Switch(
                          onChanged: (value) async {
                            await ClientesProvider().update(
                                cliente['id'],
                                cliente['rut'],
                                cliente['nombre'],
                                cliente['fecha_nacimiento'],
                                cliente['direccion'],
                                cliente['telefono'],
                                value == true ? 1 : 0,
                                cliente['correo']);
                            setState(() {});
                          },
                          value: cliente['estado'] == 1 ? true : false,
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
                  onPressed: () => pageSwap(context, ClienteAddPage()),
                  child: Row(
                      children: [Icon(Icons.add), Text('Agregar cliente')])),
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
                pageSwap(context, ClienteDetailPage(objeto['id']))),
      ),
      // Boton editar
      Padding(
        padding: const EdgeInsets.only(right: 5),
        child: ElevatedButton(
            child: Icon(Icons.edit),
            onPressed: () =>
                pageSwap(context, ClienteUpdatePage(objeto['id']))),
      ),
      // Boton eliminar
      ElevatedButton(
          child: Icon(MdiIcons.delete),
          onPressed: () async => ClientesProvider().delete(objeto['id']).then(
                (value) => setState(() {}),
              ))
    ]);
  }

  pageSwap(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page))
        .then((value) => setState(() {}));
  }
}
