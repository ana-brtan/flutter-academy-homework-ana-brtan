// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Show _$ShowFromJson(Map<String, dynamic> json) => Show(
      json['id'] as String,
      json['title'] as String,
      json['description'] as String,
      json['no_of_reviews'] as int,
      (json['average_rating'] as num).toDouble(),
      json['image_url'] as String?,
    );

Map<String, dynamic> _$ShowToJson(Show instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'no_of_reviews': instance.numOfReviews,
      'average_rating': instance.averageRating,
      'image_url': instance.imageUrl,
    };
