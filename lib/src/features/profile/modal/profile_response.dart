class ProfileData {
  final String message;
  final Data data;

  ProfileData({
    required this.message,
    required this.data,
  });

  // Factory constructor to create a new ProfileData instance from a map
  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }

  // Method to convert a ProfileData instance to a map
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class Data {
  final Profile profile;
  final int approvedCount;
  final int pendingCount;
  final int rejectedCount;

  Data({
    required this.profile,
    required this.approvedCount,
    required this.pendingCount,
    required this.rejectedCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      profile: Profile.fromJson(json['profile']),
      approvedCount: json['approved_count'],
      pendingCount: json['pending_count'],
      rejectedCount: json['rejected_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile': profile.toJson(),
      'approved_count': approvedCount,
      'pending_count': pendingCount,
      'rejected_count': rejectedCount,
    };
  }
}

class Profile {
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

  Profile({
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
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
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
    };
  }
}
