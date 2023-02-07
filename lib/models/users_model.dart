class Users {
  Users(
      {required this.mobileNumber,
      required this.online,
      required this.status,
      required this.profilePicUrl,
      required this.fname,
      required this.lname});

  Users.fromJson(Map<String, Object?> json)
      : this(
            fname: json['fname']! as String,
            lname: json['lname']! as String,
            mobileNumber: json['mobile_no']! as int,
            online: json['online']! as bool,
            status: json['status']! as String,
            profilePicUrl: json['profilePicUrl']! as String);

  final String fname;
  final String lname;
  final int mobileNumber;
  final bool online;
  final String status;
  final String profilePicUrl;

  Map<String, Object?> toJson() {
    return {
      'fname': fname,
      'lname': lname,
      'mobile_no': mobileNumber,
      'online': online,
      'status': status,
      'profilePicUrl': profilePicUrl
    };
  }
}
