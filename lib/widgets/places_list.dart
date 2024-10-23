import 'package:favourite_places/screens/places_detail.dart';
import 'package:flutter/material.dart';
import 'package:favourite_places/models/place.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.place});

  final List<Place> place;

  @override
  Widget build(BuildContext context) {
    if (place.isEmpty) {
      return Center(
        child: Text(
          'No places added yet',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      );
    }
    return ListView.builder(
      itemCount: place.length,
      itemBuilder: (ctx, index) => ListTile(
        leading: CircleAvatar(
          radius: 26,
          backgroundImage: FileImage(place[index].image),
        ),
        title: Text(
          place[index].title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => PlacesDetailScreen(
                place: place[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
