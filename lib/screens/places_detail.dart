import 'package:favourite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class PlacesDetailScreen extends StatelessWidget {
  const PlacesDetailScreen({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    late Widget staticMap = OSMViewer(
      controller: SimpleMapController(
        initPosition: GeoPoint(
          latitude: place.location.latitude,
          longitude: place.location.longitude,
        ),
        markerHome: const MarkerIcon(
          icon: Icon(
            Icons.location_on,
            color: Colors.red,
          ),
        ),
      ),
      zoomOption: const ZoomOption(
        initZoom: 16,
        minZoomLevel: 11,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: staticMap,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    textAlign: TextAlign.center,
                    place.location.address,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
