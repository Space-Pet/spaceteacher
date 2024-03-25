import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  String? id;
  String? name;
  String? url;
  @JsonKey(name: 'featured_image_url')
  String? featuredImageUrl;
  @JsonKey(name: 'content_html')
  String? contentHtml;
  String? content;
  @JsonKey(name: 'published_at')
  DateTime? publishedAt;
  String? slug;
  @JsonKey(name: 'name_en')
  String? nameEn;
  @JsonKey(name: 'content_html_en')
  String? contentHtmlEn;
  @JsonKey(name: 'url_en')
  String? urlEn;
  @JsonKey(name: 'content_en')
  String? contentEn;

  Post({
    this.id,
    this.name,
    this.url,
    this.featuredImageUrl,
    this.contentHtml,
    this.content,
    this.publishedAt,
    this.slug,
    this.contentEn,
    this.nameEn,
    this.urlEn,
    this.contentHtmlEn,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
