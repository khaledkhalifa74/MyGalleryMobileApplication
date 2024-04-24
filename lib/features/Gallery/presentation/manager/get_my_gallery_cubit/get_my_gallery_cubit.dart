import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery/core/utils/api_service.dart';
import 'package:my_gallery/features/Gallery/data/models/get_my_gallery_model.dart';
import 'package:my_gallery/features/Gallery/presentation/manager/get_my_gallery_cubit/get_my_gallery_state.dart';
import 'package:my_gallery/core/utils/globals.dart' as globals;


class GetMyGalleryCubit extends Cubit<GetMyGalleryState>{
  GetMyGalleryCubit() : super (GetMyGalleryInitial());

  static GetMyGalleryCubit get(context) => BlocProvider.of(context);

  Future<void> getMyGallery() async {
    emit(GetMyGalleryLoading());
    try {
      Response response = await ApiService.getData(
        token: 'Bearer ${globals.token}',
        url: 'my-gallery',
      );
      if (response.statusCode == 200) {
        GetMyGalleryModel getMyGalleryModel = GetMyGalleryModel.fromJson(response.data);
       // getMyGalleryModel.data.images;
          emit(GetMyGallerySuccess(getMyGalleryModel));
        }
      }
    on Exception catch (e) {
      emit(GetMyGalleryFailure(errorMessage: e.toString()));
    }
  }
}