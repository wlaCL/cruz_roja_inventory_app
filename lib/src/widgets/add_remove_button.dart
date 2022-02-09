import 'package:app_sistema_invetnario/src/utils/count_controller.dart';
import 'package:flutter/material.dart';

class IconsAdd extends StatefulWidget {
  @override
  State<IconsAdd> createState() => _IconsAddState();
}

class _IconsAddState extends State<IconsAdd> {
  @override
  Widget build(BuildContext context) {
    CountService _myService = CountService();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            child: TextFormField(
              enabled: false,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "${_myService.valor}",
                  hintStyle: TextStyle(fontSize: 30.0)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //iconSize: 50.0,
              IconButton(
                  onPressed: () {
                    setState(() {
                      _myService.incrementValor();
                    });
                  },
                  icon: Icon(Icons.add_circle),
                  iconSize: 50.0),
              SizedBox(width: 70),
              IconButton(
                  onPressed: () {
                    if (_myService.valor == 1) {
                      return;
                    }

                    setState(() {
                      _myService.decreaseValor();
                    });
                  },
                  icon: Icon(Icons.remove_circle),
                  iconSize: 50.0)
            ],
          )
        ],
      ),
    );
  }
}
