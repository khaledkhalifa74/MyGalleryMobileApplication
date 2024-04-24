import 'dart:io';
import 'package:flutter/cupertino.dart';
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
import 'package:my_gallery/core/widgets/custom_loading_indicator.dart';
import 'package:my_gallery/features/Gallery/presentation/manager/get_my_gallery_cubit/get_my_gallery_cubit.dart';
import 'package:my_gallery/features/Gallery/presentation/manager/get_my_gallery_cubit/get_my_gallery_state.dart';
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
  late GetMyGalleryCubit _getMyGalleryCubit;
  List<String>? images;
  @override
  void initState() {
    _getMyGalleryCubit = context.read<GetMyGalleryCubit>();
    _getMyGalleryCubit.getMyGallery();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    return BlocConsumer<GetMyGalleryCubit,GetMyGalleryState>(
      listener: (context, state) {
        if (state is GetMyGalleryLoading) {
          isLoading = true;
        } else if (state is GetMyGallerySuccess) {
          images = state.getMyGalleryModel.data!.images;
          if (kDebugMode) {
            print(state.getMyGalleryModel.data!.images);
            print(images);
          }
          isLoading = false;
        } else if (state is GetMyGalleryFailure) {
          showCustomToast(fToast, state.errorMessage, true);
          isLoading = false;
        }
      },
      builder: (BuildContext context, GetMyGalleryState state)
      => BlocConsumer<UploadImageCubit,UploadImageState>(
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
          key: UniqueKey(),
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
                                onPressed: ()async{
                                  await customUploadDialog(
                                      context,
                                      onGalleryPressed: ()async{
                                        File? galleryImage = await pickImageFromGallery();
                                        if(galleryImage != null){
                                          Navigator.pop(context);
                                          await UploadImageCubit.get(context).uploadImage(imageFile: galleryImage);
                                          await _getMyGalleryCubit.getMyGallery();
                                        }
                                      },
                                      onCameraPressed: ()async{
                                        File? cameraImage = await pickImageFromCamera();
                                        if(cameraImage != null){
                                          Navigator.pop(context);
                                          await UploadImageCubit.get(context).uploadImage(imageFile: cameraImage);
                                          await _getMyGalleryCubit.getMyGallery();
                                        }
                                      },
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
                    child: isLoading ? const Center(child: CustomLoadingIndicator())
                        : GridView.builder(
                      itemCount: images?.length ?? 0,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 8,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.97,
                    ), itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        key: ValueKey<String>('grid_$index'),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            images![index],
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
      ),
    );
  }
}

