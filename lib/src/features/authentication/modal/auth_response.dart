class AuthResponse {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String message;
  final UserData data;

  AuthResponse({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.message,
    required this.data,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
      message: json['message'],
      data: UserData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class UserData {
  final int id;
  final int? parentId;
  final String name;
  final String email;
  final String phone;
  final String? image;
  final String? emailVerifiedAt;
  final String type;
  final String status;
  final int failedLoginCount;
  final String? deletedBy;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;
  final OfficeUser? officeUser;

  UserData({
    required this.id,
    this.parentId,
    required this.name,
    required this.email,
    required this.phone,
    this.image,
    this.emailVerifiedAt,
    required this.type,
    required this.status,
    required this.failedLoginCount,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.officeUser,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      parentId: json['parent_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      emailVerifiedAt: json['email_verified_at'],
      type: json['type'],
      status: json['status'],
      failedLoginCount: json['failed_login_count'],
      deletedBy: json['deleted_by'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      officeUser: json['office_user'] != null
          ? OfficeUser.fromJson(json['office_user'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_id': parentId,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'email_verified_at': emailVerifiedAt,
      'type': type,
      'status': status,
      'failed_login_count': failedLoginCount,
      'deleted_by': deletedBy,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'office_user': officeUser?.toJson(),
    };
  }
}

class OfficeUser {
  final int id;
  final int officeId;
  final int userId;
  final String status;
  final String? deletedBy;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;
  final Office? office;

  OfficeUser({
    required this.id,
    required this.officeId,
    required this.userId,
    required this.status,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.office,
  });

  factory OfficeUser.fromJson(Map<String, dynamic> json) {
    return OfficeUser(
      id: json['id'],
      officeId: json['office_id'],
      userId: json['user_id'],
      status: json['status'],
      deletedBy: json['deleted_by'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      office: json['office'] != null ? Office.fromJson(json['office']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'office_id': officeId,
      'user_id': userId,
      'status': status,
      'deleted_by': deletedBy,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'office': office?.toJson(),
    };
  }
}

class Office {
  final int id;
  final String code;
  final int? zoneId;
  final int provinceId;
  final String officeName;
  final String? description;
  final String? address;
  final String email;
  final String? contact;
  final String status;
  final String? deletedBy;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;

  Office({
    required this.id,
    required this.code,
    this.zoneId,
    required this.provinceId,
    required this.officeName,
    this.description,
    this.address,
    required this.email,
    this.contact,
    required this.status,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      id: json['id'],
      code: json['code'],
      zoneId: json['zone_id'],
      provinceId: json['province_id'],
      officeName: json['office_name'],
      description: json['description'] ?? "",
      address: json['address'] ?? "",
      email: json['email'],
      contact: json['contact'] ?? "",
      status: json['status'],
      deletedBy: json['deleted_by'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'zone_id': zoneId,
      'province_id': provinceId,
      'office_name': officeName,
      'description': description,
      'address': address,
      'email': email,
      'contact': contact,
      'status': status,
      'deleted_by': deletedBy,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
