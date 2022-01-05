import 'package:flutter/material.dart';
import 'package:taskkey/ui/size_config.dart';
import 'package:taskkey/ui/theme.dart';

/// Universal Widget za vse Gumbe
class MyButton extends StatelessWidget {
  final Function onTap;
  //final Function()? onTap;
  final String label;

  MyButton({
     this.onTap, //clickavle funct
     this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // GestureDetector za clickable object lahka bi dal tt ink
      onTap: onTap,
      child: Container( // kontejner
        height: 50,
        width: 130,
        decoration: BoxDecoration( //boxdecoration radizs beterr da si na sred
          color: primaryClr,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
