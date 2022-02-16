import 'package:app_sistema_invetnario/src/UI/ui.dart';
import 'package:app_sistema_invetnario/src/provider/password_form_provider.dart';
import 'package:app_sistema_invetnario/src/services/security_service.dart';
import 'package:app_sistema_invetnario/src/services/services.dart';
import 'package:app_sistema_invetnario/src/theme/theme_changer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cambio de contraseña"),
      ),
      body: ChangeNotifierProvider(
        create: (_) => PasswordForm(),
        child: Container(
          child: _FormChangePassword(),
        ),
      ),
    );
  }
}

class _FormChangePassword extends StatelessWidget {
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllernewPassword = TextEditingController();
  final TextEditingController controllerRepeatPassword =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
        fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold);
    final passwordForm = Provider.of<PasswordForm>(context);
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: passwordForm.formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "Contraseña Actual",
                    style: textStyle,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 10.0),
                    decoration: _buildDecorationInput(),
                    child: TextFormField(
                      obscureText: false,
                      autofocus: false,
                      controller: controllerPassword,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecorationGlobal.formInputDecoration(
                          labelText: "        * * * * * * * * * * * * *",
                          icon: Icons.lock),
                      onChanged: (value) => passwordForm.password = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '          La contraseña es obligatoria';
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    "Nueva contraseña",
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
                      obscureText: false,
                      autofocus: false,
                      controller: controllernewPassword,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecorationGlobal.formInputDecoration(
                          labelText: "        * * * * * * * * * * * * *",
                          icon: Icons.lock),
                      onChanged: (value) => passwordForm.newPassword = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '          La contraseña es obligatoria';
                        }
                        if (value.length < 10) {
                          return '          La contraseña debe tener almenos 10 caracteres';
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    "Repite la Nueva Contraseña",
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
                      obscureText: false,
                      autofocus: false,
                      controller: controllerRepeatPassword,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecorationGlobal.formInputDecoration(
                          labelText: "      * * * * * * * * * * * * *",
                          icon: Icons.lock),
                      onChanged: (value) =>
                          passwordForm.confirmPassword = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '          La contraseña es obligatoria';
                        }
                        if (value.length < 10) {
                          return '          La contraseña debe tener almenos 10 caracteres';
                        }
                        if (passwordForm.confirmPassword !=
                            passwordForm.newPassword) {
                          return '          Las contraseñas no coinciden';
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            MaterialButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (!passwordForm.isValidForm()) {
                  NotificationService.showSnackBar(
                      "Los campos son obligatorios");
                  return;
                }
                _showAlertChangePassword(context);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              disabledColor: Colors.grey,
              color: Colors.red.withOpacity(0.8),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                child: Container(
                  child: Text(
                    "Actualizar contraseña",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
              ),
            )
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

  _showAlertChangePassword(context) {
    final passwordForm = Provider.of<PasswordForm>(context, listen: false);
    final theme = Provider.of<ThemeChanger>(context, listen: false).darkTheme;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          const textStyle = TextStyle(color: Colors.black);
          return AlertDialog(
            title: Text(
              "Cambio de contraseña",
              style: textStyle,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(
                    "¿Está seguro de cambiar la contraseña?",
                    style: textStyle,
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                    final securityService =
                        Provider.of<SecurityService>(context, listen: false);
                    final respuesta = await securityService.changePassword(
                        passwordForm.password, passwordForm.newPassword);
                    if (securityService.code == 200) {
                      NotificationService.showSnackBar(respuesta);
                      controllerPassword.clear();
                      controllernewPassword.clear();
                      controllerRepeatPassword.clear();
                    }
                    NotificationService.showSnackBar(respuesta);
                  },
                  child: Text(
                    "Si",
                    style: TextStyle(color: Colors.indigo),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "No",
                    style: TextStyle(color: Colors.indigo),
                  ))
            ],
          );
        });
  }
}
