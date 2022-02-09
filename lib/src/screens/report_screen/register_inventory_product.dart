import 'package:app_sistema_invetnario/src/UI/ui.dart';
import 'package:app_sistema_invetnario/src/models/inventario_response.dart';
import 'package:app_sistema_invetnario/src/provider/inventory_form_provider.dart';
import 'package:app_sistema_invetnario/src/services/inventario_services.dart';
import 'package:app_sistema_invetnario/src/services/notification_service.dart';
import 'package:app_sistema_invetnario/src/services/report_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const valorDefault = 1;
int valor = valorDefault;

class RegisterInventoryProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Products product =
        ModalRoute.of(context)!.settings.arguments as Products;
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de inventario"),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        leadingWidth: 40,
      ),
      body: _FormRegisterInventory(
        product: product,
      ),
      //bottomNavigationBar: HomeScreen(),
    );
  }
}

class _FormRegisterInventory extends StatelessWidget {
  final Products product;
  const _FormRegisterInventory({required this.product});
  @override
  Widget build(BuildContext context) {
    final reportService = Provider.of<ReportService>(context);
    final inventoryForm = Provider.of<InventoryForm>(context);
    final TextEditingController cantController = TextEditingController();
    final TextEditingController consumoContrller = TextEditingController();
    final textStyle = TextStyle(
        fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold);
    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: inventoryForm.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "Nombre del producto",
                    style: textStyle,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: _buildDecorationInput(),
                    child: TextFormField(
                      initialValue: product.nombre,
                      enabled: false,
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.text,
                      decoration: InputDecorationForm.formInputDecoration(
                        labelText: "",
                      ),
                      //onChanged: (value) => registerForm.nombre = value,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "Categoría",
                    style: textStyle,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: _buildDecorationInput(),
                    child: TextFormField(
                      initialValue: product.categorium.nombre,
                      enabled: false,
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.text,
                      decoration: InputDecorationForm.formInputDecoration(
                        labelText: "",
                      ),
                      //onChanged: (value) => registerForm.nombre = value,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "Tipo",
                    style: textStyle,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: _buildDecorationInput(),
                    child: TextFormField(
                      initialValue: product.tipo,
                      enabled: false,
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.text,
                      decoration: InputDecorationForm.formInputDecoration(
                        labelText: "",
                      ),
                      //onChanged: (value) => registerForm.nombre = value,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "Stock",
                    style: textStyle,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: _buildDecorationInput(),
                    child: TextFormField(
                      initialValue:
                          '${product.productos[0].productoAmbulancia[0].stock}',
                      enabled: false,
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.text,
                      decoration: InputDecorationForm.formInputDecoration(
                        labelText: "",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "Carga",
                    style: textStyle,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: _buildDecorationInput(),
                    child: TextFormField(
                      autofocus: false,
                      controller: cantController,
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.text,
                      decoration: InputDecorationForm.formInputDecoration(
                        labelText: "",
                      ),
                      onChanged: (value) {
                        inventoryForm.carga = value;
                      },
                      validator: (value) {
                        if (value != null) {
                          if (int.tryParse(value) == null) {
                            return 'El valor ingresado no luce como un número entero';
                          }

                          if (int.parse(value) < 0) {
                            return 'El valor no puede ser menor a cero';
                          }
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                (product.tipo == "Insumo Medico")
                    ? Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Text(
                              "Consumo",
                              style: textStyle,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(left: 10.0),
                              decoration: _buildDecorationInput(),
                              child: TextFormField(
                                autofocus: false,
                                controller: consumoContrller,
                                style: TextStyle(color: Colors.black),
                                keyboardType: TextInputType.text,
                                decoration:
                                    InputDecorationForm.formInputDecoration(
                                  labelText: "",
                                ),
                                //onChanged: (value) => registerForm.nombre = value,
                                validator: (value) {
                                  if (value != null) {
                                    if (int.tryParse(value) == null) {
                                      return 'El valor ingresado no luce como un número entero';
                                    }

                                    if (int.parse(value) < 0) {
                                      return 'El valor no puede ser menor a cero';
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 25.0,
                )
              ],
            ),
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.red.withOpacity(0.8),
            onPressed: () async {
              FocusScope.of(context).unfocus();
              final inventario =
                  Provider.of<Inventario>(context, listen: false);

              if (!inventoryForm.isValidForm()) {
                return;
              }
              final message = await inventario.createRegister(
                  reporte: reportService.reporte,
                  id: product.productos[0].productoAmbulancia[0].idProducambu,
                  cantidad: valor,
                  carga: inventoryForm.carga);
              NotificationService.showSnackBar(message);

              if (inventario.code != 200) {
                //await Future.delayed(Duration(milliseconds: 20));
                return;
              } else {
                cantController.clear();
                consumoContrller.clear();
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 80.0,
                vertical: 20.0,
              ),
              child: Container(
                child: Text("Guardar",
                    style: TextStyle(fontSize: 16.0, color: Colors.white)),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.red.withOpacity(0.8),
            onPressed: () async {
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 80.0,
                vertical: 20.0,
              ),
              child: Container(
                child: Text("Regresar",
                    style: TextStyle(fontSize: 16.0, color: Colors.white)),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildDecorationInput() {
    return BoxDecoration(
      color: Colors.black.withOpacity(0.10),
      borderRadius: BorderRadius.circular(10.0),
    );
  }
}

class IconsAdd extends StatefulWidget {
  @override
  State<IconsAdd> createState() => _IconsAddState();
}

class _IconsAddState extends State<IconsAdd> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            child: Form(
              child: TextFormField(
                enabled: false,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "$valor",
                    hintStyle: TextStyle(fontSize: 30.0)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //iconSize: 50.0,
              IconButton(
                  onPressed: () {
                    setState(() {
                      valor++;
                    });
                  },
                  icon: Icon(Icons.add_circle),
                  iconSize: 50.0),
              SizedBox(width: 70),
              IconButton(
                  onPressed: () {
                    if (valor == 0) {
                      return;
                    }
                    valor--;
                    setState(() {});
                  },
                  icon: Icon(Icons.remove_circle),
                  iconSize: 50.0)
            ],
          )
        ],
      ),
    );
  }
}
