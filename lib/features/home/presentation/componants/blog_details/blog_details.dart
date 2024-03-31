import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/features/home/presentation/componants/blog_details/blog_complete.dart';
import 'package:inturn/features/home/presentation/componants/blog_details/merchants_stores.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BlogDetails extends StatelessWidget {
  const BlogDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context, text: StringManager.blogs.tr()),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSize.defaultSize!,),
          Expanded(
            child: ListView.builder(
                itemCount: 15,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(AppSize.defaultSize!),
                    child: InkWell(
                      onTap: (){
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const BlogComplete(),
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      child: MerchantsStores(
                        blog: true,
                        merchants: Merchants(
                            text: 'BURGER KING INDONESIA',
                            description:
                            'Burger King Corporation is an American multinational chain of hamburger fast food restaurants.',
                            image: AssetPath.blogImage),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
