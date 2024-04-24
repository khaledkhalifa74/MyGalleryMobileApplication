import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_gallery/core/utils/assets.dart';
import 'package:my_gallery/core/utils/functions/custom_dialog.dart';
import 'package:my_gallery/core/utils/functions/custom_toast.dart';
import 'package:my_gallery/core/utils/functions/pick_image.dart';
import 'package:my_gallery/core/utils/globals.dart' as globals;
import 'package:my_gallery/core/utils/styles.dart';
import 'package:my_gallery/features/Gallery/presentation/manager/upload_image_cubit/upload_image_cubit.dart';
import 'package:my_gallery/features/Gallery/presentation/manager/upload_image_cubit/upload_image_state.dart';
import 'package:my_gallery/features/Gallery/presentation/views/widgets/custom_button_with_image.dart';

class GalleryViewBody extends StatefulWidget {
  const GalleryViewBody({super.key});

  @override
  State<GalleryViewBody> createState() => _GalleryViewBodyState();
}

class _GalleryViewBodyState extends State<GalleryViewBody> {
  FToast fToast = FToast();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    return BlocConsumer<UploadImageCubit,UploadImageState>(
      listener: (context, state) {
        if (state is UploadImageLoading) {
          isLoading = true;
        } else if (state is UploadImageSuccess) {
          showCustomToast(fToast, 'Image uploaded successfully', false);
          if (kDebugMode) {
            print(state.imageModel.message);
          }
          isLoading = false;
        } else if (state is UploadImageFailure) {
          showCustomToast(fToast, state.errorMessage, true);
          isLoading = false;
        }
      },
      builder: (BuildContext context, UploadImageState state)
      => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsData.galleryBGImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 32,
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Center(
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          'Welcome \n${globals.userData?.name ?? ''}',
                          style: Styles.textStyle26,
                        ),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButtonWithImage(
                              onPressed: (){
                                customLogOutDialog(context);
                              },
                              text: 'log out',
                              image: AssetsData.logoutIcon,
                            ),
                            CustomButtonWithImage(
                              onPressed: (){
                                customUploadDialog(
                                    context,
                                    onGalleryPressed: ()async{
                                File? galleryImage = await pickImageFromGallery();
                                if(galleryImage != null){
                                  UploadImageCubit.get(context).uploadImage(image: galleryImage);
                                   }
                                },
                                    onCameraPressed: ()async{
                                      File? cameraImage = await pickImageFromCamera();
                                      if(cameraImage != null){
                                        UploadImageCubit.get(context).uploadImage(image: cameraImage);
                                        Navigator.pop(context);
                                      }
                                    }
                                );
                              },
                              text: 'upload',
                              image: AssetsData.uploadIcon,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                child: GridView.builder(
                  itemCount: 20,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 8,
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.97,
                  ), itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

