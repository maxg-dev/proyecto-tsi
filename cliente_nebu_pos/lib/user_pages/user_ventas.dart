import 'package:cliente_nebu_pos/services/ventas_provider.dart';
import 'package:cliente_nebu_pos/user_pages/user_venta_add.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../services/clientes_provider.dart';

class UserVentas extends StatefulWidget {
  const UserVentas({super.key});

  @override
  State<UserVentas> createState() => _UserVentasState();
}

class _UserVentasState extends State<UserVentas> {
  var fFecha = DateFormat('dd-MM-yyyy');
  var venta;
  int selectedCliente = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    campoCliente(),
                    campoBotonCliente(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder campoCliente() {
    return FutureBuilder(
      future: ClientesProvider().getAll(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
            width: 700,
            child: DropdownButtonFormField<String>(
              borderRadius: BorderRadius.circular(30),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  contentPadding: EdgeInsets.only(left: 10, right: 10)),
              hint: Text('Cargando clientes...'),
              items: [],
              onChanged: (value) {},
            ),
          );
        }

        var clientes = snapshot.data;

        return SizedBox(
          width: 700,
          child: DropdownButtonFormField<int>(
            borderRadius: BorderRadius.circular(30),
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                contentPadding: EdgeInsets.only(left: 10, right: 10)),
            hint: Text('Sin registrar'),
            items: clientes.map<DropdownMenuItem<int>>((cliente) {
              return DropdownMenuItem<int>(
                child: Text(cliente['rut']),
                value: cliente['id'],
              );
            }).toList(),
            onChanged: (cliente) {
              selectedCliente = cliente!;
            },
          ),
        );
      },
    );
  }

  IconButton campoBotonCliente() {
    return IconButton(
      iconSize: 30,
      color: Colors.green,
      hoverColor: Colors.green.shade100,
      icon: Icon(MdiIcons.accountCheck),
      onPressed: () async {
        venta = await VentasProvider().add('Cajero', selectedCliente);
        pageSwap(context, UserVentaAdd(selectedCliente, venta['id']));
      },
    );
  }

  pageSwap(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page))
        .then((value) => setState(() {}));
  }
}
