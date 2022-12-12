import 'package:cliente_nebu_pos/services/productos_provider.dart';
import 'package:flutter/material.dart';

import '../../services/ajustes_provider.dart';

class AjusteAddPage extends StatefulWidget {
  const AjusteAddPage({super.key});
  @override
  State<AjusteAddPage> createState() => _AjusteAddPageState();
}

class _AjusteAddPageState extends State<AjusteAddPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController cantidadController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  int tipo_ajuste = 1;
  int selectedProducto = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajuste de inventario'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 150, right: 150),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: campoProducto(),
              ),
              campoTipo(),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(child: campoCantidad()),
                    VerticalDivider(),
                    Expanded(child: campoDescripcion()),
                  ],
                ),
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
            children: [Icon(Icons.add), Text('Generar ajuste')],
          )),
    );
  }

  void add() async {
    var tipo = tipo_ajuste;
    var descripcion = descripcionController.text.trim();
    var cantidad = int.parse(cantidadController.text.trim());
    var producto_id = selectedProducto;

    var producto = await ProductosProvider().get(producto_id);
    var stock = producto['stock'];

    if (stock >= cantidad) {
      cantidad = tipo == 1 ? cantidad : -cantidad;
      stock = stock + cantidad;
      await ProductosProvider().update(
          producto_id,
          producto['tipo'],
          producto['nombre'],
          producto['precio'],
          producto['costo'],
          stock,
          producto['stock_min'],
          producto['estado'],
          producto['descripcion'],
          producto['producto_categoria_id']);

      await AjustesProvider().add(tipo, cantidad, descripcion, producto_id);
    } else {
      return;
    }

    Navigator.pop(context);
  }

  TextFormField campoCantidad() {
    return TextFormField(
      controller: cantidadController,
      maxLength: 4,
      decoration: InputDecoration(
          labelText: 'Cantidad',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }

  TextFormField campoDescripcion() {
    return TextFormField(
      controller: descripcionController,
      maxLength: 100,
      decoration: InputDecoration(
          labelText: 'Descripción',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }

  // Combo box
  Row campoTipo() {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            minLeadingWidth: 0,
            title: Text('Agregar'),
            leading: Radio(
              value: 1,
              groupValue: tipo_ajuste,
              onChanged: (value) {
                setState(() {
                  tipo_ajuste = value!;
                });
              },
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text('Descontar'),
            minLeadingWidth: 0,
            leading: Radio(
              value: 0,
              groupValue: tipo_ajuste,
              onChanged: (value) {
                setState(() {
                  tipo_ajuste = value!;
                });
              },
            ),
          ),
        )
      ],
    );
  }

  // Radio Button
  FutureBuilder campoProducto() {
    return FutureBuilder(
      future: ProductosProvider().getAll(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return DropdownButtonFormField<String>(
            hint: Text('Cargando productos...'),
            items: [],
            onChanged: (value) {},
          );
        }

        var productos = snapshot.data;

        return DropdownButtonFormField<int>(
          borderRadius: BorderRadius.circular(30),
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              contentPadding: EdgeInsets.only(left: 10, right: 10)),
          hint: Text('Seleccionar producto'),
          items: productos.map<DropdownMenuItem<int>>((producto) {
            return DropdownMenuItem<int>(
              child:
                  Text('${producto['nombre']} | stock: ${producto['stock']}'),
              value: producto['id'],
            );
          }).toList(),
          onChanged: (producto) {
            selectedProducto = producto!;
          },
        );
      },
    );
  }
}
