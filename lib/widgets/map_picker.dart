// import 'package:flutter/material.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
// // import 'package:pointer_interceptor/pointer_interceptor.dart';

// class LocationAppExample extends StatefulWidget {
//   const LocationAppExample({super.key});

//   @override
//   State<StatefulWidget> createState() => _LocationAppExampleState();
// }

// class _LocationAppExampleState extends State<LocationAppExample> {
//   ValueNotifier<GeoPoint?> notifier = ValueNotifier(null);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("search picker example"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ValueListenableBuilder<GeoPoint?>(
//               valueListenable: notifier,
//               builder: (ctx, p, child) {
//                 return Center(
//                   child: Text(
//                     p?.toString() ?? "",
//                     textAlign: TextAlign.center,
//                   ),
//                 );
//               },
//             ),
//             Column(
//               children: [
//                 ElevatedButton(
//                   onPressed: () async {
//                     var p = await Navigator.pushNamed(context, "/search");
//                     if (p != null) {
//                       notifier.value = p as GeoPoint;
//                     }
//                   },
//                   child: const Text("pick address"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     var p = await showSimplePickerLocation(
//                       context: context,
//                       isDismissible: true,
//                       title: "location picker",
//                       textConfirmPicker: "pick",
//                       zoomOption: const ZoomOption(
//                         initZoom: 8,
//                       ),
//                       initPosition: GeoPoint(
//                         latitude: 47.4358055,
//                         longitude: 8.4737324,
//                       ),
//                       radius: 8.0,
//                     );
//                     if (p != null) {
//                       notifier.value = p;
//                     }
//                   },
//                   child: const Text("show picker address"),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert';

// import 'package:favourite_places/widgets/top_search_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
// import 'package:pointer_interceptor/pointer_interceptor.dart';

// class LocationAppExample extends StatefulWidget {
//   const LocationAppExample({super.key});

//   @override
//   State<StatefulWidget> createState() => _LocationAppExample();
// }

// class _LocationAppExample extends State<LocationAppExample> {
//   late TextEditingController textEditingController = TextEditingController();
//   late PickerMapController controller = PickerMapController(
//     initPosition: GeoPoint(latitude: widget, longitude: longitude)
//   );

//   @override
//   Widget build(BuildContext context) {
//     return CustomPickerLocation(
//       controller: controller,
//       showDefaultMarkerPickWidget: true,
//       bottomWidgetPicker: Positioned(
//         bottom: 12,
//         right: 8,
//         child: PointerInterceptor(
//           child: FloatingActionButton(
//             onPressed: () async {
//               GeoPoint p = await controller.selectAdvancedPositionPicker();
//               if (!context.mounted) return;
//               print(p);
//               // Navigator.pop(context, p);
//             },
//             child: const Icon(Icons.arrow_forward),
//           ),
//         ),
//       ),
//       pickerConfig: const CustomPickerLocationConfig(
//         zoomOption: ZoomOption(
//           initZoom: 8,
//         ),
//       ),
//     );
//   }
// }
