import '../models/article.dart';

abstract class DatabaseRepository {
  Future<List<Article>> getSavedArticles();

  Future<void> saveArticles(Article article);

  Future<void> removeArticle(Article article);
}
