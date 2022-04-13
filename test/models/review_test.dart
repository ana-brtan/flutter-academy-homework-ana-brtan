import 'package:flutter_test/flutter_test.dart';
import 'package:tv_shows/models/review.dart';
import 'package:tv_shows/models/user.dart';

void main() {
  test("Review values", () {
    final review = Review("1", "comment", 3, User("1", "asdfg@gmail.com", "asdfg"), 223);

    expect(review.id, "1");
    expect(review.comment, "comment");
    expect(review.showId, 223);
  });
}
