import 'package:json_annotation/json_annotation.dart';
part 'link_model.g.dart';

@JsonSerializable()
class Links {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  Links({this.first, this.last, this.prev, this.next});

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);

  @override
  String toString() {
    return 'Links{first: $first, last: $last, prev: $prev, next: $next}';
  }

  Links copyWith({
    String? first,
    String? last,
    String? prev,
    String? next,
  }) {
    return Links(
      first: first ?? this.first,
      last: last ?? this.last,
      prev: prev ?? this.prev,
      next: next ?? this.next,
    );
  }
}
