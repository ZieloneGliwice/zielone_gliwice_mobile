class UserData {
  UserData(this.name, this.photoUrl, this.email);

  final String? name;
  final String? photoUrl;
  final String? email;

  String get firstName => name?.split(' ').first ?? '';
}
