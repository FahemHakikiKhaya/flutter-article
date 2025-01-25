import 'dart:convert';
import 'package:flutter/material.dart';
import 'article_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ArticleScreen(),
    );
  }
}

class ArticleScreen extends StatelessWidget {
  // Simulated JSON response
  final String jsonString = '''
  {
    "data": [{
      "type": "articles",
      "id": "1",
      "attributes": {
        "title": "JSON:API paints my bikeshed!"
      },
      "relationships": {
        "author": {
          "links": {
            "self": "http://example.com/articles/1/relationships/author",
            "related": "http://example.com/articles/1/author"
          },
          "data": { "type": "people", "id": "9" }
        },
        "comments": {
          "links": {
            "self": "http://example.com/articles/1/relationships/comments",
            "related": "http://example.com/articles/1/comments"
          },
          "data": [
            { "type": "comments", "id": "5" },
            { "type": "comments", "id": "12" }
          ]
        }
      },
      "links": {
        "self": "http://example.com/articles/1"
      }
    }]
  }
  ''';

  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Decode the JSON data
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);
    final articleJson = jsonData['data'][0];
    final article = Article.fromJson(articleJson);

    // Build the UI
    return Scaffold(
      appBar: AppBar(title: const Text('Article Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("Title: ${article.title}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Author ID: ${article.authorId}",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            const Text("Article Links:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text("- Self: http://example.com/articles/1",
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            const Text("Author Links:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text(
                "- Self: http://example.com/articles/1/relationships/author",
                style: TextStyle(fontSize: 16)),
            const Text("- Related: http://example.com/articles/1/author",
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            const Text("Comments Links:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text(
                "- Self: http://example.com/articles/1/relationships/comments",
                style: TextStyle(fontSize: 16)),
            const Text("- Related: http://example.com/articles/1/comments",
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            const Text("Comments:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...article.commentIds.map((id) => Text("- Comment ID: $id",
                style: const TextStyle(fontSize: 16))),
          ],
        ),
      ),
    );
  }
}
