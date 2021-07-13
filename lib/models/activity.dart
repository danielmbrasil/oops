// Activity model

class Activity {
  final String title;
  final String body;
  final int xp;

  Activity({this.title, this.body, this.xp});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      title: json['title'],
      body: json['body'],
      xp: json['xp']
    );
  }

  // getters

  String getTitle() {
    return this.title;
  }

  String getBody() {
    return this.body;
  }

  int getXP() {
    return this.xp;
  }
}