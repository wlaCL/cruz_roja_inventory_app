import 'package:app_sistema_invetnario/src/screens/screens.dart';
import 'package:app_sistema_invetnario/src/services/services.dart';
import 'package:app_sistema_invetnario/src/shares_preferences/preferences_user.dart';
import 'package:app_sistema_invetnario/src/theme/theme_changer.dart';
import 'package:app_sistema_invetnario/src/widgets/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: _DataProfileScreen(),
    );
  }
}

class _DataProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferencesUser();
    final authProvider = Provider.of<AuthService>(context);
    final appTheme = Provider.of<ThemeChanger>(context);
    final String? avatar =
        prefs.name.substring(0, 1) + prefs.lastName.substring(0, 1);
    final textStyle = TextStyle(
        fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            CircleAvatar(
              backgroundColor: Colors.red.withOpacity(0.8),
              child: Text(
                "${avatar}",
                style: TextStyle(fontSize: 50.0, color: Colors.white),
              ),
              radius: 50.0,
            ),
            SizedBox(
              height: 5.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "Nombre",
                    style: textStyle,
                  ),
                ),
                InputProfile(labelText: prefs.name),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "Apellido",
                    style: textStyle,
                  ),
                ),
                InputProfile(labelText: prefs.lastName),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SwitchListTile.adaptive(
                activeColor: Colors.indigo,
                value: appTheme.darkTheme,
                onChanged: (value) {
                  appTheme.darkTheme = true;
                },
                title: Text(
                  "Modo oscuro",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SwitchListTile.adaptive(
                activeColor: Colors.indigo,
                value: appTheme.customTheme,
                onChanged: (value) {
                  appTheme.customTheme = value;
                },
                title:
                    Text("Modo claro", style: TextStyle(color: Colors.black)),
              ),
            ),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                pushNewScreen(
                  context,
                  screen: ChangePassword(),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder())),
              child: Text("Cambiar contraseña",
                  style: TextStyle(fontSize: 16.0, color: Colors.indigo)),
            ),
          ],
        ),
      ),
    );
  }
}
