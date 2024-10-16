import 'package:favourite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  // The state managed by riverpod must not be mutated. You must not edit it in memory.
  // Instead, if you want to add something to it, you should create a new state object, a new list in this case (so that the initial value must be defined to const [])
  // that could be based on the old state but you should not edit the old state directly.

  UserPlacesNotifier() : super(const []);

  void addPlace(String title) {
    final newPlace = Place(title: title);
    // state provide by riverpod, means old state
    state = [newPlace, ...state];
  }
}

final userPlaceProvider = StateNotifierProvider(
  (ref) => UserPlacesNotifier(),
);
