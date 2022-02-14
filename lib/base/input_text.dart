import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media/base/colors.dart';

class InputText extends StatefulWidget {
  final TextEditingController? controller;
  final Widget? iconPrefix;
  final Widget? iconSufix;
  final String hintText;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final EdgeInsets? padding;
  InputText(
      {Key? key,
      this.controller,
      this.iconPrefix,
      this.iconSufix,
      this.textInputType,
      this.inputFormatters,
      this.obscureText = false,
      required this.hintText,
      this.textInputAction = TextInputAction.next,
      this.padding,
      this.validator})
      : super(key: key);

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      keyboardType: widget.textInputType,
      inputFormatters: widget.inputFormatters,
      obscureText: widget.obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: widget.iconPrefix,
          fillColor: Colors.white,
          // labelStyle: TextStyle(color: AppColors.bottomNavColor),
          filled: true,
          // labelText: widget.hintText,
          suffixIcon: widget.iconSufix,
          contentPadding: widget.padding,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.red, width: 2)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.red)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: AppColors.activeColor))),
    );
  }
}
