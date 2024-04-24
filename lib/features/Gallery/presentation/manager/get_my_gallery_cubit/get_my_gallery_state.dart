import '../../../data/models/get_my_gallery_model.dart';

abstract class GetMyGalleryState{}

class GetMyGalleryInitial extends GetMyGalleryState{}

class GetMyGalleryLoading extends GetMyGalleryState{}

class GetMyGallerySuccess extends GetMyGalleryState{
  final GetMyGalleryModel getMyGalleryModel;

  GetMyGallerySuccess(this.getMyGalleryModel);
}

class GetMyGalleryFailure extends GetMyGalleryState{
  String errorMessage;
  GetMyGalleryFailure({required this.errorMessage});
}