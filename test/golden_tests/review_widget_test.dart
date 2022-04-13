import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:tv_shows/models/review.dart';
import 'package:tv_shows/models/user.dart';
import 'package:tv_shows/views/show_details_screen/components/reviews.dart';

void main() {
  testGoldens('ReviewWidget', (tester) async {
    mockNetworkImagesFor(() async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ReviewWidget(
              index: 32,
              review: Review(
                  "23",
                  "comment",
                  23,
                  User("23", "email",
                      "https://images.unsplash.com/photo-1615789591457-74a63395c990?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmFieSUyMGNhdHxlbnwwfHwwfHw%3D&w=1000&q=80"),
                  23)),
        ),
      ));

      await expectLater(find.byType(ReviewWidget), matchesGoldenFile("review.png"));
    });
  });
}
