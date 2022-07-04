// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'known_for_popular.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KnownFor _$KnownForFromJson(Map<String, dynamic> json) => KnownFor(
      adult: json['adult'] as bool?,
      backdropPath: json['backdropPath'] as String?,
      genreIds:
          (json['genreIds'] as List<dynamic>?)?.map((e) => e as int).toList(),
      id: json['id'] as int?,
      mediaType: json['mediaType'] as String?,
      originalLanguage: json['originalLanguage'] as String?,
      originalTitle: json['originalTitle'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['posterPath'] as String?,
      releaseDate: json['releaseDate'] as String?,
      title: json['title'] as String?,
      video: json['video'] as bool?,
      voteAverage: (json['voteAverage'] as num?)?.toDouble(),
      voteCount: json['voteCount'] as int?,
      firstAirDate: json['firstAirDate'] as String?,
      name: json['name'] as String?,
      originCountry: (json['originCountry'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      originalName: json['originalName'] as String?,
    );

Map<String, dynamic> _$KnownForToJson(KnownFor instance) => <String, dynamic>{
      'adult': instance.adult,
      'backdropPath': instance.backdropPath,
      'genreIds': instance.genreIds,
      'id': instance.id,
      'mediaType': instance.mediaType,
      'originalLanguage': instance.originalLanguage,
      'originalTitle': instance.originalTitle,
      'overview': instance.overview,
      'posterPath': instance.posterPath,
      'releaseDate': instance.releaseDate,
      'title': instance.title,
      'video': instance.video,
      'voteAverage': instance.voteAverage,
      'voteCount': instance.voteCount,
      'firstAirDate': instance.firstAirDate,
      'name': instance.name,
      'originCountry': instance.originCountry,
      'originalName': instance.originalName,
    };
