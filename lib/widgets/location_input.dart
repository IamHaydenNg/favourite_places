import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:location/location.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectLocation});

  final void Function(PlaceLocation location) onSelectLocation;

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;
  double? _latitude;
  double? _longitude;

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
      _pickedLocation = null;
    });

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lon = locationData.longitude;

    if (lat == null || lon == null) {
      return;
    }

    final reverseSearchResult = await Nominatim.reverseSearch(
      lat: lat,
      lon: lon,
      addressDetails: true,
      extraTags: true,
      nameDetails: true,
    );

    setState(() {
      _pickedLocation = PlaceLocation(
        latitude: lat,
        longitude: lon,
        address: reverseSearchResult.displayName,
      );
      _latitude = lat;
      _longitude = lon;
      _isGettingLocation = false;
    });

    widget.onSelectLocation(_pickedLocation!);
  }

  void _selectedOnMap() async {
    setState(() {
      _pickedLocation = null;
    });

    final pickedLocation = await Navigator.of(context).push<PlaceLocation>(
      MaterialPageRoute(
        builder: (ctx) => const MapScreen(),
      ),
    );

    if (pickedLocation == null) {
      return;
    }

    setState(() {
      _pickedLocation = pickedLocation;
      _latitude = pickedLocation.latitude;
      _longitude = pickedLocation.longitude;
    });

    widget.onSelectLocation(_pickedLocation!);
  }

  late Widget staticMap = OSMViewer(
    controller: SimpleMapController(
      initPosition: GeoPoint(
        latitude: _latitude!,
        longitude: _longitude!,
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

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No location chosen',
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
    );

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    if (_pickedLocation != null) {
      previewContent = staticMap;
    }

    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          alignment: Alignment.center,
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              label: const Text('Get Current Location'),
              icon: const Icon(Icons.location_on),
              onPressed: _getCurrentLocation,
            ),
            TextButton.icon(
              label: const Text('Select on Map'),
              icon: const Icon(Icons.map),
              onPressed: _selectedOnMap,
            )
          ],
        ),
      ],
    );
  }
}
