import 'package:json_annotation/json_annotation.dart';
part 'known_for_popular.g.dart';
@JsonSerializable(explicitToJson: true)
class KnownFor {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? mediaType;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
  String? firstAirDate;
  String? name;
  List<String>? originCountry;
  String? originalName;

  KnownFor(
      {this.adult,
        this.backdropPath,
        this.genreIds,
        this.id,
        this.mediaType,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.posterPath,
        this.releaseDate,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount,
        this.firstAirDate,
        this.name,
        this.originCountry,
        this.originalName});
  factory KnownFor.fromJson(Map<String, dynamic> json) =>
      _$KnownForPopularFromJson(json);
  Map<String, dynamic> toJson() => _$KnownForPopularToJson(this);





}