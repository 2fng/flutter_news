import 'package:floor/floor.dart';
import 'package:flutter_news/src/data/datasources/local/articles_dao.dart';
import 'package:flutter_news/src/data/datasources/local/converters/source_type_converter.dart';

import '../../../domain/models/article.dart';

part 'app_database.g.dart';

@TypeConverters([SourceTypeConverter])
@Database(version: 1, entities: [Article])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDao;
}
