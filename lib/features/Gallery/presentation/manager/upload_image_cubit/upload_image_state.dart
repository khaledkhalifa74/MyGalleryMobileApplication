import 'package:my_gallery/features/Gallery/data/models/upload_image_model.dart';

abstract class UploadImageState{}

class UploadImageInitial extends UploadImageState{}

class UploadImageLoading extends UploadImageState{}

class UploadImageSuccess extends UploadImageState{
  final UploadImageModel imageModel;

  UploadImageSuccess(this.imageModel);
}

class UploadImageFailure extends UploadImageState{
  String errorMessage;
  UploadImageFailure({required this.errorMessage});
}