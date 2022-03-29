// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddReview _$AddReviewFromJson(Map<String, dynamic> json) => AddReview(
      json['comment'] as String,
      json['rating'] as int,
      json['show_id'] as String,
    );

Map<String, dynamic> _$AddReviewToJson(AddReview instance) => <String, dynamic>{
      'comment': instance.comment,
      'rating': instance.rating,
      'show_id': instance.show_id,
    };
