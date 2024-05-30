import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inturn/core/models/profile_data_model.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
showCV(BuildContext context, ProfileDataModel profileDataModel) {
  return showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: AppSize.defaultSize! * 1.5,
          ),
          child: Dialog(
            alignment: Alignment.topRight,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.defaultSize! * 2),
            ),
            child: Container(
              // height: AppSize.screenHeight! * .9,
              // width: AppSize.screenWidth! * .95,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(AppSize.defaultSize!),
              ),
              child: CVPage(
                profileDataModel: profileDataModel,
              ),
            ),
          ),
        );
      });
}

class CVPage extends StatelessWidget {
  const CVPage({super.key, required this.profileDataModel});

  final ProfileDataModel profileDataModel;

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    final path = (await getExternalStorageDirectory())?.path;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/$fileName');
  }

//   Future<void> _createPDF() async {
//     PdfDocument document = PdfDocument();
//     PdfPage   page = document.pages.add();
//     page.graphics.drawImage(
//         PdfBitmap(await _readImageData(AssetPath.logoCv)),
//         Rect.fromLTWH(
//             -50, -20, page
//             .getClientSize()
//             .width, page
//             .getClientSize()
//             .height));
//     // page.graphics.drawImage(PdfBitmap(await _readImageData(AssetPath.logoCv)),
//     //     const Rect.fromLTWH(0, 0, 120, 120));
//     page.graphics.drawString(
//         '${profileDataModel.firstName} ${profileDataModel.lastName}',
//         PdfStandardFont(PdfFontFamily.helvetica, 30),
//         brush: PdfBrushes.black,
//         bounds: const Rect.fromLTWH(20, 130, 400, 40));
//     page.graphics.drawString(
//         (profileDataModel.description ?? 'description').length > 175 ? profileDataModel
//             .description!.substring(0, 175): (profileDataModel.description ?? 'description'),
//         PdfStandardFont(PdfFontFamily.helvetica, 20),
//         brush: PdfBrushes.gray, bounds: const Rect.fromLTWH(20, 180, 400, 300));
//     page.graphics.drawImage(
//         PdfBitmap(await _readImageData(AssetPath.cvContacts)),
//         const Rect.fromLTWH(20, 310, 30, 110));
//     page.graphics.drawString(
//         profileDataModel.user?.phoneNumber ?? "+201125391736",
//         PdfStandardFont(PdfFontFamily.helvetica, 20),
//         brush: PdfBrushes.black,
//         bounds: const Rect.fromLTWH(60, 320, 400, 300));
//     page.graphics.drawString(
//         profileDataModel.user?.email ?? "",
//         PdfStandardFont(PdfFontFamily.helvetica, 20),
//         brush: PdfBrushes.black,
//         bounds: const Rect.fromLTWH(60, 350, 400, 300));
//     page.graphics.drawString((profileDataModel.country?.countryNameEn ?? ""),
//         PdfStandardFont(PdfFontFamily.helvetica, 20),
//         brush: PdfBrushes.black,
//         bounds: const Rect.fromLTWH(60, 380 , 400, 300));
//     page.graphics.drawString(
//         'Education', PdfStandardFont(PdfFontFamily.helvetica, 25),
//         brush: PdfBrushes.black, bounds: const Rect.fromLTWH(20, 450, 400, 50));
//     page.graphics.drawString(profileDataModel.university?.universityName ?? "",
//         PdfStandardFont(PdfFontFamily.helvetica, 20),
//         brush: PdfBrushes.black, bounds: const Rect.fromLTWH(20, 480, 400, 50));
//     page.graphics.drawString(
//         profileDataModel.faculty?.name ?? "",
//         PdfStandardFont(PdfFontFamily.helvetica, 20),
//         brush: PdfBrushes.gray, bounds: const Rect.fromLTWH(20, 510, 400, 50));
//     // Create a PDF ordered list.
//     final PdfOrderedList orderedList = PdfOrderedList(
//       items: PdfListItemCollection(
//         <String>['Skills'],
//       ),
//       textIndent: 15,
//       indent: 15,
//       font: PdfStandardFont(PdfFontFamily.helvetica, 20),
//       marker: PdfOrderedMarker(
//         style: PdfNumberStyle.none,
//       ),
//       markerHierarchy: false,
//       format: PdfStringFormat(lineSpacing: 10),
//     );
//     orderedList.brush = PdfBrushes.black;
// // Create a un ordered list and add it as a sublist.
//
//     orderedList.items[0].subList = PdfUnorderedList(
//         marker: PdfUnorderedMarker(
//
//             font: PdfStandardFont(PdfFontFamily.helvetica, 12),
//             style: PdfUnorderedMarkerStyle.disk),
//         items: PdfListItemCollection(
//             profileDataModel.user?.userSkills?.map((e) => e.skill
//                 ?.skillNameEn ?? "").toList()),
//         font: PdfStandardFont(PdfFontFamily.helvetica, 12),
//         textIndent: 10,
//         format: PdfStringFormat(
//             lineSpacing: 10, lineAlignment: PdfVerticalAlignment.top),
//         indent: 20);
//     orderedList.draw(
//         page: page,
//         format: PdfLayoutFormat(
//           breakType: PdfLayoutBreakType.fitColumnsToPage,
//         ),
//         bounds: Rect.fromLTWH(
//             -15, 560, page
//             .getClientSize()
//             .width, page
//             .getClientSize()
//             .height));
//     if(profileDataModel.user!.userSkills!.length>6) {
//       var otherSkills=  profileDataModel.user?.userSkills?.sublist(7, profileDataModel.user?.userSkills?.length);
//       final PdfOrderedList orderedList2 = PdfOrderedList(
//         items: PdfListItemCollection(
//           <String>[' '],
//         ),
//         textIndent: 15,
//         indent: 15,
//         font: PdfStandardFont(PdfFontFamily.helvetica, 20),
//         marker: PdfOrderedMarker(
//           style: PdfNumberStyle.none,
//         ),
//         markerHierarchy: false,
//          format: PdfStringFormat(lineSpacing: 10),
//       );
//       orderedList2.brush = PdfBrushes.black;
//       orderedList2.items[0].subList = PdfUnorderedList(
//           marker: PdfUnorderedMarker(
//               font: PdfStandardFont(PdfFontFamily.helvetica, 12),
//               style: PdfUnorderedMarkerStyle.disk),
//           items: PdfListItemCollection(
//               (otherSkills)?.map((e) => e.skill
//                   ?.skillNameEn ?? "").toList()),
//           font: PdfStandardFont(PdfFontFamily.helvetica, 12),
//           textIndent: 10,
//           format: PdfStringFormat(
//               lineSpacing: 10, lineAlignment: PdfVerticalAlignment.top),
//           indent: 20);
//       orderedList2.draw(
//           page: page,
//           format: PdfLayoutFormat(
//             breakType: PdfLayoutBreakType.fitColumnsToPage,
//           ),
//           bounds: Rect.fromLTWH(
//               150, 560 , page
//               .getClientSize()
//               .width, page
//               .getClientSize()
//               .height));
//     }
//
//     List<int> bytes = await document.save();
//     document.dispose();
//     saveAndLaunchFile(bytes,
//         '${profileDataModel.firstName} ${profileDataModel.lastName}.pdf');
//   }
  void _printScreen() async {
    // List of pdf widgets
    final List<pw.Widget> widgets = [];

    widgets.add(
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 30),
        child: pw.Text(
          '${profileDataModel.firstName} ${profileDataModel.lastName}',
          style: pw.TextStyle(
            fontSize: 30,
            fontWeight: pw.FontWeight.normal,
          ),
        ),
      ),
    );
    widgets.add(
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: pw.Text(
            profileDataModel.description??"",
          style: const pw.TextStyle(color: PdfColors.grey, fontSize: 20),
        ),
      ),
    );

    widgets.add(
      pw.SizedBox(
          height: 30
      ),
    );

    final contact = pw.MemoryImage((await rootBundle.load(AssetPath.cvContacts)).buffer.asUint8List(),);

    widgets.add(
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: pw.Row(
          children: [
            pw.Image(
                contact,
                height: 120
            ),
            pw.SizedBox(
                width: 10
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  profileDataModel.user?.phoneNumber ?? "+20112345678",
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.normal,
                  ),
                ),
                pw.SizedBox(
                    height: 8
                ),
                pw.Text(
                  profileDataModel.user?.email ?? "",
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.normal,
                  ),
                ),
                pw.SizedBox(
                    height: 8
                ),
                pw.Text(
                  profileDataModel.country?.countryNameEn ?? "",
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    widgets.add(
      pw.SizedBox(
          height: 20
      ),
    );

    widgets.add(
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 30),
        child: pw.Text(
          'Education',
          style: pw.TextStyle(
            fontSize: 25,
            fontWeight: pw.FontWeight.normal,
          ),
        ),
      ),
    );

    widgets.add(
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: pw.Text(
          profileDataModel.university?.universityName ?? "",
          style: pw.TextStyle(
            fontSize: 20,
            fontWeight: pw.FontWeight.normal,
          ),
        ),
      ),
    );

    widgets.add(
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 30),
        child: pw.Text(
          profileDataModel.faculty?.name ?? "",
          style: pw.TextStyle(
            fontSize: 20,
            color: PdfColors.grey,
            fontWeight: pw.FontWeight.normal,
          ),
        ),
      ),
    );

    widgets.add(
      pw.SizedBox(
          height: 30
      ),
    );

    widgets.add(
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 30),
        child: pw.Text(
          'Skills',
          style: pw.TextStyle(
            fontSize: 25,
            fontWeight: pw.FontWeight.normal,
          ),
        ),
      ),
    );

    widgets.add(
      pw.GridView(
        crossAxisCount: 2,
        childAspectRatio: .1,
        padding: const pw.EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        children: List.generate(profileDataModel.user?.userSkills?.length??0, (index) {
          return pw.Row(
            children: [
              pw.Container(
                width: 10,
                height: 10,
                decoration: const pw.BoxDecoration(
                  shape: pw.BoxShape.circle,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(
                  width: 10
              ),
              pw.Text(
                profileDataModel.user?.userSkills?[index].skill?.skillNameEn ?? "",
                style: pw.TextStyle(
                  fontSize: 15,
                  fontWeight: pw.FontWeight.normal,
                ),
              ),
            ],
          );
        },),
      ),
    );

    final image = pw.MemoryImage((await rootBundle.load('asset/images/header-removebg-preview.png')).buffer.asUint8List(),);
    final image2 = pw.MemoryImage((await rootBundle.load('asset/images/footer-removebg-preview.png')).buffer.asUint8List(),);

    // Generate PDF
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        margin: pw.EdgeInsets.zero,
        footer: (t){
          return pw.Image(
            image2,
          );
        },
        header: (t){
          return pw.Image(
            image,
          );
        },
        build: (pw.Context context) => widgets,
      ),
    );

    final Directory? directory;

    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = await getDownloadsDirectory();
    }

    if (directory == null) {
      log("Document directory not available");
      return;
    }
    String path = directory.path;
    String myFile = '$path/${ profileDataModel.firstName} ${profileDataModel.lastName}.pdf';
    final file = File(myFile);
    await file.writeAsBytes(await pdf.save());
    OpenFile.open(myFile);
  }
  Future<Uint8List> _readImageData(String name) async {
    final data = await rootBundle.load(name);
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: AppSize.screenHeight! * .7,
            width: AppSize.screenWidth! * .95,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(AppSize.defaultSize! * 2),
              ),
              // image: const DecorationImage(
              //   image: AssetImage(AssetPath.bgCv),
              //   fit: BoxFit.fitHeight,
              // ),
            ),
            child: Padding(
              padding: EdgeInsets.all(AppSize.defaultSize!),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(AssetPath.logo),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: AppColors.primaryColor,
                              size: AppSize.defaultSize! * 3.5,
                            ))
                      ],
                    ),
                    const Divider(color: AppColors.secondaryColor,),
                    CustomText(
                      text:
                      '${profileDataModel.firstName!} ${profileDataModel
                          .lastName!}',
                      color: AppColors.primaryColor,
                      fontSize: AppSize.defaultSize! * 1.8,
                      fontWeight: FontWeight.w700,
                    ),
                    CustomText(
                      text: profileDataModel.description ?? "",

                      // lineHeight: AppSize.defaultSize! * .1,
                      maxLines: 20,
                      fontSize: AppSize.defaultSize! * 1.2,
                      color: AppColors.greyColor,
                      textAlign: TextAlign.start,
                    ),
                    Row(
                      children: [
                        // Container(
                        //   height: AppSize.defaultSize! * 11.8,
                        //   width: AppSize.defaultSize! * 3.2,
                        //   decoration: BoxDecoration(
                        //     color: AppColors.secondaryColor,
                        //     borderRadius: BorderRadius.circular(
                        //       AppSize.defaultSize! * 2,
                        //     ),
                        //   ),
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       Icon(
                        //         Icons.phone_outlined,
                        //         color: AppColors.black,
                        //         size: AppSize.defaultSize! * 2,
                        //       ),
                        //       Icon(
                        //         Icons.mail_outline,
                        //         color: AppColors.black,
                        //         size: AppSize.defaultSize! * 2,
                        //       ),
                        //       Icon(
                        //         Icons.location_on_outlined,
                        //         color: AppColors.black,
                        //         size: AppSize.defaultSize! * 2,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Image.asset(AssetPath.cvContacts,
                        width:  AppSize.defaultSize! * 3,
                        height:  AppSize.defaultSize! * 11.5,
                        ),
                        SizedBox(
                          width: AppSize.defaultSize!,
                        ),
                        SizedBox(
                          height: AppSize.defaultSize! * 11,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: profileDataModel.user?.phoneNumber ??
                                    "+201125391736",
                                color: AppColors.primaryColor,
                                fontSize: AppSize.defaultSize! * 1.4,
                                fontWeight: FontWeight.w700,
                                textAlign: TextAlign.start,
                              ),
                              // SizedBox(
                              //   height: AppSize.defaultSize!,
                              // ),
                              Padding(
                                padding:   EdgeInsets.symmetric(vertical:   AppSize.defaultSize! * 1),
                                child: CustomText(
                                  text: profileDataModel.user?.email ?? "",
                                  color: AppColors.primaryColor,
                                  fontSize: AppSize.defaultSize! * 1.4,
                                  fontWeight: FontWeight.w700,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              SizedBox(
                                width: AppSize.screenWidth! * .6,
                                child: CustomText(
                                  text:
                                  profileDataModel.city?.cityNameEn ?? "",
                                  color: AppColors.primaryColor,
                                  textAlign: TextAlign.start,
                                  fontSize: AppSize.defaultSize! * 1.4,
                                  fontWeight: FontWeight.w700,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    CustomText(
                      text: StringManager.education.tr(),
                      color: AppColors.primaryColor,
                      fontSize: AppSize.defaultSize! * 1.6,
                      fontWeight: FontWeight.w700,
                    ),
                    CustomText(
                      text: profileDataModel.university?.universityName ?? "",
                      color: AppColors.primaryColor,
                      fontSize: AppSize.defaultSize! * 1.4,
                      fontWeight: FontWeight.w700,
                    ),
                    CustomText(
                      text: profileDataModel.faculty?.name ?? "",
                      maxLines: 2,
                      fontSize: AppSize.defaultSize! * 1.2,
                      color: AppColors.greyColor,
                      textAlign: TextAlign.start,
                    ),
                    CustomText(
                      text: StringManager.skills.tr(),
                      color: AppColors.primaryColor,
                      fontSize: AppSize.defaultSize! * 1.6,
                      fontWeight: FontWeight.w700,
                    ),
                    ListView.builder(
                        itemCount: profileDataModel.user?.userSkills?.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(AppSize.defaultSize! * .5),
                            child: CustomText(
                              text: profileDataModel.user?.userSkills![index]
                                  .skill?.skillNameEn ?? "",
                              maxLines: 2,
                              fontSize: AppSize.defaultSize! * 1.2,
                              color: AppColors.greyColor,
                              textAlign: TextAlign.start,
                            ),
                          );
                        }),

                  ],
                ),
              ),
            )),
        SizedBox(
          height: AppSize.defaultSize! * 2,
        ),
        MainButton(
          text: StringManager.downloadAsPDF.tr(),
          onTap: _printScreen,
        ),
      ],
    );
  }
}
