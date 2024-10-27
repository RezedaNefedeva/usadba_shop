
import 'package:firebase_app/features/first_page/first_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Map_Flutter extends StatefulWidget {
  const Map_Flutter({super.key});

  @override
  State<Map_Flutter> createState() => _Map_FlutterState();
}

class _Map_FlutterState extends State<Map_Flutter> {

  late final MapController _mapController;

  List<LatLng> get _mapPoints => const [
    LatLng(52.725451, 58.661600),
  ];

  @override
  void initState() {
    _mapController = MapController();
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  List<Marker> _getMarkers(List<LatLng> mapPoints) {
    return List.generate(
      mapPoints.length,
          (index) => Marker(
        point: mapPoints[index],
        child: Image.asset('assets/logo.png'),
        width: 50,
        height: 50,
        alignment: Alignment.center,
      ),
    );
  }



  @override
  Widget build(BuildContext context){
    final theme = Theme.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
      body: PopScope(
        canPop: false,
        onPopInvoked: ((didpop){
          if(didpop){
            return;
          } streamController.add(0);
        }),
        child:

        FlutterMap(
          mapController: _mapController,
          options: const MapOptions(
            initialCenter: LatLng(52.725451, 58.661600),
            initialZoom: 17,
          ),
          children: [
            TileLayer(
              // urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: const ['a', 'b', 'c'],
              userAgentPackageName: 'com.rezeda.firebase_app',
            ),
            MarkerLayer(markers: _getMarkers(_mapPoints)),
          ],
        ),
      ),

    );
  }
}
