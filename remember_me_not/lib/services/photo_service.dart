import 'package:flutter/material.dart';
import '../models/tagged_photo.dart';

class PhotoService extends ChangeNotifier {
  static final PhotoService instance = PhotoService._internal();

  PhotoService._internal();

  final List<TaggedPhoto> _photos = [
    // Pre-populate with 2 default photos so the dashboard isn't completely empty
    TaggedPhoto(
      id: '1',
      imageUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
      tag: 'Daughter, Sarah',
    ),
    TaggedPhoto(
      id: '2',
      imageUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
      tag: 'Son, Michael',
    ),
  ];

  List<TaggedPhoto> get photos => List.unmodifiable(_photos);

  void addPhoto(String tag) {
    // Generate a random Unsplash portrait URL for mock purposes
    final randomId = DateTime.now().millisecondsSinceEpoch.toString();
    final newPhoto = TaggedPhoto(
      id: randomId,
      imageUrl: 'https://source.unsplash.com/random/500x500/?portrait,face&$randomId',
      tag: tag,
    );
    _photos.add(newPhoto);
    notifyListeners();
  }

  void deletePhoto(String id) {
    _photos.removeWhere((photo) => photo.id == id);
    notifyListeners();
  }
}
