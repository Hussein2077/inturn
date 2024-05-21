import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/empty_widget.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/matrial_widget.dart';
import 'package:inturn/features/home/data/model/company_model.dart';
import 'package:inturn/features/home/data/model/matched_model.dart';
import 'package:inturn/features/home/presentation/controller/apply_bloc/get_jobs_bloc.dart';
import 'package:inturn/features/home/presentation/controller/apply_bloc/get_jobs_event.dart';
import 'package:inturn/features/home/presentation/controller/apply_bloc/get_jobs_state.dart';
import 'package:inturn/features/home/presentation/controller/get_my_applications/get_my_applications_bloc.dart';
import 'package:inturn/features/home/presentation/controller/get_my_applications/get_my_applications_event.dart';
import 'package:inturn/features/home/presentation/controller/intern_search_bloc/get_internships_search_bloc.dart';
import 'package:inturn/features/home/presentation/controller/intern_search_bloc/get_internships_search_event.dart';
import 'package:inturn/features/home/presentation/controller/intern_search_bloc/get_internships_search_state.dart';
import 'package:inturn/features/home/presentation/controller/suggested/bloc.dart';
import 'package:inturn/features/home/presentation/controller/suggested/event.dart';
import 'package:inturn/features/home/presentation/controller/suggested/state.dart';
import 'package:inturn/features/home/presentation/controller/vacancy_details_bloc/bloc.dart';
import 'package:inturn/features/home/presentation/controller/vacancy_details_bloc/event.dart';
import 'package:inturn/features/home/presentation/controller/vacancy_details_bloc/state.dart';
import 'package:inturn/features/home/presentation/widgets/company_cart.dart';
import 'package:inturn/features/home/presentation/widgets/job_cart.dart';
import 'package:inturn/main.dart';
class SuggestedView extends StatefulWidget {
  const SuggestedView({super.key, required this.companyId, required this.vacancyId});
final int companyId;
final int vacancyId;

  @override
  State<SuggestedView> createState() => _SuggestedViewState();
}

class _SuggestedViewState extends State<SuggestedView> {
  @override
  void initState() {
    BlocProvider.of<SuggestedBloc>(context)
        .add(GetSuggestedBySearchEvent(
      companyId: widget.companyId,
    ));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<SuggestedBloc,
        SuggestedState>(
      builder: (context, state) {

        if (state is GetSuggestedBySearchLoadingState) {
          return const LoadingWidget();
        } else if (state
        is GetSuggestedBySearchSuccessMessageState) {
          state.vacancyModel.removeWhere((element) => element.vacancyId == widget.vacancyId);

          if(state.vacancyModel.isEmpty){
            return const EmptyWidget(text: 'No more jobs related',);
          }
          return ListView.builder(
              itemCount: state.vacancyModel.isNotEmpty?state.vacancyModel.length-1: state.vacancyModel.length,
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
        } else if (state is GetSuggestedBySearchErrorMessageState) {
          return ErrorWidget(state.errorMessage);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
