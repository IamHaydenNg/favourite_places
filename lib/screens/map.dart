import 'package:favourite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:osm_nominatim/osm_nominatim.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
      address: '',
    ),
    this.isSelecting = true,
  });

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  late final pickerController = PickerMapController(
    initPosition: GeoPoint(
      latitude: widget.location.latitude,
      longitude: widget.location.longitude,
    ),
  );

  PlaceLocation? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isSelecting ? 'Pick your Location' : 'Your Location',
        ),
      ),
      body: CustomPickerLocation(
        controller: pickerController,
        showDefaultMarkerPickWidget: true,
        bottomWidgetPicker: Positioned(
          bottom: 12,
          right: 8,
          child: PointerInterceptor(
            child: FloatingActionButton(
              onPressed: () async {
                GeoPoint p =
                    await pickerController.selectAdvancedPositionPicker();
                if (!context.mounted) return;

                final reverseSearchResult = await Nominatim.reverseSearch(
                  lat: p.latitude,
                  lon: p.longitude,
                  addressDetails: true,
                  extraTags: true,
                  nameDetails: true,
                );

                setState(() {
                  _pickedLocation = PlaceLocation(
                    latitude: p.latitude,
                    longitude: p.longitude,
                    address: reverseSearchResult.displayName,
                  );
                });

                Navigator.of(context).pop(_pickedLocation);
              },
              child: const Text('Confirm'),
            ),
          ),
        ),
        pickerConfig: const CustomPickerLocationConfig(
          zoomOption: ZoomOption(
            initZoom: 8,
          ),
        ),
      ),
    );
  }
}
