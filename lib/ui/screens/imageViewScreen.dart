import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
class ImageViewScreen extends StatefulWidget {
  final String? imageUrl;
  final int? id;

  const ImageViewScreen(this.imageUrl,this.id ,{Key? key}) : super(key: key);

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () async {
              await GallerySaver.saveImage(widget.imageUrl ?? "");
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Image Saved"),
              ));
            },
          ),
        ],
      ),
      body: Hero(
        transitionOnUserGestures: true,
        tag: widget.id! ,
        child: Center(
          child: Image.network(widget.imageUrl ?? ''),
        ),
      ),
    );
  }
}
