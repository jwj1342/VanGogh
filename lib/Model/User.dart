class User {
  String? loginName;
  String? bio;
  String? avatarUrl;
  int? following;
  int? likes;
  int? collects;

  User(
      {this.loginName,
        this.bio,
        this.avatarUrl,
        this.following,
        this.likes,
        this.collects});

  User.fromJson(Map<String, dynamic> json) {
    loginName = json['username'];
    bio = json['bio?'];
    avatarUrl = json['avatar_url'];
    following = json['following'];
    likes = json['likes'];
    collects = json['collects'];
  }






  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['login_name'] = loginName;
    data['bio?'] = bio;
    data['avatar_url'] = avatarUrl;
    data['following'] = following;
    data['likes'] = likes;
    data['collects'] = collects;
    return data;
  }
  // @override
  // String toString() {
  //   return 'User{loginName: \$loginName}';
  // }
}