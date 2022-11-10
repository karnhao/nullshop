class User {
  final String uid;
  final String email;
  final String username;
  final String? role;
  final String? phone;
  final String? address;
  double? coin;

  User(
      {required this.uid,
      required this.email,
      required this.username,
      this.role,
      this.phone,
      this.address,
      this.coin});

  static User fromMap2({required Map<String, dynamic> userMap}) {
    return User(
      uid: userMap["uid"],
      email: userMap["email"],
      username: userMap["username"],
      role: userMap["role"],
      phone: userMap["phone"],
      address: userMap["address"],
      coin: userMap["coin"],
    );
  }

  User.fromMap({required Map<String, dynamic> userMap})
      : uid = userMap["uid"],
        email = userMap["email"],
        username = userMap["username"],
        role = userMap["role"],
        phone = userMap["phone"],
        address = userMap["address"],
        coin = double.parse(userMap["coin"].toString());

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "email": email,
        "username": username,
        // ?? operator is if first variable is null, then choose second(right side) variable instead.
        "role": role ?? "",
        "phone": phone ?? "",
        "address": address ?? "",
        "coin": coin ?? 0
      };
}
