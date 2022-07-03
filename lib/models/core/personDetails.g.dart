// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonDetails _$PersonDetailsFromJson(Map<String, dynamic> json) =>
    PersonDetails(
      adult: json['adult'] as bool?,
      alsoKnownAs: (json['alsoKnownAs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      biography: json['biography'] as String?,
      birthday: json['birthday'] as String?,
      deathday: json['deathday'] as String?,
      gender: json['gender'] as int?,
      homepage: json['homepage'] as String?,
      id: json['id'] as int?,
      imdbId: json['imdbId'] as String?,
      knownForDepartment: json['knownForDepartment'] as String?,
      name: json['name'] as String?,
      placeOfBirth: json['placeOfBirth'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      profilePath: json['profilePath'] as String?,
    );

Map<String, dynamic> _$PersonDetailsToJson(PersonDetails instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'alsoKnownAs': instance.alsoKnownAs,
      'biography': instance.biography,
      'birthday': instance.birthday,
      'deathday': instance.deathday,
      'gender': instance.gender,
      'homepage': instance.homepage,
      'id': instance.id,
      'imdbId': instance.imdbId,
      'knownForDepartment': instance.knownForDepartment,
      'name': instance.name,
      'placeOfBirth': instance.placeOfBirth,
      'popularity': instance.popularity,
      'profilePath': instance.profilePath,
    };
