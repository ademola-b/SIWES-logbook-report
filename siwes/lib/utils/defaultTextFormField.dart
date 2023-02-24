import 'package:flutter/material.dart';
import 'package:siwes/utils/constants.dart';

class DefaultTextFormField extends StatefulWidget {
  final String hintText;
  final double fontSize;
  final IconData? icon;
  final TextEditingController? text;
  // final Function onSaved;
  // final Function validator;
  final bool? obscureText, enabled;
  final int? maxLines;
  // final keyboardInputType;

  const DefaultTextFormField(
      {Key? key,
      required this.hintText,
      this.text,
      this.icon,
      // required this.onSaved,
      // required this.validator,
      // required this.keyboardInputType,
      this.maxLines,
      this.obscureText,
      required this.fontSize,
      this.enabled})
      : super(key: key);

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.text,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      // keyboardType: widget.keyboardInputType,
      // validator: (value) => widget.validator(value),
      // onSaved: (value) => widget.onSaved(value),
      decoration: InputDecoration(
        border: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.white)),
        enabledBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.white)),
        fillColor: Colors.white,
        filled: true,
        // prefixIcon: Icon(widget.icon),
        // prefixIconColor: Constants.primaryColor,
        hintText: widget.hintText,
      ),
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: widget.fontSize,
      ),
    );
  }
}
