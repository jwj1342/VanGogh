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
    loginName = json['login_name'];
    bio = json['bio?'];
    avatarUrl = json['avatar_url'];
    following = json['following'];
    likes = json['likes'];
    collects = json['collects'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login_name'] = this.loginName;
    data['bio?'] = this.bio;
    data['avatar_url'] = this.avatarUrl;
    data['following'] = this.following;
    data['likes'] = this.likes;
    data['collects'] = this.collects;
    return data;
  }
}