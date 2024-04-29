import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/features/home/presentation/controller/company_bloc/get_companies_bloc.dart';
import 'package:inturn/features/home/presentation/controller/company_bloc/get_companies_state.dart';
import 'package:inturn/features/home/presentation/widgets/company_cart.dart';

class CompaniesScreen extends StatelessWidget {
  const CompaniesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, text: StringManager.companies.tr(), leading: false),
      body: Column(children: [
        BlocBuilder<GetCompaniesBloc, GetCompaniesState>(
          builder: (context, state) {
            if (state is GetCompaniesSuccessMessageState) {
              return Expanded(
                child: ListView.builder(
                    itemCount: state.jobModel.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (item, index) {
                      return Padding(
                        padding: EdgeInsets.all(AppSize.defaultSize! * 1.2),
                        child: CompanyCart(data: state.jobModel[index])
                            .animate()
                            .fadeIn() // uses `Animate.defaultDuration`
                            .scale() // inherits duration from fadeIn
                            .move(delay: 300.ms, duration: 600.ms),
                      );
                    }),
              );
            } else if (state is GetCompaniesErrorMessageState) {
              return ErrorWidget(state.errorMessage);
            } else if (state is GetCompaniesLoadingState) {
              return const LoadingWidget();
            } else {
              return const SizedBox();
            }
          },
        ),
      ]),
    );
  }
}
