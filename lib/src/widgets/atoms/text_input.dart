import 'package:flutter/material.dart'
    show
        AutovalidateMode,
        BoxConstraints,
        BuildContext,
        Colors,
        EdgeInsets,
        EdgeInsetsGeometry,
        FormFieldValidator,
        Icon,
        IconButton,
        Icons,
        InputBorder,
        InputDecoration,
        Key,
        State,
        StatefulWidget,
        TextAlign,
        TextAlignVertical,
        TextInputType,
        TextStyle,
        Theme,
        ValueChanged,
        Widget;
import 'package:flutter_form_builder/flutter_form_builder.dart'
    show FormBuilderTextField;

import '../../config/themes/colors.dart';
import 'input_field.dart';

class TextInput extends StatefulWidget {
  final TextAlign textAlign;
  final String name;
  final ValueChanged<String?>? onChanged;
  final String? label;
  final String? hintText;
  final bool required;
  final bool enabled;
  final int? maxLength;
  final int? maxLines;
  final bool? showCounter;
  final bool obscureText;
  final Widget? suffix;
  final TextStyle? style;
  final BoxConstraints? suffixIconConstraints;

  final Widget? prefix;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;

  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextAlignVertical? textAlignVertical;

  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final EdgeInsetsGeometry? contentPadding;
  final AutovalidateMode autovalidateMode;
  final String? initialValue;

  const TextInput({
    Key? key,
    required this.name,
    this.label,
    this.onChanged,
    this.hintText,
    this.required = false,
    this.maxLength,
    this.maxLines = 1,
    this.showCounter,
    this.validator,
    this.obscureText = false,
    this.style,
    this.enabled = true,
    this.labelStyle,
    this.keyboardType,
    this.initialValue,
    this.suffix,
    this.textAlignVertical,
    this.suffixIconConstraints,
    this.prefix,
    this.prefixIconConstraints,
    this.border,
    this.enabledBorder,
    this.disabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.textAlign = TextAlign.start,
    this.hintStyle,
    this.prefixIcon,
    this.contentPadding,
    this.autovalidateMode = AutovalidateMode.disabled,
  }) : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool _secureText = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _secureText = widget.obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InputField(
      label: widget.label,
      required: widget.required,
      enabled: widget.enabled,
      labelStyle: widget.labelStyle,
      child: FormBuilderTextField(
        key: widget.key,
        autovalidateMode: widget.autovalidateMode,
        textAlignVertical: widget.textAlignVertical,
        name: widget.name,
        initialValue: widget.initialValue,
        textAlign: widget.textAlign,
        keyboardType: widget.keyboardType,
        style: widget.style ??
            Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 14,
                ),
        obscureText: _secureText,
        onChanged: widget.onChanged,
        validator: widget.validator,
        maxLength: widget.maxLength,
        maxLines: widget.obscureText ? 1 : widget.maxLines,
        enabled: widget.enabled,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          border: widget.border,
          enabledBorder: widget.enabledBorder,
          disabledBorder: widget.disabledBorder,
          focusedBorder: widget.focusedBorder,
          errorBorder: widget.errorBorder,
          focusedErrorBorder: widget.focusedErrorBorder,
          enabled: widget.enabled,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          counterText: widget.showCounter == false ? "" : null,
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          prefixIcon: widget.prefixIcon,
          prefix: widget.prefix,
          prefixIconConstraints: widget.prefixIconConstraints,
          suffixIcon: widget.obscureText == true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _secureText = !_secureText;
                    });
                  },
                  icon: Icon(
                    _secureText == true
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.greyDark,
                  ),
                )
              : widget.suffix,
          suffixIconConstraints: widget.suffixIconConstraints,
        ),
      ),
    );
  }
}
