import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glow_street/app/modules/community/widgets/location_services.dart';
import 'package:glow_street/app/modules/safezone/controllers/add_safeZone_controller.dart';
import 'package:glow_street/app/modules/safezone/controllers/all_safezone_controller.dart';
import 'package:glow_street/app/modules/safezone/controllers/update_status_controller.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';
import 'package:glow_street/app/widgets/custom_disable_button.dart';
import 'package:glow_street/app/widgets/show_snackBar_message.dart';
import 'package:glow_street/app/widgets/toggle_button.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';

class AddSafeZoneAlertDialog extends StatefulWidget {
  const AddSafeZoneAlertDialog({super.key});

  @override
  State<AddSafeZoneAlertDialog> createState() => _AddSafeZoneAlertDialogState();
}

class _AddSafeZoneAlertDialogState extends State<AddSafeZoneAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  bool isShowNotification = true;
  bool _isLoading = false;

  // Controllers
  final _descriptionController = TextEditingController();
  final _startLocationController = TextEditingController();
  final _endLocationController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final CreateSafeZoneController createSafeZoneController =
      CreateSafeZoneController();


  // Location variables
  LatLng? selectedStartLocation;
  double? startLatitude;
  double? startLongitude;

  LatLng? selectedEndLocation;
  double? endLatitude;
  double? endLongitude;

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final LocationService _locationService = LocationService();

  @override
  void dispose() {
    _descriptionController.dispose();
    _startLocationController.dispose();
    _endLocationController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  // Method to show date picker
  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && mounted) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  // Method to show time picker
  Future<void> _pickTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (pickedTime != null && mounted) {
      setState(() {
        _selectedTime = pickedTime;
        _timeController.text = pickedTime.format(context);
      });
    }
  }

  // Method to show start location picker
  Future<void> _pickStartLocation() async {
    LatLng? initialPosition =
        await _locationService.getCurrentLocation(context);
    if (initialPosition == null) return;

    final LatLng? pickedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPickerScreen(
          initialPosition: initialPosition,
        ),
      ),
    );

    if (pickedLocation != null && mounted) {
      String locationName =
          await _locationService.getPlaceName(context, pickedLocation);
      setState(() {
        selectedStartLocation = pickedLocation;
        startLatitude = pickedLocation.latitude;
        startLongitude = pickedLocation.longitude;
        _startLocationController.text = locationName;
      });
    }
  }

  // Method to show end location picker
  Future<void> _pickEndLocation() async {
    LatLng? initialPosition =
        await _locationService.getCurrentLocation(context);
    if (initialPosition == null) return;

    final LatLng? pickedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPickerScreen(
          initialPosition: initialPosition,
        ),
      ),
    );

    if (pickedLocation != null && mounted) {
      String locationName =
          await _locationService.getPlaceName(context, pickedLocation);
      setState(() {
        selectedEndLocation = pickedLocation;
        endLatitude = pickedLocation.latitude;
        endLongitude = pickedLocation.longitude;
        _endLocationController.text = locationName;
      });
    }
  }

  // Convert DateTime and TimeOfDay to ISO 8601 string
  String? _convertToIso8601String(DateTime? date, TimeOfDay? time) {
    if (date == null || time == null) return null;
    final combinedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    return combinedDateTime
        .toUtc()
        .toIso8601String(); // Converts to UTC and formats as ISO 8601
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text(
        'Plan Your Run',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Description Field
              const Text(
                'Run Description',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 133, 132, 132),
                ),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Enter run description',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              heightBox8,

              // Start Location Field
              Row(
                children: const [
                  Icon(Icons.location_on, color: Color(0xff1BC4BD), size: 16),
                  Text(
                    'Start Location',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 133, 132, 132),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: _pickStartLocation,
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _startLocationController,
                    decoration: const InputDecoration(
                      hintText: 'Tap to select start location',
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          startLatitude == null ||
                          startLongitude == null) {
                        return 'Please select a valid start location';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              heightBox8,

              // End Location Field
              Row(
                children: const [
                  Icon(Icons.location_on, color: Color(0xff1BC4BD), size: 16),
                  Text(
                    'End Location',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 133, 132, 132),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: _pickEndLocation,
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _endLocationController,
                    decoration: const InputDecoration(
                      hintText: 'Tap to select end location',
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          endLatitude == null ||
                          endLongitude == null) {
                        return 'Please select a valid end location';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              heightBox8,

              // Expected Date Field
              Row(
                children: const [
                  Icon(Icons.calendar_today,
                      color: Color(0xff1BC4BD), size: 16),
                  Text(
                    'Expected Date',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 133, 132, 132),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: _pickDate,
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                      hintText: 'Tap to select date',
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          _selectedDate == null) {
                        return 'Please select a valid date';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              heightBox8,

              // Expected Time Field
              Row(
                children: const [
                  Icon(Icons.access_time, color: Color(0xff1BC4BD), size: 16),
                  Text(
                    'Expected Time',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 133, 132, 132),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: _pickTime,
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _timeController,
                    decoration: const InputDecoration(
                      hintText: 'Tap to select time',
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          _selectedTime == null) {
                        return 'Please select a valid time';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              heightBox8,

              // Notification Toggle
              Row(
                children: [
                  ToggleButton(
                    isToggled: isShowNotification,
                    onToggle: (bool value) {
                      setState(() {
                        isShowNotification = value;
                      });
                    },
                  ),
                  widthBox8,
                  const Text(
                    'Notify my contacts if late',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 3, 3, 3),
                    ),
                  ),
                ],
              ),
              heightBox20,

              // Buttons
              CustomElevatedButton(
                isLoading: _isLoading,
                title: 'Create Safe Zone',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    createSafeZone();
                  }
                },
              ),
              heightBox8,
              CustomDisableElevatedButton(
                title: 'Cancel',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createSafeZone() async {
    setState(() {
      _isLoading = true; // লোডিং শুরু
    });

    final String? expectedReturnTime =
        _convertToIso8601String(_selectedDate, _selectedTime);

    final bool isSuccess = await createSafeZoneController.creatSafeZone(
      description: _descriptionController.text.trim(),
      isContact: isShowNotification,
      startLat: startLatitude,
      startLng: startLongitude,
      endLat: endLatitude,
      endLng: endLongitude,
      time: expectedReturnTime ?? DateTime.now().toUtc().toIso8601String(),
    );

    setState(() {
      _isLoading = false; // লোডিং শেষ
    });

    if (isSuccess) {
      if (mounted) {
        final AllSafeZoneController allController =
            Get.find<AllSafeZoneController>();
        await allController.getSafeZoneContact();
        // showSnackBarMessage(context, 'Successfully done'); // অপশনাল: সাকসেস মেসেজ
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, createSafeZoneController.errorMessage, true);
      }
    }
  }

 
}
