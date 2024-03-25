import 'package:gql/ast.dart';
import 'package:gql/language.dart';

DocumentNode parseNode(String query) => transform(parseString(query), []);
