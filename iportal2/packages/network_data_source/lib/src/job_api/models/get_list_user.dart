class GetListUser {
  final int? pk;
  final String userName;

  GetListUser({
    required this.pk,
    required this.userName
});
  factory GetListUser.fromMap(Map<String, dynamic> map){
    return GetListUser(
        pk: map['pk'] ?? '',
        userName: map['username'] ?? ''
    );
  }
}