import 'package:flutter/material.dart';
import 'package:news/models/articale.dart';
import 'package:news/util/export.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class SavedArticlesDB {
  final String dbName;
  final int dbVersion;
  Database? _db;

  SavedArticlesDB({required this.dbName, required this.dbVersion});

  Future<bool> open() async {
    if (_db != null) {
      return true;
    } else {
      final dbDirectory = await getApplicationDocumentsDirectory();
      final path = join(dbDirectory.path, dbName);

      try {
        final db = await openDatabase(path, version: dbVersion);
        _db = db;

        // const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
        const textNotNull = "TEXT NOT NULL";
        const text = "TEXT";

        await db.execute('''
CREATE TABLE IF NOT EXISTS savedArticlesTable (
${ArticleFields.title} $textNotNull,
${ArticleFields.description} $text,
${ArticleFields.url} $textNotNull,
${ArticleFields.urlToImage} $text,
${ArticleFields.sourceName} $textNotNull,
${ArticleFields.publishedAt} $textNotNull
);
''');
        log.d("opening database success");
        await fetchArticles();
        return true;
      } catch (e) {
        log.e("opening database error = $e");
        return false;
      }
    }
  }

  Future<bool> close() async {
    if (_db == null) {
      return false;
    } else {
      await _db!.close();
      return true;
    }
  }

  Future<bool> fetchArticles() async {
    if (_db == null) {
      return false;
    } else {
      try {
        final noteMaps = await _db!.query("savedArticlesTable",
            columns: ArticleFields.values, orderBy: ArticleFields.publishedAt);
        articles = noteMaps
            .map((json) {
              return Article.fromJson(json);
            })
            .toList()
            .reversed
            .toList();

        log.d("fetching articles success length ${articles.length}");
        return true;
      } catch (e) {
        log.e("fetching articles error $e");
        return false;
      }
    }
  }

  Future<bool> insertArticle(
    BuildContext context, {
    required String title,
    required String? description,
    required String url,
    required String? urlToImage,
    required String sourceName,
    required String publishedAt,
  }) async {
    if (_db == null) {
      return false;
    } else {
      try {
        await _db!.insert(
          "savedArticlesTable",
          {
            ArticleFields.title: title,
            ArticleFields.description: description,
            ArticleFields.url: url,
            ArticleFields.urlToImage: urlToImage,
            ArticleFields.sourceName: sourceName,
            ArticleFields.publishedAt: publishedAt,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        final newArticle = Article(
            title: title,
            description: description,
            url: url,
            urlToImage: urlToImage,
            source: Source(sourceName),
            publishedAt: publishedAt);

        articles.insert(0, newArticle);
        Provider.of<Refresh>(listen: false, context).refresh();

        log.d("article inserted ");
        return true;
      } catch (e) {
        log.e("insert article error $e");
        return false;
      }
    }
  }

  Future<bool> deleteArticle(Article art, BuildContext context) async {
    if (_db == null) {
      return false;
    } else {
      try {
        final deletedCount = await _db!.delete(
          "savedArticlesTable",
          where:
              "${ArticleFields.title} = ? AND ${ArticleFields.description} = ? And ${ArticleFields.publishedAt} = ? AND ${ArticleFields.sourceName} = ? AND ${ArticleFields.url} = ? AND ${ArticleFields.urlToImage} = ?",
          whereArgs: [
            art.title,
            art.description,
            art.publishedAt,
            art.source.name,
            art.url,
            art.urlToImage
          ],
        );

        log.d("delete article success");

        return true;
      } catch (e) {
        log.e("delete article error $e");
        return false;
      }
    }
  }

  Future<bool> clearAll(BuildContext context) async {
    if (_db == null) {
      return false;
    } else {
      try {
        articles.clear();
        await _db!.delete("savedArticlesTable");
        Provider.of<Refresh>(listen: false, context).refresh();
        log.d("clear success");

        return true;
      } catch (e) {
        log.e("clear all error $e");
        return false;
      }
    }
  }
}
