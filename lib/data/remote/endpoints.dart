import '../../helpers/storage_keys.dart';
const url ="https://api.themoviedb.org/3/person";
//const kAllPopular= '$url/popular?api_key=$apiKey&language=en-US&page=3';
String kAllPopular(int page )=>'$url/popular?api_key=$apiKey&language=en-US&page=$page';

String kPopularDetails(int person_id) => '$url/$person_id?api_key=$apiKey&language=en-US';
String kPopularImage(int person_id) => '$url/$person_id/images?api_key=$apiKey&language=en-US';