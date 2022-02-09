import 'package:flutter/material.dart';
import 'package:app_sistema_invetnario/src/UI/ui.dart';

class InputProfile extends StatelessWidget {
  final String labelText;
  final IconData? icon;
  InputProfile({required this.labelText, this.icon});
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
            padding: EdgeInsets.only(left: 1.0),
            decoration: _buildDecorationInput(),
            child: TextFormField(
              enabled: false,
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
