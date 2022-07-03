
import 'package:my_poupular_actors/models/core/popular_person.dart';

abstract class PopularState {
  const PopularState();
}

class PopularInitial extends PopularState {
  const PopularInitial();
}

class PopularLoading extends PopularState {
  const PopularLoading();
}

class PopularGot extends PopularState {

  const PopularGot();
}

