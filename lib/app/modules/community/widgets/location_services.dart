// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' hide Location;

// Location Service class to handle all location-related logic
class LocationService {
  final Location _location = Location();

  // Check and request location service
  Future<bool> _checkAndRequestService(BuildContext context) async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        _showSnackBar(context, 'Location service is disabled', Colors.red);
        return false;
      }
    }
    return true;
  }

  // Check and request location permission
  Future<bool> _checkAndRequestPermission(BuildContext context) async {
    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        _showSnackBar(context, 'Location permission denied', Colors.red);
        return false;
      }
    }
    return true;
  }

  // Get current location
  Future<LatLng?> getCurrentLocation(BuildContext context) async {
    if (!await _checkAndRequestService(context)) return null;
    if (!await _checkAndRequestPermission(context)) return null;

    try {
      LocationData locationData = await _location.getLocation();
      return LatLng(locationData.latitude!, locationData.longitude!);
    } catch (e) {
      _showSnackBar(context, 'Error getting location: $e', Colors.red);
      return null;
    }
  }

  // Search for a location using Nominatim API
  Future<LatLng?> searchLocation(BuildContext context, String query) async {
    if (query.isEmpty) return null;

    final String url =
        'https://nominatim.openstreetmap.org/search?q=${Uri.encodeComponent(query)}&format=json&limit=5';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'User-Agent': 'glow_street/1.0',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        if (data.isNotEmpty) {
          final double lat = double.parse(data[0]['lat'].toString());
          final double lng = double.parse(data[0]['lon'].toString());
          return LatLng(lat, lng);
        } else {
          _showSnackBar(context, 'Location not found', Colors.red);
          return null;
        }
      } else {
        _showSnackBar(context, 'Failed to fetch location', Colors.red);
        return null;
      }
    } catch (e) {
      _showSnackBar(context, 'Error: $e', Colors.red);
      return null;
    }
  }

  // Perform reverse geocoding to get place name
  Future<String> getPlaceName(BuildContext context, LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark placemark = placemarks.first;
      return _formatPlaceName(placemark);
    } catch (e) {
      _showSnackBar(context, 'Failed to get location name', Colors.red);
      return 'Unknown Location';
    }
  }

  // Helper method to format placemark into readable address
  String _formatPlaceName(Placemark placemark) {
    List<String> addressParts = [];
    if (placemark.name != null && placemark.name!.isNotEmpty) {
      addressParts.add(placemark.name!);
    }
    if (placemark.locality != null && placemark.locality!.isNotEmpty) {
      addressParts.add(placemark.locality!);
    }
    if (placemark.administrativeArea != null &&
        placemark.administrativeArea!.isNotEmpty) {
      addressParts.add(placemark.administrativeArea!);
    }
    if (placemark.country != null && placemark.country!.isNotEmpty) {
      addressParts.add(placemark.country!);
    }
    return addressParts.isNotEmpty
        ? addressParts.join(', ')
        : 'Unknown Location';
  }

  // Helper method to show SnackBar
  void _showSnackBar(BuildContext context, String message, Color color) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
        ),
      );
    }
  }
}

// Location Picker Screen with simplified UI logic
class LocationPickerScreen extends StatefulWidget {
  final LatLng initialPosition;
  final bool? showConfirmButoon;

  const LocationPickerScreen(
      {required this.initialPosition,
      super.key,
      this.showConfirmButoon = true});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late LatLng selectedPosition;
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    selectedPosition = widget.initialPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Location',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff1D4ED8),
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: widget.initialPosition,
              initialZoom: 16.0,
              onTap: (tapPosition, point) {
                setState(() {
                  selectedPosition = point;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 60.0,
                    height: 60.0,
                    point: selectedPosition,
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 10.h,
            left: 16.w,
            right: 16.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                style: TextStyle(fontSize: 16.sp),
                decoration: InputDecoration(
                  hintText: 'Search location',
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                    color: const Color.fromARGB(255, 133, 132, 132),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search,
                        size: 20.sp, color: const Color(0xff1D4ED8)),
                    onPressed: () async {
                      LatLng? newPosition =
                          await _locationService.searchLocation(
                        context,
                        _searchController.text,
                      );
                      if (newPosition != null) {
                        setState(() {
                          selectedPosition = newPosition;
                        });
                        _mapController.move(newPosition, 16.0);
                      }
                    },
                  ),
                  border: InputBorder.none,
                ),
                onSubmitted: (query) async {
                  LatLng? newPosition =
                      await _locationService.searchLocation(context, query);
                  if (newPosition != null) {
                    setState(() {
                      selectedPosition = newPosition;
                    });
                    _mapController.move(newPosition, 16.0);
                  }
                },
                textInputAction: TextInputAction.search,
              ),
            ),
          ),
        ],
      ),
      bottomSheet: widget.showConfirmButoon == true
          ? Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              padding: EdgeInsets.all(20.h),
              child: Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      title: 'Confirm Location',
                      onPressed: () {
                        Navigator.pop(context, selectedPosition);
                      },
                    ),
                  ),
                ],
              ),
            )
          : Container(
              height: 2,
            ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
