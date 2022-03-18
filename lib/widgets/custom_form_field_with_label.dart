import 'package:flutter/material.dart';

class CustomFormFieldWithLabel extends StatefulWidget {

  final String hintText;
  final TextEditingController controller;
  bool isPassword = false;

  CustomFormFieldWithLabel({
    Key? key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
  }) : super(key: key);

  late final bool showIcon = isPassword;

  @override
  State<CustomFormFieldWithLabel> createState() => _CustomFormFieldWithLabelState();
}

class _CustomFormFieldWithLabelState extends State<CustomFormFieldWithLabel> {
  @override
  Widget build(BuildContext context) {

    List<Widget> listWidgets = [
      Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20.0, bottom: 5.0),
            child: Text(
              widget.hintText,
              textAlign: TextAlign.left,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 24.0),
            ),
          )),
      TextFormField(
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
      ),
    ];

    return Column(
      children: listWidgets,
    );
  }
}