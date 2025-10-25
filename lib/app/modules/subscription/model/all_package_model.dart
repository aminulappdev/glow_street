class AllPackageModel {
    AllPackageModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final Data? data;

    factory AllPackageModel.fromJson(Map<String, dynamic> json){ 
        return AllPackageModel(
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

    final List<AllPackageItemModel> data;
    final Meta? meta;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            data: json["data"] == null ? [] : List<AllPackageItemModel>.from(json["data"]!.map((x) => AllPackageItemModel.fromJson(x))),
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        );
    }

}

class AllPackageItemModel {
    AllPackageItemModel({
        required this.id,
        required this.title,
        required this.descriptions,
        required this.price,
        required this.durationDay,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? id;
    final String? title;
    final String? descriptions;
    final double? price;
    final int? durationDay;
    final bool? isDeleted;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory AllPackageItemModel.fromJson(Map<String, dynamic> json){ 
        return AllPackageItemModel(
            id: json["id"],
            title: json["title"],
            descriptions: json["descriptions"],
            price: json["price"],
            durationDay: json["durationDay"],
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

    factory Meta.fromJson(Map<String, dynamic> json){ 
        return Meta(
            page: json["page"],
            limit: json["limit"],
            total: json["total"],
        );
    }

}
