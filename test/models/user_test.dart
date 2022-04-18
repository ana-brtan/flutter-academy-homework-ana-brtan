import 'package:flutter_test/flutter_test.dart';
import 'package:tv_shows/models/user.dart';

void main() {
  test("User values", () {
    final user = User("User", "asd@gmail.com", "asgfdas");

    expect(user.email, "asd@gmail.com");
    expect(user.id, "User");
    expect(user.imageUrl, "asgfdas");
  });

  test("User values null or notNull", () {
    final user = User("User", "asd@gmail.com", null);

    expect(user.email, isNotNull);
    expect(user.id, isNotNull);
    expect(user.imageUrl, isNull);
  });
}
