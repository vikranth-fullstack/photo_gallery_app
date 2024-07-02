import 'package:flutter/material.dart';
import 'package:photo_gallery_app/provider/gallery_data.dart';
import 'package:provider/provider.dart';

class PhotoGalleryScreen extends StatelessWidget {
  const PhotoGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GalleryData galleryData = context.watch<GalleryData>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: GridView.builder(
              itemCount: context.watch<GalleryData>().ImagesCount,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 6, mainAxisSpacing: 6),
              itemBuilder: (context, index) {
                return Image.network(
                  galleryData.images[index],
                  fit: BoxFit.cover,
                );
              }),
        ),
      ),
    );
  }
}
