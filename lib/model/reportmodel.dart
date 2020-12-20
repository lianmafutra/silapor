class ReportModel {
  String id;
  String title;
  String content;
  String category;
  String createdAt;
  String image;
  String userId;

  ReportModel(
      {this.id,
      this.title,
      this.content,
      this.category,
      this.createdAt,
      this.image,
      this.userId});

  ReportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    category = json['category'];
    createdAt = json['created_at'];
    image = json['image'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['category'] = this.category;
    data['created_at'] = this.createdAt;
    data['image'] = this.image;
    data['user_id'] = this.userId;
    return data;
  }
}