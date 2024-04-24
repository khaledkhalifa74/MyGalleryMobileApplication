// class GetMyGalleryModel {
//   String? status;
//   Data? data;
//   String? message;
//
//   GetMyGalleryModel({this.status, this.data, this.message});
//
//   GetMyGalleryModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['message'] = message;
//     return data;
//   }
// }
//
// class Data {
//   List<Null>? images;
//
//   Data({this.images});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['images'] != null) {
//       images = <Null>[];
//       json['images'].forEach((v) {
//         images!.add(Null.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (images != null) {
//       data['images'] = images!.map((v) => v!.toJson()).toList();
//     }
//     return data;
//   }
// }
