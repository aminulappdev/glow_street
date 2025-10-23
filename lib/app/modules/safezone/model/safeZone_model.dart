class SafeZoneModel {
  SafeZoneModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory SafeZoneModel.fromJson(Map<String, dynamic> json) {
    return SafeZoneModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.data,
    required this.meta,
  });

  final List<SafeZoneItemModel> data;
  final Meta? meta;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: json["data"] == null
          ? []
          : List<SafeZoneItemModel>.from(
              json["data"]!.map((x) => SafeZoneItemModel.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }
}

class SafeZoneItemModel {
  SafeZoneItemModel({
    required this.id,
    required this.userId,
    required this.description,
    required this.expectedReturnTime,
    required this.status,
    required this.notification,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.startLocation,
    required this.endLocation,
  });

  final String? id;
  final String? userId;
  final String? description;
  final DateTime? expectedReturnTime;
  final String? status;
  final bool? notification;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Location? startLocation;
  final Location? endLocation;

  factory SafeZoneItemModel.fromJson(Map<String, dynamic> json) {
    return SafeZoneItemModel(
      id: json["id"],
      userId: json["userId"],
      description: json["description"],
      expectedReturnTime: DateTime.tryParse(json["expectedReturnTime"] ?? ""),
      status: json["status"],
      notification: json["notification"],
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      startLocation: json["startLocation"] == null
          ? null
          : Location.fromJson(json["startLocation"]),
      endLocation: json["endLocation"] == null
          ? null
          : Location.fromJson(json["endLocation"]),
    );
  }
}

class Location {
  Location({
    required this.safezoneId,
    required this.type,
    required this.coordinates,
  });

  final String? safezoneId;
  final String? type;
  final List<double> coordinates;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      safezoneId: json["safezoneId"],
      type: json["type"],
      coordinates: json["coordinates"] == null
          ? []
          : List<double>.from(json["coordinates"]!.map((x) => x)),
    );
  }
}

class Meta {
  Meta({
    required this.page,
    required this.limit,
    required this.total,
  });

  final int? page;
  final int? limit;
  final int? total;

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json["page"],
      limit: json["limit"],
      total: json["total"],
    );
  }
}
