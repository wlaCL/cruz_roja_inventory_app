import 'package:app_sistema_invetnario/src/UI/input_decoration_login.dart';
import 'package:app_sistema_invetnario/src/provider/auth_form_provider.dart';
import 'package:app_sistema_invetnario/src/services/auth_services.dart';
import 'package:app_sistema_invetnario/src/services/notification_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<AuthFormProvider>(context);
    const textStyle = TextStyle(color: Colors.black);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        width: double.infinity,
        //height: 200,
        decoration: buildDecorationCard(),
        child: Form(
          key: loginForm.formkey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Iniciar Sesión",
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: buildDecorationAuthInput(),
                  child: TextFormField(
                    autocorrect: false,
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    decoration: InputDecorationLogin.authInputDecoration(
                        icon: Icons.account_box, hintText: 'cédula'),
                    onChanged: (value) => loginForm.cedula = value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '          La cédula es obligatoria';
                      }
                      if (value.length < 10) {
                        return '          La cédula debe tener 10 dígitos';
                      }
                      final intNumber = int.tryParse(value);
                      if (intNumber == null) {
                        return '          Ingrese solo números';
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: buildDecorationAuthInput(),
                  child: TextFormField(
                    style: textStyle,
                    obscureText: true,
                    autocorrect: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecorationLogin.authInputDecoration(
                        icon: Icons.lock_outlined, hintText: 'Contraseña'),
                    onChanged: (value) => loginForm.password = value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '          La contraseña es obligatoria';
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 70.0,
              ),
              MaterialButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                disabledColor: Colors.grey,
                color: Colors.red,
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        final authService =
                            Provider.of<AuthService>(context, listen: false);
                        if (!loginForm.isValidForm()) return;
                        loginForm.isLoading = true;

                        final String? errorMessage = await authService
                            .loginUser(loginForm.cedula, loginForm.password);
                        await Future.delayed(Duration(seconds: 2));
                        if (errorMessage == null) {
                          Navigator.pushReplacementNamed(context, 'home');
                        } else {
                          NotificationService.showSnackBar(errorMessage);
                          loginForm.isLoading = false;
                        }
                      },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 20),
                  child: Container(
                    child: Text(
                      loginForm.isLoading ? 'Espere' : 'Ingresar',
                      style: TextStyle(
                          color:
                              loginForm.isLoading ? Colors.black : Colors.white,
                          fontSize: 16.0),
                    ),
                    //color: Colors.red,
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration buildDecorationAuthInput() {
    return BoxDecoration(
      color: Colors.black.withOpacity(0.05),
      borderRadius: BorderRadius.circular(25.0),
    );
  }

  BoxDecoration buildDecorationCard() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 5),
              blurRadius: 10.0,
            ),
          ]);
}
