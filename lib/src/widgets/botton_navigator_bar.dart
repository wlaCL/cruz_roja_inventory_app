import 'package:app_sistema_invetnario/src/provider/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtomNavigatorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiprovider = Provider.of<UiProvider>(context);
    final currenIndex = uiprovider.selectMenuOpt;
    return BottomNavigationBar(
      onTap: (int i) => {uiprovider.selectMenuOpt = i},
      currentIndex: currenIndex,
      elevation: 10,
      selectedItemColor: Colors.red.withOpacity(0.7),
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          label: 'perfil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.medication),
          label: 'producto',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.feed_rounded), label: "Reporte"),
      ],
    );
  }
}
