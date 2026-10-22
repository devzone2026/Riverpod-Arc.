import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_text_styles.dart';
import 'app_text.dart';

const Color primary = Color(0xFF1F4B4B);
const Color accent = Color(0xFFF5A623);
const Color border = Color(0xFFE0E3E5);
const Color textPrimary = Color(0xFF1A1A1A);

class AppTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggleObscure;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final AutovalidateMode autoValidateMode;
  final double? containerHeight;
  final bool readOnly;
  final Function? onTap;

  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.isPassword = false,
    this.obscureText = false,
    this.onToggleObscure,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines = 1,
    this.onChanged,
    this.validator,
    this.focusNode,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.containerHeight,
    this.readOnly = false,
    this.onTap,
  });

  @override
  AppTextFieldState createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  String? errorText;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      validate(widget.controller?.text);
    }
  }

  @override
  void dispose() {
    // Only dispose if we created it internally
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  bool validate([String? value]) {
    if (widget.validator != null) {
      final result = widget.validator!(value ?? widget.controller?.text);
      if (mounted) {
        setState(() => errorText = result);
      }
      return result == null || result.isEmpty;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[AppText.label(widget.label!), 2.verticalSpace],
        SizedBox(
          height: widget.containerHeight ?? 38.h,
          child: TextFormField(
            readOnly: widget.readOnly,
            controller: widget.controller,
            focusNode: _focusNode,
            obscureText: widget.isPassword ? widget.obscureText : false,
            keyboardType: widget.keyboardType,
            maxLines: widget.isPassword ? 1 : widget.maxLines,
            autovalidateMode: widget.autoValidateMode,
            style: AppTextStyles.body,
            onChanged: (value) {
              validate(value);
              widget.onChanged?.call(value);
            },
            onTap: () => widget.onTap?.call(),
            validator: (value) {
              final result = widget.validator?.call(value);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() => errorText = result);
                }
              });
              return result;
            },
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTextStyles.body.copyWith(color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: widget.prefixIcon,
              suffixIcon: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ?widget.isPassword
                      ? IconButton(
                          padding: EdgeInsets.zero,
                          style: ButtonStyle(
                            visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                            padding: WidgetStatePropertyAll(EdgeInsets.zero),
                          ),
                          icon: Icon(
                            widget.obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            size: 20,
                            color: Colors.white70,
                          ),
                          onPressed: widget.onToggleObscure,
                        )
                      : widget.suffixIcon,

                  if (errorText != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Tooltip(
                        triggerMode: TooltipTriggerMode.tap,
                        message: errorText,
                        child: Icon(Icons.error_outlined, size: 18, color: Colors.red),
                      ),
                    ),
                ],
              ),

              errorStyle: const TextStyle(fontSize: 0, height: 0),
              contentPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: primary.withValues(alpha: .7), width: 1.4),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 1.4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
