import 'package:flutter/cupertino.dart';
import 'package:photo_gallery_app/services/http_helper.dart';
import 'package:photo_gallery_app/keys.dart';

class GalleryData extends ChangeNotifier {
  List<String> _images = [];
  List<String> get images => [..._images];
  int get ImagesCount => _images.length;

  Future<void> getimagesFromPixaby() async {
    List<String> pixabayImages = [];
    String url =
        "https://pixabay.com/api/?key=$pixbayKey&image_type=photo&per_page=20&category=nature&page=1";
    HttpHelper httpHelper = HttpHelper(url: url);
    Map<String, dynamic> data = await httpHelper.getData();

    for (var entity in data["hits"]) {
      pixabayImages.add(entity["largeImageURL"]);
    }

    _images = pixabayImages;
    notifyListeners();
  }
}
