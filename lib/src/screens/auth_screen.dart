import 'package:app_sistema_invetnario/src/screens/screens.dart';
import 'package:app_sistema_invetnario/src/services/services.dart';
import 'package:app_sistema_invetnario/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScren extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: FutureBuilder(
        future: authService.isAuthenticated(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) {
            return LoadingScreeen();
          }

          if (snapshot.data == '') {
            Future.microtask(
              () => {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => LoginScreen(),
                      transitionDuration: Duration(seconds: 0),
                    )),
              },
            );
          } else {
            Future.microtask(
              () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => HomeScreen(),
                    transitionDuration: Duration(seconds: 0),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
