part of 'terms_of_use_cubit.dart';

abstract class TermsOfUseState {}

class TermsOfUseInitial extends TermsOfUseState {}

class TermsOfUseLoading extends TermsOfUseState {}

class TermsOfUseError extends TermsOfUseState {}

class TermsOfUseLoaded extends TermsOfUseState {
  String data;
  TermsOfUseLoaded({required this.data});
}
