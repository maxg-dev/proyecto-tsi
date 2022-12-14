import 'package:cliente_nebu_pos/services/p_categorias_provider.dart';
import 'package:cliente_nebu_pos/services/productos_provider.dart';
import 'package:flutter/material.dart';

class ProductoAddPage extends StatefulWidget {
  const ProductoAddPage({super.key});
  @override
  State<ProductoAddPage> createState() => _ProductoAddPageState();
}

class _ProductoAddPageState extends State<ProductoAddPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nombreController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController costoController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController stockMinController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  int tipo_producto = 1;
  int selectedCat = 0;
  // Estado
  // Categoria
  // Tipo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario para agregar producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 150, right: 150),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: const EdgeInsets.all(5), child: campoNombre()),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(child: campoPrecio()),
                    VerticalDivider(),
                    Expanded(child: campoCosto()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(child: campoStock()),
                    VerticalDivider(),
                    Expanded(child: campoStockMin()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: campoDescripcion(),
              ),
              Row(
                children: [
                  SizedBox(height: 50, width: 300, child: campoTipo()),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                        height: 50, width: 200, child: campoCategoria()),
                  ),
                ],
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
            children: [Icon(Icons.add), Text('Agregar producto')],
          )),
    );
  }

  void add() async {
    var tipo = tipo_producto;
    var nombre = nombreController.text.trim();
    var precio = int.parse(precioController.text.trim());
    var costo = int.parse(costoController.text.trim());
    var stock = int.parse(stockController.text.trim());
    var stock_min = int.parse(stockMinController.text.trim());
    var descripcion = descripcionController.text.trim();
    var categoria_id = selectedCat;
    await ProductosProvider().add(tipo, nombre, precio, costo, stock, stock_min,
        descripcion, categoria_id);
    Navigator.pop(context);
  }

  TextFormField campoNombre() {
    return TextFormField(
      controller: nombreController,
      maxLength: 50,
      decoration: InputDecoration(
          labelText: 'Nombre producto',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }

  TextFormField campoPrecio() {
    return TextFormField(
      controller: precioController,
      maxLength: 7,
      decoration: InputDecoration(
          labelText: 'Precio',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }

  TextFormField campoCosto() {
    return TextFormField(
      controller: costoController,
      maxLength: 7,
      decoration: InputDecoration(
          labelText: 'Costo',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }

  TextFormField campoStock() {
    return TextFormField(
      controller: stockController,
      maxLength: 4,
      decoration: InputDecoration(
          labelText: 'Stock',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }

  TextFormField campoStockMin() {
    return TextFormField(
      controller: stockMinController,
      maxLength: 4,
      decoration: InputDecoration(
          labelText: 'Stock m??nimo',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }

  TextFormField campoDescripcion() {
    return TextFormField(
      controller: descripcionController,
      maxLines: 3,
      maxLength: 100,
      decoration: InputDecoration(
          labelText: 'Descripci??n',
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
            title: Text('Producto', style: TextStyle(fontSize: 15)),
            leading: Radio(
              value: 1,
              groupValue: tipo_producto,
              onChanged: (value) {
                setState(() {
                  tipo_producto = value!;
                });
              },
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text('Insumo'),
            leading: Radio(
              value: 0,
              groupValue: tipo_producto,
              onChanged: (value) {
                setState(() {
                  tipo_producto = value!;
                });
              },
            ),
          ),
        )
      ],
    );
  }

  // Radio Button
  FutureBuilder campoCategoria() {
    return FutureBuilder(
      future: PCategoriasProvider().getAll(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return DropdownButtonFormField<String>(
            hint: Text('Cargando categor??as...'),
            items: [],
            onChanged: (value) {},
          );
        }

        var categorias = snapshot.data;

        return DropdownButtonFormField<int>(
          borderRadius: BorderRadius.circular(30),
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              contentPadding: EdgeInsets.only(left: 10, right: 10)),
          hint: Text('Categor??as'),
          items: categorias.map<DropdownMenuItem<int>>((categoria) {
            return DropdownMenuItem<int>(
              child: Text(categoria['nombre']),
              value: categoria['id'],
            );
          }).toList(),
          onChanged: (categoria) {
            selectedCat = categoria!;
          },
        );
      },
    );
  }
}
