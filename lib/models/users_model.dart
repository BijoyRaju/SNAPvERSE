class UsersModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String profileImage;
  final String bio;
  final DateTime createdAt;

  UsersModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.profileImage,
    required this.bio,
    required this.createdAt,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      profileImage: json['profile_image'], 
      bio: json['bio'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
