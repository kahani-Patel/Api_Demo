import 'dart:convert';

/// imageUrl : "https://loremflickr.com/640/480"
/// title : "Lesch and Sons"
/// id : "1"

CategoryListModel categoryListModelFromJson(String str) =>
    CategoryListModel.fromJson(json.decode(str));

String categoryListModelToJson(CategoryListModel data) =>
    json.encode(data.toJson());

class CategoryListModel {
  CategoryListModel({
    String? imageUrl,
    String? title,
    String? id,
  }) {
    _imageUrl = imageUrl;
    _title = title;
    _id = id;
  }

  CategoryListModel.fromJson(dynamic json) {
    _imageUrl = json['imageUrl'];
    _title = json['title'];
    _id = json['id'];
  }

  String? _imageUrl;
  String? _title;
  String? _id;

  CategoryListModel copyWith({
    String? imageUrl,
    String? title,
    String? id,
  }) =>
      CategoryListModel(
        imageUrl: imageUrl ?? _imageUrl,
        title: title ?? _title,
        id: id ?? _id,
      );

  String? get imageUrl => _imageUrl;

  String? get title => _title;

  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['imageUrl'] = _imageUrl;
    map['title'] = _title;
    map['id'] = _id;
    return map;
  }
}
