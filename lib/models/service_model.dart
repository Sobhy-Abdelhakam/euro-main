class ServiceModel {
  String? name;
  String? header;
  String? notes;
  List<ServiceModel>? serviceList;
  String? img;

  ServiceModel(
      {this.name, this.header, this.notes, this.serviceList, this.img});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    header = json['header'];
    notes = json['notes'];
    if (json['serviceList'] != null) {
      serviceList = <ServiceModel>[];
      json['serviceList'].forEach((v) {
        serviceList!.add(ServiceModel.fromJson(v));
      });
    }
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['header'] = header;
    data['notes'] = notes;
    if (serviceList != null) {
      data['serviceList'] = serviceList!.map((v) => v.toJson()).toList();
    }
    data['img'] = img;
    return data;
  }
}


