import 'package:flutter/material.dart';
import 'package:my_gallery/core/utils/colors.dart';
import 'package:my_gallery/core/utils/styles.dart';
import 'package:my_gallery/features/Authentication/presentation/views/login_view.dart';

Future<dynamic> customLogOutDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: kWhiteColor,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      backgroundColor: Colors.white.withOpacity(0.7),
      title: Text(
        'Confirm',
        style: Styles.textStyle18.copyWith(
          color: kBlackColor
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        'Are you sure to logout',
        style: Styles.textStyle16.copyWith(
          color: kBlackColor,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: ShapeDecoration(
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    )),
                child: TextButton(
                  child: Text(
                    'Yes',
                    style: Styles.textStyle14,
                  ),
                  onPressed: () {
                   Navigator.pushNamedAndRemoveUntil(context, LoginView.id, (route) => false);
                  },
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  color: kPrimaryColor,
                ),
                child: TextButton(
                  child: Text(
                    'No',
                    style: Styles.textStyle14,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Future<dynamic> customUploadDialog(BuildContext context ,{void Function()? onGalleryPressed, void Function()? onCameraPressed}){
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: kWhiteColor,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      backgroundColor: Colors.white.withOpacity(0.7),
      actions: [
        Center(
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                  ),
                  onPressed: onGalleryPressed,
                  child: Text(
                    'Gallery',
                    style: Styles.textStyle14,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(kSecondColor),
                  ),
                  onPressed: onCameraPressed,
                  child: Text(
                    'Camera',
                    style: Styles.textStyle14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}