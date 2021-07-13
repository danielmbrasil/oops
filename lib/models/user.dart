// User Model

class User {
  final String email;
  final String name;
  final String token;
  final int xp;
  final int currentLevel;
  final int correctAnswers;

  User(
      {this.email,
      this.name,
      this.token,
      this.xp,
      this.currentLevel,
      this.correctAnswers});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'],
        email: json['email'],
        token: json['token'],
        xp: json['xp'],
        currentLevel: json['current_level'],
        correctAnswers: json['correct_answers']);
  }

  String getEmail() {
    return this.email;
  }

  String getName() {
    return this.name;
  }

  int getXp() {
    return this.xp;
  }

  int getCurrentLevel() {
    return this.currentLevel;
  }

  int getCorrectAnswers() {
    return this.correctAnswers;
  }
}
