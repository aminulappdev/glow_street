import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glow_street/app/modules/community/widgets/location_services.dart';
import 'package:glow_street/app/modules/safezone/controllers/all_safezone_controller.dart';
import 'package:glow_street/app/modules/safezone/controllers/update_safeZone_controller.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';
import 'package:glow_street/app/widgets/custom_disable_button.dart';
import 'package:glow_street/app/widgets/show_snackBar_message.dart';
import 'package:glow_street/app/widgets/toggle_button.dart';
import 'package:glow_street/app/modules/safezone/model/safeZone_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';

class EditSafeZoneAlertDialog extends StatefulWidget {
  final SafeZoneItemModel safeZoneItemModel;
  const EditSafeZoneAlertDialog({super.key, required this.safeZoneItemModel});

  @override
  State<EditSafeZoneAlertDialog> createState() =>
      _EditSafeZoneAlertDialogState();
}

class _EditSafeZoneAlertDialogState extends State<EditSafeZoneAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  bool isShowNotification = true;
  bool _isLoading = false;

  // Controllers
  final _descriptionController = TextEditingController();
  final _startLocationController = TextEditingController();
  final _endLocationController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final UpdateSafeZoneController updateSafeZoneController =
      Get.put(UpdateSafeZoneController());

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
  void initState() {
    super.initState();
    // Initialize fields with existing safe zone data
    _descriptionController.text = widget.safeZoneItemModel.description ?? '';
    isShowNotification = widget.safeZoneItemModel.notification ?? true;
    // startLatitude = widget.safeZoneItemModel.startLocation?.coordinates[0];
    // startLongitude = widget.safeZoneItemModel.startLocation?.coordinates[1];
    // endLatitude = widget.safeZoneItemModel.endLocation?.coordinates[0];
    // endLongitude = widget.safeZoneItemModel.endLocation?.coordinates[1];
    selectedStartLocation = startLatitude != null && startLongitude != null
        ? LatLng(startLatitude!, startLongitude!)
        : null;
    selectedEndLocation = endLatitude != null && endLongitude != null
        ? LatLng(endLatitude!, endLongitude!)
        : null;

    // if (widget.safeZoneItemModel.expectedReturnTime != null) {
    //   try {
    //     final dateTime = DateTime.parse(widget.safeZoneItemModel.createdAt!);
    //     _selectedDate = dateTime;
    //     _selectedTime = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
    //   } catch (e) {
    //     print('Error parsing expectedReturnTime: $e');
    //   }
    // }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize location names and date/time display after context is available
    _updateStartLocationName();
    _updateEndLocationName();
    if (_selectedDate != null) {
      _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
    }
    if (_selectedTime != null) {
      _timeController.text = _selectedTime!.format(context);
    }
  }

  // Update start location name
  Future<void> _updateStartLocationName() async {
    if (selectedStartLocation != null) {
      String locationName =
          await _locationService.getPlaceName(context, selectedStartLocation!);
      if (mounted) {
        setState(() {
          _startLocationController.text = locationName;
        });
      }
    }
  }

  // Update end location name
  Future<void> _updateEndLocationName() async {
    if (selectedEndLocation != null) {
      String locationName =
          await _locationService.getPlaceName(context, selectedEndLocation!);
      if (mounted) {
        setState(() {
          _endLocationController.text = locationName;
        });
      }
    }
  }

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
  // Future<void> _pickDate() async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: _selectedDate ?? DateTime.now(),
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2100),
  //   );

  //   if (pickedDate != null && mounted) {
  //     setState(() {
  //       _selectedDate = pickedDate;
  //       _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  //     });
  //   }
  // }

  // // Method to show time picker
  // Future<void> _pickTime() async {
  //   final TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: _selectedTime ?? TimeOfDay.now(),
  //     builder: (context, child) {
  //       return MediaQuery(
  //         data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
  //         child: child!,
  //       );
  //     },
  //   );

  //   if (pickedTime != null && mounted) {
  //     setState(() {
  //       _selectedTime = pickedTime;
  //       _timeController.text = pickedTime.format(context);
  //     });
  //   }
  // }

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
    return combinedDateTime.toUtc().toIso8601String();
  }

  // Method to update safe zone
  Future<void> updateSafeZone() async {
    setState(() {
      _isLoading = true;
    });

    final String? expectedReturnTime =
        _convertToIso8601String(_selectedDate, _selectedTime);

    final bool isSuccess = await updateSafeZoneController.updateSafeZone(
      safeZoneId: widget.safeZoneItemModel.id!,
      description: _descriptionController.text.trim(),
      isContact: isShowNotification,
      startLat: startLatitude,
      startLng: startLongitude,
      endLat: endLatitude,
      endLng: endLongitude,
      time: expectedReturnTime ?? DateTime.now().toUtc().toIso8601String(),
    );

    setState(() {
      _isLoading = false;
    });

    if (isSuccess) {
      if (mounted) {
        final AllSafeZoneController allController =
            Get.find<AllSafeZoneController>();
        await allController.getSafeZoneContact();
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, updateSafeZoneController.errorMessage, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text(
        'Edit Your Run',
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
                maxLines: 3,
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

              // Expected Date Field
              // Row(
              //   children: const [
              //     Icon(Icons.calendar_today,
              //         color: Color(0xff1BC4BD), size: 16),
              //     Text(
              //       'Expected Date',
              //       style: TextStyle(
              //         fontSize: 12,
              //         fontWeight: FontWeight.w400,
              //         color: Color.fromARGB(255, 133, 132, 132),
              //       ),
              //     ),
              //   ],
              // ),
              // GestureDetector(
              //   onTap: _pickDate,
              //   child: AbsorbPointer(
              //     child: TextFormField(
              //       controller: _dateController,
              //       decoration: const InputDecoration(
              //         hintText: 'Tap to select date',
              //       ),
              //       validator: (value) {
              //         if (value == null ||
              //             value.isEmpty ||
              //             _selectedDate == null) {
              //           return 'Please select a valid date';
              //         }
              //         return null;
              //       },
              //     ),
              //   ),
              // ),
              // heightBox8,

              // // Expected Time Field
              // Row(
              //   children: const [
              //     Icon(Icons.access_time, color: Color(0xff1BC4BD), size: 16),
              //     Text(
              //       'Expected Time',
              //       style: TextStyle(
              //         fontSize: 12,
              //         fontWeight: FontWeight.w400,
              //         color: Color.fromARGB(255, 133, 132, 132),
              //       ),
              //     ),
              //   ],
              // ),
              // GestureDetector(
              //   onTap: _pickTime,
              //   child: AbsorbPointer(
              //     child: TextFormField(
              //       controller: _timeController,
              //       decoration: const InputDecoration(
              //         hintText: 'Tap to select time',
              //       ),
              //       validator: (value) {
              //         if (value == null ||
              //             value.isEmpty ||
              //             _selectedTime == null) {
              //           return 'Please select a valid time';
              //         }
              //         return null;
              //       },
              //     ),
              //   ),
              // ),
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
                title: 'Save Changes',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateSafeZone();
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
}
