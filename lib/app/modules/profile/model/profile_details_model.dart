class ProfileDetailsModel {
  ProfileDetailsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final ProfileData? data;

  factory ProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProfileDetailsModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
    );
  }
}

class ProfileData {
  ProfileData({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    required this.role,
    required this.profile,
    required this.phoneNumber,
    required this.expireAt,
    required this.createdAt,
    required this.updatedAt,
    required this.verification,
    required this.deviceHistory,
    required this.location,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? status;
  final String? role;
  final dynamic profile;
  final String? phoneNumber;
  final dynamic expireAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Verification? verification;
  final List<DeviceHistory> deviceHistory;
  final dynamic location;

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      status: json["status"],
      role: json["role"],
      profile: json["profile"],
      phoneNumber: json["phoneNumber"],
      expireAt: json["expireAt"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      verification: json["verification"] == null
          ? null
          : Verification.fromJson(json["verification"]),
      deviceHistory: json["deviceHistory"] == null
          ? []
          : List<DeviceHistory>.from(
              json["deviceHistory"]!.map((x) => DeviceHistory.fromJson(x))),
      location: json["location"],
    );
  }
}

class DeviceHistory {
  DeviceHistory({
    required this.id,
    required this.userId,
    required this.ip,
    required this.browser,
    required this.os,
    required this.device,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? userId;
  final String? ip;
  final dynamic browser;
  final dynamic os;
  final String? device;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory DeviceHistory.fromJson(Map<String, dynamic> json) {
    return DeviceHistory(
      id: json["id"],
      userId: json["userId"],
      ip: json["ip"],
      browser: json["browser"],
      os: json["os"],
      device: json["device"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }
}

class Verification {
  Verification({
    required this.status,
  });

  final bool? status;

  factory Verification.fromJson(Map<String, dynamic> json) {
    return Verification(
      status: json["status"],
    );
  }
}
