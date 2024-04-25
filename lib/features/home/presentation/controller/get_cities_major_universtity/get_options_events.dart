import 'package:equatable/equatable.dart';

abstract class OptionsEvent extends Equatable {
  const OptionsEvent();

  @override
  List<Object> get props => [];
}

class GetFacultyEvent extends OptionsEvent {
  final int id;
  const GetFacultyEvent(this.id);
}

class GetUniversityEvent extends OptionsEvent {
  const GetUniversityEvent();
}

class GetCitiesEvent extends OptionsEvent {
  const GetCitiesEvent();
}
