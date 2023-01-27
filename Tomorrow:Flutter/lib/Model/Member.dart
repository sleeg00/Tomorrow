class Member {
  // ignore: non_constant_identifier_names
  int? member_id;
  String? id;
  String? pw;

  Member({
    required this.id,
    required this.pw,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      pw: json['pw'],
    );
  }
}
