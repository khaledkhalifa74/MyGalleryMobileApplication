import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_gallery/core/utils/colors.dart';
import 'package:my_gallery/core/utils/styles.dart';

class CustomTextFormField extends StatelessWidget {
  final String? placeholder;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final bool? enabled;
  final int? maxLength;
  final bool? autoFocus;
  final void Function()? onTap;
  final String? validateMessage;
  final double? width;
  final double? height;
  final String? Function(String?)? validator;
  final bool? obscureText;
  const CustomTextFormField(
      {super.key,

        this.controller,
        this.autoFocus,
        this.placeholder,
        this.inputType,
        this.enabled,
        this.maxLength,
        this.onTap,
        this.validateMessage,
        this.width,
        this.height,
        this.validator,
        this.obscureText,
      });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height,
      child: TextFormField(
        obscureText: obscureText ?? false,
        onTap: onTap,
        controller: controller,
        enabled: enabled ?? true,
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        keyboardType: inputType,
        autofocus: autoFocus ?? false,
        validator: validator ?? (data) {
          if (data!.isEmpty) {
            return validateMessage;
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: Styles.textStyle16.copyWith(
            color: kTextFieldColor,
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(22)),
              borderSide: BorderSide.none,
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(22)),
              borderSide: BorderSide.none,
          ),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(22)),
              borderSide: BorderSide.none,
          ),
          disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(22)),
              borderSide: BorderSide.none,),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(22)),
              borderSide: BorderSide.none,),
          fillColor: kWhiteColor,
          contentPadding:
          const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        ),
      ),
    );
  }
}
