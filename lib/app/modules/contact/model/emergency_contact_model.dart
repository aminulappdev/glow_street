class EmergencyContactModel {
  EmergencyContactModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory EmergencyContactModel.fromJson(Map<String, dynamic> json) {
    return EmergencyContactModel(
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

  final List<EmergencyContactItemModel> data;
  final Meta? meta;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: json["data"] == null
          ? []
          : List<EmergencyContactItemModel>.from(
              json["data"]!.map((x) => EmergencyContactItemModel.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }
}

class EmergencyContactItemModel {
  EmergencyContactItemModel({
    required this.id,
    required this.userId,
    required this.profile,
    required this.name,
    required this.relation,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.user,
  });

  final String? id;
  final String? userId;
  final String? profile;
  final String? name;
  final String? relation;
  final String? phoneNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isDeleted;
  final User? user;

  factory EmergencyContactItemModel.fromJson(Map<String, dynamic> json) {
    return EmergencyContactItemModel(
      id: json["id"],
      userId: json["userId"],
      profile: json["profile"],
      name: json["name"],
      relation: json["relation"],
      phoneNumber: json["phoneNumber"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      isDeleted: json["isDeleted"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.status,
    required this.role,
    required this.profile,
    required this.phoneNumber,
    required this.customerId,
    required this.expireAt,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? status;
  final String? role;
  final dynamic profile;
  final dynamic phoneNumber;
  final String? customerId;
  final dynamic expireAt;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      password: json["password"],
      status: json["status"],
      role: json["role"],
      profile: json["profile"],
      phoneNumber: json["phoneNumber"],
      customerId: json["customerId"],
      expireAt: json["expireAt"],
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
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
