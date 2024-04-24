import 'package:flutter/material.dart';
import 'package:my_gallery/features/Gallery/presentation/views/widgets/gallery_view_body.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({super.key});
  static String id = "GalleryView";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GalleryViewBody(),
    );
  }
}
