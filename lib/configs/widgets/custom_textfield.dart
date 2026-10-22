import 'package:flutter/material.dart';
import 'package:flutter_provider_straterkit/configs/res/color.dart';
import 'package:flutter_provider_straterkit/configs/res/text_styles.dart';

class CustomTextFormField extends StatefulWidget {
  final String? titleText;
  final String? requiredStar;
  final String placeholder;
  final double? height;
  final TextEditingController controller;
  final FocusNode? focusCurrent;
  final FocusNode? focusNext;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;

  const CustomTextFormField({
    super.key,
    this.titleText,
    this.requiredStar,
    required this.placeholder,
    this.height,
    required this.controller,
    this.focusCurrent,
    this.focusNext,
    this.validator,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.titleText != null && widget.titleText!.isNotEmpty) ...[
          Text(
            widget.titleText!,
            style: AppTextStyles.textSize18(context, weight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          width: screenWidth * 0.9,
          height: widget.height ?? 42,
          decoration: BoxDecoration(
            color: AppColors.textFieldFill(context),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1, color: AppColors.border(context)),
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focusCurrent,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            obscureText: widget.obscureText,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            style: AppTextStyles.textSize16(context, weight: FontWeight.w400),
            decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: AppTextStyles.textSize16(
                context,
                color: AppColors.hintColor(context),
                weight: FontWeight.w400,
              ),
              border: OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
            ),
            validator: widget.validator,
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }
}
