import 'package:flutter/material.dart';
import 'package:my_gallery/core/utils/colors.dart';
import 'package:my_gallery/core/utils/styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback itemCallBack;
  final double? height;
  final double? width;

  const CustomButton({
    super.key,
    required this.text,
    required this.itemCallBack,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed:
        itemCallBack,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              vertical: 15,
            ),
          ),
          backgroundColor: MaterialStateProperty.all(kButtonColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: Styles.textStyle18,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}