import 'dart:io';
import 'package:favourite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  // The state managed by riverpod must not be mutated. You must not edit it in memory.
  // Instead, if you want to add something to it, you should create a new state object, a new list in this case (so that the initial value must be defined to const [])
  // that could be based on the old state but you should not edit the old state directly.

  UserPlacesNotifier() : super(const []);

  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$fileName');

    final newPlace =
        Place(title: title, image: copiedImage, location: location);
    // state provide by riverpod, means old state
    state = [newPlace, ...state];
  }
}

final userPlaceProvider =
    // The first type is return type UserPlacesNotifier, the second type is the eventually return type of UserPlacesNotifier (List<Place>)
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
