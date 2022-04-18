import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:tv_shows/views/show%20screen/components/shows_list.dart';

void main() {
  testGoldens('ShowsList', (tester) async {
    mockNetworkImagesFor(() async {
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
        body: ShowsList(
          shows: [],
        ),
      )));

      await expectLater(find.byType(ShowsList), matchesGoldenFile("ShowList.png"));
    });
  });
}
