import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_sistema_invetnario/src/UI/ui.dart';
import 'package:app_sistema_invetnario/src/models/models.dart';
import 'package:app_sistema_invetnario/src/provider/provider.dart';
import 'package:app_sistema_invetnario/src/services/notification_service.dart';
import 'package:app_sistema_invetnario/src/services/register_product_service.dart';
import 'package:app_sistema_invetnario/src/widgets/widgets.dart';

class DataRegisterProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataProduct = Provider.of<RegisterProductServices>(context);
    return Scaffold(body: DataLoad(child: RegisterProduct()));
  }
}

class RegisterProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerProductServices =
        Provider.of<RegisterProductServices>(context);
    final registerForm = Provider.of<RegisterProductForm>(context);
    final textStyle = TextStyle(
        fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold);
    final _lista = ['Insumo Médico', "Equipo"];
    const edgeInsets = const EdgeInsets.symmetric(horizontal: 20.0);
    registerForm.categoria = registerProductServices.categoryID;
    registerForm.categoriaNombre = registerProductServices.categoryName;
    return Scaffold(
      appBar: AppBar(
        title: Text("Nuevo Producto"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: registerForm.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Ambulancia",
                      style: textStyle,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: DropdownButtonFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      isExpanded: true,
                      isDense: true,
                      items: registerProductServices.ambulancias
                          .map((Ambulancia ambulancia) {
                        return DropdownMenuItem(
                            value: '${ambulancia.placa}',
                            child: Text(
                              '${ambulancia.placa}',
                              style: TextStyle(color: Colors.black),
                            ));
                      }).toList(),
                      onChanged: (dynamic value) {
                        registerForm.ambulancia = value;
                      },
                      hint: Text("Selecciona la placa"),
                      validator: (value) {
                        if (value == null) {
                          return 'Es necesario una ambulancia';
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Tipo de producto",
                      style: textStyle,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: DropdownButtonFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      isExpanded: true,
                      isDense: true,
                      items: _lista.map((option) {
                        return DropdownMenuItem(
                            value: '${option}',
                            child: Text(
                              '${option}',
                              style: TextStyle(color: Colors.black),
                            ));
                      }).toList(),
                      onChanged: (dynamic value) {
                        registerForm.tipo = value;
                      },
                      hint: Text("Escoge el tipo de producto"),
                      validator: (value) {
                        if (value == null) {
                          return 'Es necesario una ambulancia';
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Categoria",
                      style: textStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 10.0),
                      decoration: _buildDecorationInput(),
                      child: TextFormField(
                        initialValue: (registerForm.categoriaNombre == "Varios")
                            ? "Varios"
                            : "No hay categoría registrada",
                        enabled: false,
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        decoration: InputDecorationForm.formInputDecoration(
                            labelText: ""),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Nombre del producto",
                      style: textStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 10.0),
                      decoration: _buildDecorationInput(),
                      child: TextFormField(
                        autofocus: false,
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        decoration: InputDecorationForm.formInputDecoration(
                          labelText: "",
                        ),
                        onChanged: (value) => registerForm.nombre = value,
                        validator: (dynamic value) {
                          if (value!.isEmpty) {
                            return 'El nombre es obligatorio';
                          }
                          if (value.length < 3) {
                            return 'El nombre de contener más de tres caracteres';
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Cantidad",
                      style: textStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 10.0),
                      decoration: _buildDecorationInput(),
                      child: TextFormField(
                        autofocus: false,
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        decoration: InputDecorationForm.formInputDecoration(
                          labelText: "",
                        ),
                        onChanged: (value) => registerForm.cantidad = value,
                        validator: (dynamic value) {
                          if (value!.isEmpty) {
                            return 'La cantidad es obligatoria';
                          }
                          if (int.tryParse(value) == null) {
                            return 'La cantidad debe ser un número entero';
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Colors.red.withOpacity(0.8),
              onPressed: () async {
                FocusScope.of(context).unfocus();
                final register = Provider.of<RegisterProductServices>(context,
                    listen: false);
                if (!registerForm.isValidForm()) {
                  NotificationService.showSnackBar("Completa los campos");
                  return;
                }
                if (registerProductServices.categoryName != "Varios") {
                  NotificationService.showSnackBar(
                      "No existe categoría válida");
                  return;
                }
                String respuesta = await register.createProduct(
                    registerProductServices.categoryID,
                    registerForm.nombre.toUpperCase(),
                    registerForm.ambulancia,
                    //_myService.valor.toString(),
                    registerForm
                        .cantidad, // aqui se debe enviar el valor de cantidad
                    registerForm.tipo);
                NotificationService.showSnackBar(respuesta);
                // await Future.delayed(Duration(milliseconds: 500));

                if (register.code == 200) {
                  registerForm.formKey.currentState!.reset();
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 80.0,
                  vertical: 20.0,
                ),
                child: Container(
                  child: const Text("Guardar",
                      style: TextStyle(fontSize: 16.0, color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(
              height: 150,
            ),
          ],
        ),
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
