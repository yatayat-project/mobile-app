import 'package:flutter/material.dart' show FormFieldState, Widget;
import 'package:flutter_form_builder/flutter_form_builder.dart'
    show FormBuilderField;

import 'input_field.dart' show InputField;

class FormFieldStateBuilder extends InputField {
  final String name;
  final String? Function(String?)? validator;
  final String? initialValue;
  final Widget Function(FormFieldState<String>) builder;
  final Function(String?)? onChanged;
  FormFieldStateBuilder({
    super.key,
    super.requiredColor,
    super.required,
    super.label,
    super.labelStyle,
    required this.name,
    this.validator,
    this.onChanged,
    this.initialValue,
    required this.builder,
  }) : super(
          child: FormBuilderField(
            builder: builder,
            name: name,
            validator: validator,
            initialValue: initialValue,
            onChanged: onChanged,
          ),
        );
}
