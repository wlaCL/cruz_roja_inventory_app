import 'package:app_sistema_invetnario/src/UI/ui.dart';
import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  final String labelText;
  final IconData? icon;
  InputForm({required this.labelText, this.icon});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              decoration: InputDecorationGlobal.formInputDecoration(
                labelText: labelText,
                icon: icon,
              ),
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration _buildDecorationInput() {
    return BoxDecoration(
      color: Colors.black.withOpacity(0.10),
      borderRadius: BorderRadius.circular(25.0),
    );
  }
}
