import 'package:equatable/equatable.dart';

abstract class OptionsEvent extends Equatable {
  const OptionsEvent();

  @override
  List<Object> get props => [];
}

class GetMajorEvent extends OptionsEvent {
  const GetMajorEvent();
}

class GetUniversityEvent extends OptionsEvent {
  const GetUniversityEvent();
}

class GetCitiesEvent extends OptionsEvent {
  const GetCitiesEvent();
}
