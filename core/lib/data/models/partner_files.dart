import 'package:json_annotation/json_annotation.dart';
part 'partner_files.g.dart';

@JsonSerializable()
class PartnerFiles {
  final List<Files>? files;
  const PartnerFiles({this.files});
  PartnerFiles copyWith({List<Files>? files}) {
    return PartnerFiles(files: files ?? this.files);
  }

  factory PartnerFiles.fromJson(Map<String, dynamic> json) =>
      _$PartnerFilesFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerFilesToJson(this);

  @override
  String toString() {
    return '''PartnerFiles(
                files:${files.toString()}
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is PartnerFiles &&
        other.runtimeType == runtimeType &&
        other.files == files;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, files);
  }
}

@JsonSerializable()
class Files {
  final String? type;
  @JsonKey(name: 'is_shown')
  final bool? isShown;
  final String? url;
  @JsonKey(name: 'account_id')
  final String? accountId;
  const Files({this.type, this.isShown, this.url, this.accountId});
  Files copyWith(
      {String? type, bool? isShown, String? url, String? accountId}) {
    return Files(
        type: type ?? this.type,
        isShown: isShown ?? this.isShown,
        url: url ?? this.url,
        accountId: accountId ?? this.accountId);
  }

  factory Files.fromJson(Map<String, dynamic> json) => _$FilesFromJson(json);

  Map<String, dynamic> toJson() => _$FilesToJson(this);

  @override
  String toString() {
    return '''Files(
                type:$type,
isShown:$isShown,
url:$url,
accountId:$accountId
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Files &&
        other.runtimeType == runtimeType &&
        other.type == type &&
        other.isShown == isShown &&
        other.url == url &&
        other.accountId == accountId;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, type, isShown, url, accountId);
  }
}
