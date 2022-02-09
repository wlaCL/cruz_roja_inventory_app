import 'package:app_sistema_invetnario/src/provider/auth_form_provider.dart';
import 'package:app_sistema_invetnario/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: AuthBackground(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: size.height * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0),
                    ),
                  ),
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: _LogoCruzRoja(),
                    ),
                    SizedBox(height: 70),
                    ChangeNotifierProvider(
                        create: (_) => AuthFormProvider(), child: CardLogin()),
                    SizedBox(height: 100),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoCruzRoja extends StatelessWidget {
  const _LogoCruzRoja({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/auth_cruz_roja.png', width: 60.0, height: 70.0),
        SizedBox(
          width: 10.0,
        ),
        Text(
          "Cruz Roja Ecuatoriana",
          style: TextStyle(
              fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),
        )
      ],
    );
  }
}
