// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      json['id'] as String,
      json['comment'] as String,
      json['rating'] as int,
      User.fromJson(json['user'] as Map<String, dynamic>),
      json['show_id'] as int,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'rating': instance.rating,
      'show_id': instance.showId,
      'user': instance.user,
    };
