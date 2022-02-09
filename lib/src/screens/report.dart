import 'package:app_sistema_invetnario/src/screens/report_screen/search_turn.dart';
import 'package:app_sistema_invetnario/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DataLoad(
        child: SearchTurn(),
      ),
    );
  }
}
