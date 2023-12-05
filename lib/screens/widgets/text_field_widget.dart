// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    this.validator,
    this.onChanged,
    this.controller,
    this.borderRadius,
    this.obscureText,
    this.keyboardType,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final double? borderRadius;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? label;
  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.all(10),
          isDense: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 15))),
    );
  }
}

class DropDownWidget<T> extends StatelessWidget {
  const DropDownWidget({
    Key? key,
    this.validator,
    this.onChanged,
    this.controller,
    this.borderRadius,
    this.obscureText,
    this.keyboardType,
    this.label,
    this.hint,
    this.value,
    this.prefixIcon,
    this.suffixIcon,
    required this.items
  }) : super(key: key);
  final FormFieldValidator<T?>? validator;
  final ValueChanged<T?>? onChanged;
  final TextEditingController? controller;
  final double? borderRadius;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? label;
  final String? hint;
  final T? value;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final List<DropdownMenuItem<T?>>? items;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T?>(
        onChanged: onChanged,
        validator: validator,
        value:value ,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.all(10),
            isDense: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 15))),
        items: items);
  }
}
