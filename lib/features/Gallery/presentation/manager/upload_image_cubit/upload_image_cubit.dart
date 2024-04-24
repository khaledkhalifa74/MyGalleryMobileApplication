import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery/core/utils/api_service.dart';
import 'package:my_gallery/features/Gallery/data/models/upload_image_model.dart';
import 'package:my_gallery/features/Gallery/presentation/manager/upload_image_cubit/upload_image_state.dart';
import 'package:my_gallery/core/utils/globals.dart' as globals;

class UploadImageCubit extends Cubit<UploadImageState>{
  UploadImageCubit() : super (UploadImageInitial());

  static UploadImageCubit get(context) => BlocProvider.of(context);
  UploadImageModel uploadImageModel = UploadImageModel();

  Future<void> uploadImage({required File imageFile}) async {
    emit(UploadImageLoading());
    try {
      Response response = await ApiService.postData(
        token: 'Bearer ${globals.token}',
        url: 'upload',
        data: {
          'img': await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
        },
      );
      if (response.statusCode == 200) {
        uploadImageModel = UploadImageModel.fromJson(response.data);
        emit(UploadImageSuccess(uploadImageModel));
      }else {
              // Image upload failed
              emit(UploadImageFailure(errorMessage: 'Image upload failed'));
            }
    }
    on Exception catch (e) {
      emit(UploadImageFailure(errorMessage: 'Something went wrong'));
    }
  }
}