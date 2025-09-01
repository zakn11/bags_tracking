class MyInfoDataModel {
    int id;
    String firstName;
    String lastName;
    String phone;
    String? email;
    dynamic image;
    String role;

    MyInfoDataModel({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.phone,
        required this.email,
        required this.image,
        required this.role,
    });

  factory MyInfoDataModel.fromJson(Map<String, dynamic> json) {
    return MyInfoDataModel(
      id: json['id'],
      role: json['role'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      email: json['email'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'email': email,
      'image': image,
    };
  }
}
