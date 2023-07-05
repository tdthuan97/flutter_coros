class User {
  String? name;
  String? gender;

//<editor-fold desc="Data Methods">
  User({
    this.name,
    this.gender,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          gender == other.gender);

  @override
  int get hashCode => name.hashCode ^ gender.hashCode;

  @override
  String toString() {
    return 'User{' + ' name: $name,' + ' gender: $gender,' + '}';
  }

  update({
    String? name,
    String? gender,
  }) {
    this.name = name ?? this.name;
    this.gender = gender ?? this.gender;
  }

  User copyWith({
    String? name,
    String? gender,
  }) {
    return User(
      name: name ?? this.name,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'gender': this.gender,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? "",
      gender: map['gender'] ?? "",
    );
  }

//</editor-fold>
}
// class User {
//   final String? name;
//   final String? gender;
//
//   static User? _singleton;
//
//   factory User() {
//     if (_singleton != null) {
//       return _singleton!;
//     } else {
//       return _singleton = User._internal(null,null);
//     }
//   }
//
//   User._internal(this.name, this.gender);
//
//   factory User.fromJson(Map<dynamic, dynamic> json) {
//     // name = json['name'];
//     // gender = json['gender'];
//     _singleton = User._internal(json['name'],json['gender']);
//     return _singleton!;
//   }
//
//   User copyWith({String? name,String? gender}){
//    _singleton = User._internal(name ?? this.name,gender ?? this.gender);
//     return _singleton!;
//   }
//
//   Map<dynamic, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['name'] = name;
//     data['gender'] = gender;
//     return data;
//   }
// }
