import 'package:flutter/material.dart';

class DefaultText extends StatelessWidget {
  final double size;
  final String text;
  final FontWeight? weight;
  final Color? color;
  final TextAlign? align;
  final FontStyle? italic;

  const DefaultText( {
    Key? key,
    required this.size,
    required this.text,
    this.color,
    this.weight, this.align, this.italic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
        fontFamily: 'Poppins',
        fontStyle: italic
        
      ),
    );
  }
}
