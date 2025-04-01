import 'dart:async';

import 'package:dio/dio.dart';
import 'package:finals_fe/extensions/build_context.ext.dart';
import 'package:finals_fe/features/service/widgets/bottom_info_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchFieldVisibilityProvider = StateProvider<bool>((ref) => false);
final latitudeProvider = StateProvider<double>((ref) => 0.0);
final longitudeProvider = StateProvider<double>((ref) => 0.0);
final isLocatingProvider = StateProvider<bool>((ref) => false);
final personMarkerProvider = StateProvider<Marker?>((ref) => null);
final suggestionsProvider = StateProvider<List<String>>((ref) => []);

class ServiceMapPage extends StatefulHookConsumerWidget {
  final double initialLatitude;
  final double initialLongitude;
  final String snKit;
  final int mNodelinkId;

  const ServiceMapPage({
    super.key,
    required this.initialLatitude,
    required this.initialLongitude,
    required this.snKit,
    required this.mNodelinkId,
  });

  @override
  _ServiceMapPageState createState() => _ServiceMapPageState();
}

class _ServiceMapPageState extends ConsumerState<ServiceMapPage> {
  late Completer<GoogleMapController> mapControllerCompleter;
  Timer? debounce;
  final mapsApiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];

  @override
  void initState() {
    super.initState();
    mapControllerCompleter = Completer();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(latitudeProvider) == 0.0 && ref.read(longitudeProvider) == 0.0) {
        ref.read(latitudeProvider.notifier).state = widget.initialLatitude;
        ref.read(longitudeProvider.notifier).state = widget.initialLongitude;
      }
    });
  }

  void onSearchChanged(String query) {
    if (debounce?.isActive ?? false) debounce!.cancel();

    debounce = Timer(const Duration(milliseconds: 300), () {
      if (query.isNotEmpty) {
        fetchSuggestions(query);
      } else {
        ref.read(suggestionsProvider.notifier).state = [];
      }
    });
  }

  Future<void> fetchSuggestions(String query) async {
    String? apiKey = mapsApiKey;
    const baseUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';

    try {
      final response = await Dio().get(baseUrl, queryParameters: {
        'input': query,
        'key': apiKey ?? '',
      });

      final predictions = response.data['predictions'] as List;
      final suggestions = predictions.map((p) => p['description'] as String).toList();

      ref.read(suggestionsProvider.notifier).state = suggestions;
    } catch (e) {
      ref.read(suggestionsProvider.notifier).state = [];
      context.showErrorSnackbar('Gagal Memuat suggestions Search');
    }
  }

  Future<void> _animateToUserLocation(WidgetRef ref, GoogleMapController controller) async {
    final isLocating = ref.read(isLocatingProvider.notifier);

    if (isLocating.state) return;

    isLocating.state = true;

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }

      if (permission == LocationPermission.deniedForever) return;

      Position position =
          await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      ref.read(latitudeProvider.notifier).state = position.latitude;
      ref.read(longitudeProvider.notifier).state = position.longitude;

      ref.read(personMarkerProvider.notifier).state = Marker(
        markerId: const MarkerId('personLocation'),
        position: LatLng(position.latitude, position.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );

      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 16.0,
          ),
        ),
      );
    } finally {
      isLocating.state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchFieldVisible = ref.watch(searchFieldVisibilityProvider);
    final latitude = ref.watch(latitudeProvider);
    final longitude = ref.watch(longitudeProvider);
    final isLocating = ref.watch(isLocatingProvider);
    final personMarker = ref.watch(personMarkerProvider);
    final suggestions = ref.watch(suggestionsProvider);

    return PopScope(
      onPopInvoked: (canPop) async {
        ref.read(latitudeProvider.notifier).state = 0.0;
        ref.read(longitudeProvider.notifier).state = 0.0;
        ref.read(searchFieldVisibilityProvider.notifier).state = false;
        ref.read(personMarkerProvider.notifier).state = null;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.initialLatitude, widget.initialLongitude),
                zoom: 16.0,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('nodelinkLocation'),
                  position: LatLng(latitude, longitude),
                ),
                if (personMarker != null) personMarker,
              },
              onMapCreated: (GoogleMapController controller) {
                if (!mapControllerCompleter.isCompleted) {
                  mapControllerCompleter.complete(controller);
                }
              },
              onTap: (LatLng tappedPoint) {
                ref.read(latitudeProvider.notifier).state = tappedPoint.latitude;
                ref.read(longitudeProvider.notifier).state = tappedPoint.longitude;
              },
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
            ),
            Positioned(
              top: 50,
              left: 20,
              child: Container(
                width: 44,
                height: 44,
                decoration: const ShapeDecoration(
                  color: Color(0xFF242134),
                  shape: OvalBorder(),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                  onPressed: () {
                    ref.read(latitudeProvider.notifier).state = 0.0;
                    ref.read(longitudeProvider.notifier).state = 0.0;
                    ref.read(searchFieldVisibilityProvider.notifier).state = false;
                    ref.read(personMarkerProvider.notifier).state = null;
                    if (mounted) context.pop();
                  },
                ),
              ),
            ),
            Positioned(
              top: 50,
              right: 20,
              child: Container(
                width: 44,
                height: 44,
                decoration: const ShapeDecoration(
                  color: Color(0xFF242134),
                  shape: OvalBorder(),
                ),
                child: IconButton(
                  icon: const Icon(Icons.search_rounded, color: Colors.white),
                  onPressed: () {
                    ref.read(searchFieldVisibilityProvider.notifier).state = !searchFieldVisible;
                  },
                ),
              ),
            ),
            if (searchFieldVisible)
              Positioned(
                top: 50,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 12, right: 5),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF242134),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: TextField(
                        onChanged: onSearchChanged,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              ref.read(searchFieldVisibilityProvider.notifier).state =
                                  !searchFieldVisible;
                            },
                            icon: const Icon(Icons.search_rounded, color: Colors.white, size: 18),
                          ),
                          hintText: 'Cari lokasi',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.40),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    if (suggestions.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF242134),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: suggestions.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                suggestions[index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onTap: () async {
                                List<Location> locations =
                                    await locationFromAddress(suggestions[index]);

                                if (locations.isNotEmpty) {
                                  final selectedLocation = locations.first;

                                  ref.read(latitudeProvider.notifier).state =
                                      selectedLocation.latitude;
                                  ref.read(longitudeProvider.notifier).state =
                                      selectedLocation.longitude;

                                  final GoogleMapController controller =
                                      await mapControllerCompleter.future;

                                  controller.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                        target: LatLng(
                                            selectedLocation.latitude, selectedLocation.longitude),
                                        zoom: 16.0,
                                      ),
                                    ),
                                  );
                                  ref.read(suggestionsProvider.notifier).state = [];
                                }
                              },
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            Positioned(
              bottom: 330,
              right: 20,
              child: GestureDetector(
                onTap: isLocating
                    ? null
                    : () async {
                        final GoogleMapController controller = await mapControllerCompleter.future;
                        await _animateToUserLocation(ref, controller);
                      },
                child: Container(
                  width: 71,
                  height: 71,
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    color: isLocating ? Colors.grey : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.50),
                    ),
                  ),
                  child: const Icon(Icons.my_location, color: Color(0xFF242134), size: 24),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomInfoContainer(
                latitude: latitude,
                longitude: longitude,
                snKit: widget.snKit,
                onSimpan: () async {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
