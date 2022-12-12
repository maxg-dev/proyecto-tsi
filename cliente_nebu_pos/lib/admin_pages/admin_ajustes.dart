import 'package:cliente_nebu_pos/services/ajustes_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'ajuste_pages/ajuste_add_page.dart';

class AdminAjustes extends StatefulWidget {
  const AdminAjustes({super.key});

  @override
  State<AdminAjustes> createState() => _AdminAjustesState();
}

class _AdminAjustesState extends State<AdminAjustes> {
  var fFecha = DateFormat('dd-MM-yyyy');
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder(
              future: AjustesProvider().getAll(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var ajuste = snapshot.data[index];
                      var cantidad = ajuste['cantidad'] < 0
                          ? -ajuste['cantidad']
                          : ajuste['cantidad'];
                      return ListTile(
                        leading: Icon(MdiIcons.arrowUpDown),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Tipo: ${ajuste['tipo'] == 1 ? 'Agregar'.padRight(20) : 'Descontar'.padRight(18)} Cantidad: ${cantidad.toString().padLeft(3, '0').padRight(6)} Producto: ${ajuste['producto']['nombre']} '),
                            Text(
                                'Descripción: ${ajuste['descripcion']} Fecha ajuste: ${fFecha.format(DateTime.parse(ajuste['created_at']))} '),
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
                  onPressed: () => pageSwap(context, AjusteAddPage()),
                  child:
                      Row(children: [Icon(Icons.add), Text('Agregar ajuste')])),
            ),
          ),
        ],
      ),
    );
  }

  pageSwap(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page))
        .then((value) => setState(() {}));
  }
}
