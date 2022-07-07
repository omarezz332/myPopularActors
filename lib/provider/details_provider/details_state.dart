
abstract class DetailsState {
  const DetailsState();
}

class DetailsInitial extends DetailsState {
  const DetailsInitial();
}

class DetailsLoading extends DetailsState {
  const DetailsLoading();
}

class DetailsGot extends DetailsState {
  const DetailsGot();

}
class DetailsError extends DetailsState {
  final String message;
  const DetailsError(this.message);
}

