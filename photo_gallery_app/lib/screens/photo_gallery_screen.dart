import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_gallery_app/keys.dart';
import 'package:photo_gallery_app/services/http_helper.dart';

class PhotoGalleryScreen extends StatefulWidget {
  const PhotoGalleryScreen({super.key});

  @override
  State<PhotoGalleryScreen> createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  Future<List<String>>? images;

  Future<List<String>> getimagesFromPixaby() async {
    List<String> pixabayImages = [];
    String url =
        "https://pixabay.com/api/?key=$pixbayKey&image_type=photo&per_page=20&category=nature&page=1";
    HttpHelper httpHelper = HttpHelper(url: url);
    Map<String, dynamic> data = await httpHelper.getData();

    for (var entity in data["hits"]) {
      pixabayImages.add(entity["largeImageURL"]);
    }

    return pixabayImages;
  }

  @override
  void initState() {
    images = getimagesFromPixaby();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(8),
        child: FutureBuilder<List<String>>(
          future: images,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(child: Text("Error"));
              case ConnectionState.waiting:
                return const Center(child: Text("Waiting"));
              case ConnectionState.active:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                return GridView.builder(
                    itemCount: snapshot.data?.length??0,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 6,
                            mainAxisSpacing: 6),
                    itemBuilder: (context, index) {
                      return Image.network(
                        snapshot.data![index]
                        ,
                        fit: BoxFit.cover,
                      );
                    });
            }
          },
        ),
      )),
    );
  }
}
