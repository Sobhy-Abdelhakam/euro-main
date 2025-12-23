part of 'about_us_cubit.dart';

abstract class AboutUsState {}

class AboutUsInitial extends AboutUsState {}

class AboutUsLoading extends AboutUsState {}

class AboutUsError extends AboutUsState {}

class AboutUsLoaded extends AboutUsState {
  String data;
  AboutUsLoaded({required this.data});
}
