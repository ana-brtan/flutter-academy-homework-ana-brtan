import 'package:flutter/material.dart';
import 'package:tv_shows/app.dart';
import 'package:tv_shows/net/storage_repository.dart';

void main() async {
  await StorageRepository.initialize();
  runApp(const TVShowsApp());
}
