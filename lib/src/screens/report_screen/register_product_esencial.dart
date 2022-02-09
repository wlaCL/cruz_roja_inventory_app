import 'package:app_sistema_invetnario/src/UI/ui.dart';
import 'package:app_sistema_invetnario/src/models/inventario_response.dart';
import 'package:app_sistema_invetnario/src/provider/provider.dart';
import 'package:app_sistema_invetnario/src/services/inventario_services.dart';
import 'package:app_sistema_invetnario/src/services/notification_service.dart';
import 'package:app_sistema_invetnario/src/services/report_services.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../scanner_screen.dart';

const valorDefault = 1;
int valor = valorDefault;

class RegisterProductEsencial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Producto product =
        ModalRoute.of(context)!.settings.arguments as Producto;
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de inventario"),
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
  final Producto product;
  const _FormRegisterInventory({required this.product});
  @override
  Widget build(BuildContext context) {
    final inventarioService = Provider.of<Inventario>(context).productos;
    final reportService = Provider.of<ReportService>(context);
    final inventoryFormEsencial = Provider.of<InventoryEsencialsForm>(context);
    final TextEditingController cantController = TextEditingController();
    final TextEditingController consumoContrller = TextEditingController();
    final textStyle = TextStyle(
        fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold);
    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: inventoryFormEsencial.formKey,
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
                      initialValue: inventarioService[0].nombre,
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
                      initialValue: inventarioService[0].categorium.nombre,
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
                      initialValue: inventarioService[0].tipo,
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
                    "Fecha de caducidad",
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
                      initialValue: '${product.fechaCaducidad}',
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
                      initialValue: '${product.productoAmbulancia[0].stock}',
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
                        inventoryFormEsencial.carga = value;
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
                (inventarioService[0].tipo == "Insumo Medico")
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

              if (!inventoryFormEsencial.isValidForm()) {
                return;
              }
              if (inventarioService[0].tipo == "Equipo") {
                valor = 0;
              }
              final message = await inventario.createRegister(
                  reporte: reportService.reporte,
                  id: product.productoAmbulancia[0].idProducambu,
                  cantidad: valor,
                  carga: inventoryFormEsencial.carga);
              NotificationService.showSnackBar(message);

              if (inventario.code != 200) {
                return;
              } else {
                cantController.clear();
                consumoContrller.clear();
                pushNewScreen(
                  context,
                  screen: ScanScanner(),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
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
            height: 100.0,
          )
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
