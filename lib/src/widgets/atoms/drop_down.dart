import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart'
    show
        ButtonStyleData,
        DropdownButtonFormField2,
        DropdownStyleData,
        IconStyleData;
import 'package:easy_localization/easy_localization.dart' show tr;
import 'package:flutter/material.dart'
    show
        BorderRadius,
        BoxDecoration,
        Colors,
        DropdownMenuItem,
        EdgeInsets,
        Icon,
        Icons,
        InputDecoration,
        Text;

import '../../config/themes/colors.dart' show AppColors;
import '../../core/extensions/context.dart';
import '../../core/utils/constants.dart';
import '../../models/drop_down/index.dart';
import 'form_field_builder.dart';

class DropDown<T extends String> extends FormFieldStateBuilder {
  final List<DropDownList> items;
  final String hintText;
  final double? maxHeight;
  @override
  final bool enabled;

  DropDown({
    super.key,
    required this.items,
    required super.name,
    super.required,
    super.label,
    super.labelStyle,
    super.requiredColor = AppColors.error,
    super.initialValue,
    super.validator,
    super.onChanged,
    this.hintText = "",
    this.enabled = true,
    this.maxHeight,
    Offset offset = const Offset(0, 0),
  }) : super(
          builder: (field) {
            return DropdownButtonFormField2(
              decoration: InputDecoration(
                fillColor: enabled ? null : AppColors.greyLight,
                contentPadding: EdgeInsets.zero,
              ),
              items: items
                  .map(
                    (item) => DropdownMenuItem<T>(
                      value: item.value as T,
                      child: Text(
                        tr(item.label),
                        style: currentContext.bodySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              value: field.value,
              onChanged: !enabled ? null : field.didChange,
              hint: Text(
                hintText,
                style: currentContext.bodySmall!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                  fontSize: 14,
                ),
              ),
              buttonStyleData: const ButtonStyleData(
                height: 40,
                padding: EdgeInsets.only(right: 12),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.black54,
                  size: 22,
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: maxHeight ?? currentContext.height / 2.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.primary.shade50,
                ),
                offset: offset,
              ),
              validator: validator,
            );
          },
        );
}
