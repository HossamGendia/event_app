import 'package:event_app/modules/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_manager/color_pallete.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final Widget? prefixIcon;
  final String? hintText;
  final bool isPassword;
  final int? maxLines;
  final int? minLines;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    this.prefixIcon,
    this.hintText,
    this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.isPassword = false,
    this.maxLines = 1,
    this.minLines,
    this.validator,
    this.textStyle,
    this.hintStyle,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      controller: widget.controller,
      onChanged: widget.onChanged,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      obscureText: widget.isPassword ? obscureText : false,
      style: widget.textStyle,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Provider.of<SettingProvider>(context).isDark()
              ? Colors.white
              : AppColors.textFieldBorderColor,
        ),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Provider.of<SettingProvider>(context).isDark()
                      ? Colors.white
                      : AppColors.textFieldBorderColor,
                ),
              )
            : null,
        prefixIcon: widget.prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.textFieldBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.textFieldBorderColor,
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.textFieldBorderColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.textFieldBorderErrorColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
