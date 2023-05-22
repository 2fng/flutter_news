import '../../data/datasources/local/app_database.dart';
import '../models/article.dart';
import 'database_repository.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final AppDatabase _appDatabase;

  DatabaseRepositoryImpl(this._appDatabase);

  @override
  Future<List<Article>> getSavedArticles() async {
    return _appDatabase.articleDao.getAllArticles();
  }

  @override
  Future<void> removeArticle(Article article) {
    return _appDatabase.articleDao.deleteArticle(article);
  }

  @override
  Future<void> saveArticles(Article article) {
    return _appDatabase.articleDao.insertArticle(article);
  }
}
