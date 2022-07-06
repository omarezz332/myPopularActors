// an abstract class for checking populars state
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

