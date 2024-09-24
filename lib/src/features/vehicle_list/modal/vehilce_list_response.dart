import 'dart:developer';

class VehicleResponseData {
  final String message;
  final VehicleData data;

  VehicleResponseData({
    required this.message,
    required this.data,
  });

  factory VehicleResponseData.fromJson(Map<String, dynamic> json) {
    return VehicleResponseData(
      message: json['message'],
      data: VehicleData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class VehicleData {
  final int currentPage;
  final List<Vehicle> vehicles;
  final String firstPageUrl;
  final int lastPage;
  final String lastPageUrl;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int total;

  VehicleData({
    required this.currentPage,
    required this.vehicles,
    required this.firstPageUrl,
    required this.lastPage,
    required this.lastPageUrl,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.total,
  });

  factory VehicleData.fromJson(Map<String, dynamic> json) {
    return VehicleData(
      currentPage: json['current_page'],
      vehicles: (json['data'] as List).map((i) => Vehicle.fromJson(i)).toList(),
      firstPageUrl: json['first_page_url'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'data': vehicles.map((v) => v.toJson()).toList(),
      'first_page_url': firstPageUrl,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'total': total,
    };
  }
}

class Vehicle {
  final int id;
  final String type;
  final String? zone;
  final String? province;
  final String vehicleNo;
  final String lotNo;
  final String? officeCode;
  final String vehicleSymbol;
  final int? officeId;
  final int isEmboss;
  final int isUpdated;
  final String? embossNo;
  final int addedBy;
  final String? overallStatus;
  final List<Document> documents;

  Vehicle({
    required this.id,
    required this.type,
    this.zone,
    this.province,
    required this.isUpdated,
    required this.vehicleNo,
    required this.lotNo,
    this.officeCode,
    required this.vehicleSymbol,
    this.officeId,
    required this.isEmboss,
    this.embossNo,
    required this.addedBy,
    this.overallStatus,
    required this.documents,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      type: json['type'],
      zone: json['zone'],
      province: json['province'],
      vehicleNo: json['vehicle_no'],
      lotNo: json['lot_no'],
      officeCode: json['office_code'],
      vehicleSymbol: json['vehicle_symbol'],
      officeId: json['office_id'],
      isUpdated: json["is_updated"],
      isEmboss: json['is_emboss'],
      embossNo: json['emboss_no'],
      addedBy: json['added_by'],
      overallStatus: json['overall_status'],
      documents:
          (json['documents'] as List).map((i) => Document.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'zone': zone,
      'province': province,
      'vehicle_no': vehicleNo,
      'lot_no': lotNo,
      'office_code': officeCode,
      'vehicle_symbol': vehicleSymbol,
      'office_id': officeId,
      'is_emboss': isEmboss,
      'emboss_no': embossNo,
      'added_by': addedBy,
      'is_updated': isUpdated,
      'overall_status': overallStatus,
      'documents': documents.map((d) => d.toJson()).toList(),
    };
  }
}

class Document {
  final int id;
  final int vehicleId;
  final String abhilekhSlug;
  final String abhilekhName;
  final String docs;
  final String status;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;
  final String? rejectionComment;

  Document({
    required this.id,
    required this.vehicleId,
    required this.abhilekhSlug,
    required this.docs,
    required this.abhilekhName,
    required this.status,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    this.rejectionComment,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'],
      vehicleId: json['vehicle_id'],
      abhilekhSlug: json['abhilekh_slug'],
      abhilekhName: json['abhilekh_name'],
      docs: json['docs'],
      status: json['status'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      rejectionComment: json['rejection_comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vehicle_id': vehicleId,
      'abhilekh_slug': abhilekhSlug,
      'docs': docs,
      'status': status,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'abhilekh_name': abhilekhName,
      'rejection_comment': rejectionComment,
    };
  }
}

class PageLink {
  final String? url;
  final String label;
  final bool active;

  PageLink({
    this.url,
    required this.label,
    required this.active,
  });

  factory PageLink.fromJson(Map<String, dynamic> json) {
    return PageLink(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}
