import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final bool obscureText;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final Color? borderColor;
  final Function(String)? onChanged;
  final String? initialValue;
  final dynamic validator;
  final bool isPassword;
  final Icon? suffixIcon;
  final bool? isDense;
  final bool? readOnly;
  final Function()? onTap;
  const PrimaryTextField({
    Key? key,
    this.textEditingController,
    this.obscureText = false,
    this.hintText,
    this.hintStyle,
    this.prefixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.fillColor,
    this.borderColor,
    this.onChanged,
    this.initialValue,
    this.validator,
    this.readOnly = false,
    this.isPassword = false,
    this.isDense = true,
    this.onTap,
    this.suffixIcon,
  }) : super(key: key);

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.borderColor ?? const Color(0xFFE5E5E5),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextFormField(
        controller: widget.textEditingController,
        obscureText: (widget.obscureText && _obscureText),
        keyboardType: widget.keyboardType ?? TextInputType.text,
        inputFormatters: widget.inputFormatters,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        initialValue: widget.initialValue,
        validator: widget.validator,
        readOnly: widget.readOnly ?? false,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          // label: Text(widget.hintText ?? ''),
          errorStyle: const TextStyle(fontSize: 10),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.remove_red_eye : Icons.visibility_off_outlined,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : widget.suffixIcon,
          suffixIconConstraints: (widget.isDense != null) ? const BoxConstraints(maxHeight: 33) : null,
          // filled: true,
          hintText: widget.hintText ?? '',
          hintStyle: widget.hintStyle ??
              const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
          prefixIcon: widget.prefixIcon,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
