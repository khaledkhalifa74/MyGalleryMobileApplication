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

  Future<void> uploadImage({required File image}) async {
    emit(UploadImageLoading());
    try {
      Response response = await ApiService.postData(
        token: globals.token,
        contentType: 'application/json',
        url: 'upload',
        data: {
          'img': image,
        },
      );
      if (response.statusCode == 200) {
        uploadImageModel = UploadImageModel.fromJson(response.data);
        emit(UploadImageSuccess(uploadImageModel));
      }
    }
    on Exception catch (e) {
      emit(UploadImageFailure(errorMessage: uploadImageModel.errors?.img?[0] ?? 'Something went wrong'));
    }
  }
}