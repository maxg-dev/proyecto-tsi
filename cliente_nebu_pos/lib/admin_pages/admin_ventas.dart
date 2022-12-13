import 'package:cliente_nebu_pos/admin_pages/venta_pages/venta_detail_page.dart';
import 'package:cliente_nebu_pos/services/ventas_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AdminVentas extends StatefulWidget {
  const AdminVentas({super.key});

  @override
  State<AdminVentas> createState() => _AdminVentasState();
}

class _AdminVentasState extends State<AdminVentas> {
  var fFecha = DateFormat('dd-MM-yyyy');
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder(
              future: VentasProvider().getAll(),
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
                      var venta = snapshot.data[index];
                      return ListTile(
                        leading: Icon(MdiIcons.currencyUsd),
                        title: Text(
                            'Venta: #${venta['id'].toString().padLeft(6, '0')} Cajero: ${venta['nombre'].toString()} Cliente: ${venta['cliente']['nombre']}'),
                        subtitle: Text(
                            'Fecha venta: ${fFecha.format(DateTime.parse(venta['created_at'])).toString()} Total venta: ${venta['total_venta']}'),
                        trailing: ElevatedButton(
                          child: Icon(MdiIcons.eye),
                          onPressed: () =>
                              pageSwap(context, VentaDetailPage(venta['id'])),
                        ),
                      );
                    },
                  ),
                );
              },
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
