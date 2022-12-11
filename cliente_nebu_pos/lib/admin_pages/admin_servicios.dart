import 'package:cliente_nebu_pos/admin_pages/servicio_pages/servicio_add_page.dart';
import 'package:cliente_nebu_pos/admin_pages/servicio_pages/servicio_detail_page.dart';
import 'package:cliente_nebu_pos/admin_pages/servicio_pages/servicio_update_page.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../services/servicios_provider.dart';

class AdminServicios extends StatefulWidget {
  const AdminServicios({super.key});

  @override
  State<AdminServicios> createState() => _AdminServiciosState();
}

class _AdminServiciosState extends State<AdminServicios> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder(
              future: ServiciosProvider().getAll(),
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
                      var servicio = snapshot.data[index];
                      return ListTile(
                        leading: Icon(MdiIcons.hairDryer),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'id#${servicio['id'].toString().padLeft(3, '0')} ${servicio['servicio_categoria']['nombre']} - ${servicio['nombre']}'),
                            Text(
                                'Precio: \$ ${servicio['precio'].toString().padRight(6)}'),
                            barraBotones(servicio),
                          ],
                        ),
                        trailing: Switch(
                          onChanged: (value) async {
                            await ServiciosProvider().updateState(
                                servicio['id'],
                                servicio['nombre'],
                                servicio['precio'],
                                value == true ? 1 : 0,
                                servicio['descripcion'],
                                servicio['servicio_categoria']['id']);
                            setState(() {});
                          },
                          value: servicio['estado'] == 1 ? true : false,
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
                  onPressed: () => pageSwap(context, ServicioAddPage()),
                  child: Row(
                      children: [Icon(Icons.add), Text('Agregar servicio')])),
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
                pageSwap(context, ServicioDetailPage(objeto['id']))),
      ),
      // Boton editar
      Padding(
        padding: const EdgeInsets.only(right: 5),
        child: ElevatedButton(
            child: Icon(Icons.edit),
            onPressed: () =>
                pageSwap(context, ServicioUpdatePage(objeto['id']))),
      ),
      // Boton eliminar
      ElevatedButton(
          child: Icon(MdiIcons.delete),
          onPressed: () async => ServiciosProvider().delete(objeto['id']).then(
                (value) => setState(() {}),
              ))
    ]);
  }

  pageSwap(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page))
        .then((value) => setState(() {}));
  }
}
