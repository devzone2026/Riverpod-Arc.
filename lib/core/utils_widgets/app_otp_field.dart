
import 'package:flutter/material.dart';
import '../utils/app_text_styles.dart';

const Color primary = Color(0xFF1F4B4B);
const Color accent = Color(0xFFF5A623);
const Color border = Color(0xFFE0E3E5);
const Color textPrimary = Color(0xFF1A1A1A);


class OtpDigitField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isFilled;
  final bool isActive;
  final ValueChanged<String> onChanged;

  const OtpDigitField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    this.isFilled = false,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 56,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: AppTextStyles.heading.copyWith(color: isFilled ? Colors.white : textPrimary),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: isFilled ? accent : Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: isActive ? primary : border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: isFilled ? accent : border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primary, width: 1.4),
          ),
        ),
      ),
    );
  }
}