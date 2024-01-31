class User {
  final int? id;
  final String? fullName;
  final String? username;
  final String? email;
  final String? phoneNumber;
  final int? roleId;
  final int? registeredStoreId;
  final DateTime? activatedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? isActive;
  final String? avatar;

  User({
    this.id,
    this.fullName,
    this.username,
    this.email,
    this.phoneNumber,
    this.roleId,
    this.registeredStoreId,
    this.activatedAt,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["full_name"],
        username: json["username"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        roleId: json["role_id"],
        registeredStoreId: json["registered_store_id"],
        activatedAt: json["activated_at"] != null
            ? DateTime.parse(json["activated_at"]).toLocal()
            : null,
        createdAt: DateTime.parse(json["created_at"]).toLocal(),
        updatedAt: DateTime.parse(json["updated_at"]).toLocal(),
        isActive: json["is_active"],
        avatar: json["profile_photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "username": username,
        "email": email,
        "role_id": roleId,
        "registered_store_id": registeredStoreId,
        "phone_number": phoneNumber,
        "activated_at": activatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_active": isActive,
        "profile_photo": avatar,
      };
}
