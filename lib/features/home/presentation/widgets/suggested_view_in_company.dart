import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/empty_widget.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/features/home/data/model/matched_model.dart';
import 'package:inturn/features/home/presentation/controller/suggested%20jobs%20in%20company/bloc.dart';
import 'package:inturn/features/home/presentation/controller/suggested%20jobs%20in%20company/event.dart';
import 'package:inturn/features/home/presentation/controller/suggested%20jobs%20in%20company/state.dart';

import 'package:inturn/features/home/presentation/widgets/job_cart.dart';
class SuggestedInCompanyView extends StatefulWidget {
  const SuggestedInCompanyView({super.key, required this.companyId, required this.vacancyId});
  final int companyId;
  final int vacancyId;

  @override
  State<SuggestedInCompanyView> createState() => _SuggestedInCompanyViewState();
}

class _SuggestedInCompanyViewState extends State<SuggestedInCompanyView> {
  @override
  void initState() {
    BlocProvider.of<SuggestedJobsInCompanyBloc>(context)
        .add(GetSuggestedInCompanyBySearchEvent (
      companyId: widget.companyId,
    ));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<SuggestedJobsInCompanyBloc,
        SuggestedInCompanyState>(
      builder: (context, state) {
        if (state is GetSuggestedInCompanyBySearchLoadingState) {
          return const LoadingWidget();
        } else if (state
        is GetSuggestedInCompanyBySearchSuccessMessageState) {

          if(state.vacancyModel.isEmpty){
            return const EmptyWidget(text: 'No more jobs related',);
          }
          return ListView.builder(
              itemCount:  state.vacancyModel.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (item, index) {

                  return Padding(
                    padding: EdgeInsets.all(AppSize.defaultSize! * 1.2),
                    child: JobCart(
                      vacancyModel: MatchedVacancyWrapper(
                        matchedVacancy: MatchedVacancy(
                          vacancyId:
                          state.vacancyModel[index].vacancyId,
                          title: state.vacancyModel[index].title,
                          companyId:
                          state.vacancyModel[index].companyId,
                          company: state.vacancyModel[index].company,
                          cityName: state.vacancyModel[index].cityName,
                          vacancyLevelId:
                          state.vacancyModel[index].vacancyLevelId,
                          requirements:
                          state.vacancyModel[index].requirements,
                          responsibilities: state
                              .vacancyModel[index].responsibilities,
                        ),
                        matchmakingPercentage: 0,
                      ),
                    )
                        .animate()
                        .fadeIn() // uses `Animate.defaultDuration`
                        .scale() // inherits duration from fadeIn
                        .move(delay: 300.ms, duration: 600.ms),
                  );


              });
        } else if (state is GetSuggestedInCompanyBySearchErrorMessageState) {
          return ErrorWidget(state.errorMessage);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
