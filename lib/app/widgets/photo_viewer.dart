// First, add the following dependency to your pubspec.yaml file:
// photo_view: ^0.15.0
// Then run 'flutter pub get' to install it.

// Create a new file: lib/app/modules/common/widgets/full_screen_image_viewer.dart
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';


class FullScreenImageViewer extends StatelessWidget {
  final String imageUrl;
  final bool isAsset; // Optional: to handle asset images if needed

  const FullScreenImageViewer({
    super.key,
    required this.imageUrl,
    this.isAsset = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: PhotoView(
              imageProvider: isAsset ? AssetImage(imageUrl) : NetworkImage(imageUrl),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 4.0,
              heroAttributes: PhotoViewHeroAttributes(tag: imageUrl),
              loadingBuilder: (context, event) => Center(
                child: CircularProgressIndicator(
                  value: event == null ? 0 : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
                ),
              ),
            ),
          ),
          Positioned(
            top: 40.0,
            right: 20.0,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}