/// Data model representing a post API response.
class PostResponse {
  final int id;
  final String title;
  final String body;

  PostResponse({required this.id, required this.title, required this.body});

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
