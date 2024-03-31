import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/jobs_and_intern_card.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_applications/get_my_applications_bloc.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_applications/get_my_applications_event.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_applications/get_my_applications_state.dart';

class MyApplicationsItem extends StatefulWidget {
  const MyApplicationsItem({super.key, required this.type});

  final int type;

  @override
  State<MyApplicationsItem> createState() => _MyApplicationsItemState();
}

class _MyApplicationsItemState extends State<MyApplicationsItem> {
  @override
  void initState() {
    BlocProvider.of<GetMyApplicationsBloc>(context)
        .add(GetMyApplicationsEvent(widget.type.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMyApplicationsBloc, GetMyApplicationsState>(
      builder: (context, state) {
        if(state is GetMyApplicationsSuccessMessageState) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: state.jobModel.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(AppSize.defaultSize! * .5),
                child: JobsAndInternCard(
                  text: StringManager.viewDetails.tr(),
                  vacancyModel:  state.jobModel[index],
                )
                    .animate()
                    .fadeIn() // uses `Animate.defaultDuration`
                    .scale() // inherits duration from fadeIn
                    .move(delay: 300.ms, duration: 600.ms),
              );
            });
        }
        else   if(state is GetMyApplicationsErrorMessageState){
          return ErrorWidget(state.errorMessage);
        }
        else   if(state is GetMyApplicationsLoadingState){
          return const LoadingWidget();
        }
        else{
          return const SizedBox();
        }
      },
    );
  }
}
