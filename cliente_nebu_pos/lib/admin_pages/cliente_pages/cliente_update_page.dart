import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../services/clientes_provider.dart';

class ClienteUpdatePage extends StatefulWidget {
  final int id;
  const ClienteUpdatePage(this.id, {super.key});
  @override
  State<ClienteUpdatePage> createState() => _ClienteUpdatePageState();
}

class _ClienteUpdatePageState extends State<ClienteUpdatePage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController rutController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  DateTime fechaSeleccionada = DateTime(2022);
  var fFecha = DateFormat('dd-MM-yyyy');
  var state = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario para editar cliente'),
      ),
      body: FutureBuilder(
          future: ClientesProvider().get(widget.id),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            var cliente = snapshot.data;

            rutController.text = rutController.text.isEmpty
                ? cliente['rut']
                : rutController.text;

            nombreController.text = nombreController.text.isEmpty
                ? cliente['nombre']
                : nombreController.text;

            fechaSeleccionada = DateTime(2022) == fechaSeleccionada
                ? DateTime.parse(cliente['fecha_nacimiento'])
                : fechaSeleccionada;

            direccionController.text = direccionController.text.isEmpty
                ? cliente['direccion']
                : direccionController.text;

            telefonoController.text = telefonoController.text.isEmpty
                ? cliente['telefono']
                : telefonoController.text;

            correoController.text = correoController.text.isEmpty
                ? cliente['correo']
                : correoController.text;

            state = cliente['estado'];

            return Padding(
              padding: const EdgeInsets.only(top: 30, left: 150, right: 150),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Expanded(child: campoRut()),
                          VerticalDivider(),
                          Expanded(child: campoNombre()),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Expanded(child: campoCorreo()),
                          VerticalDivider(),
                          Expanded(child: campoTelefono()),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Expanded(child: campoDireccion()),
                          VerticalDivider(),
                          Expanded(child: campoFechaNacimiento()),
                        ],
                      ),
                    ),
                    campoBoton()
                  ],
                ),
              ),
            );
          }),
    );
  }

  Padding campoBoton() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ElevatedButton(
          style: ButtonStyle(
            maximumSize: MaterialStatePropertyAll(Size(190, 50)),
          ),
          onPressed: () => update(),
          child: Row(
            children: [Icon(Icons.add), Text('Editar cliente')],
          )),
    );
  }

  void update() async {
    var rut = rutController.text.trim();
    var nombre = nombreController.text.trim();
    var fecha = fechaSeleccionada.toString();
    var direccion = direccionController.text.trim();
    var telefono = telefonoController.text.trim();
    var correo = correoController.text.trim();
    var estado = state;
    await ClientesProvider().update(
        widget.id, rut, nombre, fecha, direccion, telefono, estado, correo);
    Navigator.pop(context);
  }

  TextFormField campoNombre() {
    return TextFormField(
      controller: nombreController,
      maxLength: 50,
      decoration: InputDecoration(
          labelText: 'Nombre cliente',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }

  TextFormField campoRut() {
    return TextFormField(
      controller: rutController,
      maxLength: 10,
      decoration: InputDecoration(
          labelText: 'Rut ej:12345678-1',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }

  Row campoFechaNacimiento() {
    return Row(
      children: [
        Text(
          'Fecha de nacimiento: ',
          style: TextStyle(fontSize: 16),
        ),
        Text(
          fFecha.format(fechaSeleccionada),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        IconButton(
          icon: Icon(MdiIcons.calendar),
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              locale: Locale('es', 'ES'),
            ).then((fecha) {
              setState(() {
                fechaSeleccionada = fecha ?? fechaSeleccionada;
              });
            });
          },
        ),
      ],
    );
  }

  TextFormField campoDireccion() {
    return TextFormField(
      controller: direccionController,
      maxLength: 100,
      decoration: InputDecoration(
          labelText: 'Dirección',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }

  TextFormField campoTelefono() {
    return TextFormField(
      controller: telefonoController,
      maxLength: 10,
      decoration: InputDecoration(
          labelText: 'Teléfono',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }

  TextFormField campoCorreo() {
    return TextFormField(
      controller: correoController,
      maxLength: 100,
      decoration: InputDecoration(
          labelText: 'Correo',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }
}
