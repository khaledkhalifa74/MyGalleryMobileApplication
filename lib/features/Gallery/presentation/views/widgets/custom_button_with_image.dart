import 'package:flutter/material.dart';
import 'package:my_gallery/core/utils/colors.dart';
import 'package:my_gallery/core/utils/styles.dart';

class CustomButtonWithImage extends StatelessWidget {
  const CustomButtonWithImage({
    super.key, required this.text, required this.image, this.width, this.height, this.onPressed,
  });
final String text;
final String image;
final double? width;
final double? height;
final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              vertical: 8,
            ),
          ),
          backgroundColor: MaterialStateProperty.all(kWhiteColor.withOpacity(0.5)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: height ?? 32,
              width: width ?? 32,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: Styles.textStyle18.copyWith(
                color: kBlackColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
