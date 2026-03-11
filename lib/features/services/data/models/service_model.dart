import '../../domain/entities/service.dart';

class ServiceModel extends Service {

  ServiceModel({
    required super.name,
    required super.header,
    required super.notes,
    required super.img,
    required super.subServices,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {

    List<ServiceModel> children = [];

    if (json["serviceList"] != null) {
      children = (json["serviceList"] as List)
          .map((e) => ServiceModel.fromJson(e))
          .toList();
    }

    return ServiceModel(
      name: json["name"] ?? "",
      header: json["header"] ?? "",
      notes: json["notes"] ?? "",
      img: json["img"] ?? "",
      subServices: children,
    );
  }

}