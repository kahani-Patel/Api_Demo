class UserModel {
  late String _name;
  late String _Dob;
  late String _City;
  late String _id;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get Dob => _Dob;

  set Dob(String value) {
    _Dob = value;
  }

  String get City => _City;

  set City(String value) {
    _City = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}