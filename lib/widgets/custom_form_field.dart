import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final TextEditingController controller;
  bool isPassword = false;

  CustomFormField({
    Key? key,
    required this.controller,
    this.isPassword = false,
  }) : super(key: key);

  late final bool showIcon = isPassword;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword,
      style: const TextStyle(
        fontSize: 18.0,
      ),
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: widget.showIcon ? IconButton(
          icon: Icon(widget.isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined , color: widget.isPassword ? Colors.white : Colors.white70,),
          onPressed: (){
            setState(() {
              widget.isPassword = !widget.isPassword;
            });
          },
        ) : null,
        contentPadding: const EdgeInsets.only(left: 15, top: 10.0, bottom: 10.0),
        enabledBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderSide: const BorderSide(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}