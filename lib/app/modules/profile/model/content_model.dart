class ContentModel {
    ContentModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final ContentData? data;

    factory ContentModel.fromJson(Map<String, dynamic> json){ 
        return ContentModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? null : ContentData.fromJson(json["data"]),
        );
    }

}

class ContentData {
    ContentData({
        required this.id,
        required this.termsAndCondition,
        required this.privacyPolicy,
        required this.aboutUs,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? id;
    final String? termsAndCondition;
    final String? privacyPolicy;
    final String? aboutUs;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory ContentData.fromJson(Map<String, dynamic> json){ 
        return ContentData(
            id: json["id"],
            termsAndCondition: json["termsAndCondition"],
            privacyPolicy: json["privacyPolicy"],
            aboutUs: json["aboutUs"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
        );
    }

}
