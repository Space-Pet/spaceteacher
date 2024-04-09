import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/link_model.dart';
part 'meta_model.g.dart';

@JsonSerializable()
class Meta {
  final int? current_page;
  final int? from;
  final int? last_page;
  final String? path;
  final int? per_page;
  final int? to;
  final int? total;
  final List<Links>? links;
  Meta({
    this.current_page,
    this.from,
    this.last_page,
    this.path,
    this.per_page,
    this.to,
    this.total,
    this.links,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);

  @override
  String toString() {
    return 'Meta{current_page: $current_page, from: $from, last_page: $last_page, path: $path, per_page: $per_page, to: $to, total: $total, links: $links}';
  }

  Meta copyWith({
    int? current_page,
    int? from,
    int? last_page,
    String? path,
    int? per_page,
    int? to,
    int? total,
    List<Links>? links,
  }) {
    return Meta(
      current_page: current_page ?? this.current_page,
      from: from ?? this.from,
      last_page: last_page ?? this.last_page,
      path: path ?? this.path,
      per_page: per_page ?? this.per_page,
      to: to ?? this.to,
      total: total ?? this.total,
      links: links ?? this.links,
    );
  }
}
