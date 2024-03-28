bool isNullOrEmpty(dynamic s) {
  if (s != null && s is String) s = s.trim();
  try {
    return s == null || s.isEmpty;
  } catch (_) {
    return s == null;
  }
}

String getUrlWithQuery(String url, Map<String, dynamic> query) {
  final result = StringBuffer();
  if (query.isNotEmpty) {
    result.write(url);
    result.write('?');
    for (var i = 0; i < query.length; i++) {
      if (i != 0) result.write('&');
      result.write(query.keys.elementAt(i));
      result.write('=');
      result.write(Uri.encodeComponent('${query.values.elementAt(i)}'));
    }
    return result.toString();
  }
  return url;
}

List<String> splitByLength(String value, int length) {
  final logList = <String>[];
  if (value.length <= length) {
    logList.add(value);
  } else {
    final size = (value.length / length).ceil();
    var startIndex = 0;
    var endIndex = startIndex + length;
    for (var i = 0; i < size; i++) {
      logList.add(value.substring(startIndex, endIndex));
      startIndex = endIndex;
      endIndex = startIndex + length;
      if (endIndex > value.length) endIndex = value.length;
    }
  }
  return logList;
}
