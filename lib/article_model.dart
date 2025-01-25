class Article {
  final String id;
  final String title;
  final String authorId;
  final List<String> commentIds;
  final Map<String, String> authorLinks;
  final Map<String, String> commentLinks;
  final String articleLink;

  Article({
    required this.id,
    required this.title,
    required this.authorId,
    required this.commentIds,
    required this.authorLinks,
    required this.commentLinks,
    required this.articleLink,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    final relationships = json['relationships'];
    final authorId = relationships['author']['data']['id'];
    final commentIds = (relationships['comments']['data'] as List)
        .map((comment) => comment['id'].toString())
        .toList();

    final authorLinks = {
      'self': relationships['author']['links']['self'].toString(),
      'related': relationships['author']['links']['related'].toString(),
    };

    final commentLinks = {
      'self': relationships['comments']['links']['self'].toString(),
      'related': relationships['comments']['links']['related'].toString(),
    };

    final articleLink = json['links']['self'].toString();

    return Article(
      id: json['id'].toString(),
      title: json['attributes']['title'].toString(),
      authorId: authorId.toString(),
      commentIds: commentIds,
      authorLinks: authorLinks,
      commentLinks: commentLinks,
      articleLink: articleLink,
    );
  }
}
