part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.loading() = Loading;
  const factory HomeState.ready(
      {required List<Post> posts,
      required int cat,
      required int postLen}) = Ready;
  const factory HomeState.error({required String error}) = Error;
}
