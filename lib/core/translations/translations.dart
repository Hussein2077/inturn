import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';


class CodegenLoader extends AssetLoader {
  CodegenLoader();
  static final Map<String, dynamic> mapLocales = {
    'ar': ar,
  };
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async{
    await Future.delayed(const Duration(milliseconds: 200));
    return mapLocales[locale.toString()] ?? {};
  }

  static const Map<String, dynamic> ar = {
    StringManager.uploadProfileImage: 'تحميل صورة الملف الشخصي',
    StringManager.next: 'التالي',
    StringManager.searchForIntern: 'البحث عن متدربين وفقًا لمهاراتك.',
    StringManager.internInformation: 'لدينا أكثر من 200 متدرب أسبوعيًا من أكثر من 100 شركة.',
    StringManager.searchForJobs: 'البحث عن وظائف...',
    StringManager.matchedJobs: 'الوظائف المطابقة',
    StringManager.unmatchedVacancies: 'هذه الوظائف لا تتطابق مع تفضيلات عملك؟',
    StringManager.changeWorkPreferences: 'تغيير تفضيلات العمل',
    StringManager.applications: 'التطبيقات',
    StringManager.home: 'الرئيسية',
    StringManager.companies: 'الشركات',
    StringManager.profile: 'الملف الشخصي',
    StringManager.companyOverview: 'نظرة عامة على الشركة',
    StringManager.changePassword: 'تغيير كلمة المرور',
    StringManager.downloadCV: 'تحميل السيرة الذاتية',
    StringManager.personalInformation: 'المعلومات الشخصية',
    StringManager.changeProfileImage: 'تغيير صورة الملف الشخصي',
    StringManager.searchResults: 'نتائج البحث',
    StringManager.jobFound: 'العثور على وظيفة',
    StringManager.filter: 'تصفية',
    StringManager.jobDetails: 'تفاصيل الوظيفة',
    StringManager.responsibilities: 'المسؤوليات',
    StringManager.skillsRequired: 'المهارات المطلوبة',
    StringManager.internship: 'تدريب',
    StringManager.enterMobileNumber: 'ادخل رقم هاتفك المحمول.',
    StringManager.resendPassword: 'إعادة إرسال الرمز',
    StringManager.resendVerificationCode: 'يمكنك إعادة إرسال رمز التحقق بعد',
    StringManager.verify: 'تحقق',
    StringManager.filterResults: 'نتائج التصفية',
    StringManager.city: 'المدينة',
    StringManager.showMore: 'عرض المزيد',
    StringManager.area: 'المنطقة',
    StringManager.careerLevel: 'مستوى الوظيفة',
    StringManager.workplace: 'مكان العمل',
    StringManager.newPassword: 'كلمة المرور الجديدة',
    StringManager.confirmNewPassword: 'تأكيد كلمة المرور الجديدة',
    StringManager.confirm: 'تأكيد',
    StringManager.fillAcademicInformation: 'املأ معلوماتك الأكاديمية',
    StringManager.academicInformation: 'معلوماتك الأكاديمية',
    StringManager.selectUniversity: 'اختر جامعتك',
    StringManager.selectFaculty: 'اختر كليتك',
    StringManager.education: 'التعليم',
    StringManager.skills: 'المهارات',
    StringManager.downloadAsPDF: 'تحميل كملف PDF',
    StringManager.experience: 'أخبرنا عن تجربتك',
    StringManager.experiences: 'تجربتك',
    StringManager.studentOrGraduated: 'هل أنت طالب أم خريج؟',
    StringManager.jobLevel: 'ما هو مستوى عملك؟',
    StringManager.student: 'طالب',
    StringManager.graduated: 'خريج',
    StringManager.internshipLevel: 'مستوي التدريب',
    StringManager.entryLevel: 'مستوى الدخول',
    StringManager.workLocationAndType: 'مكان العمل ونوعه',
    StringManager.selectCountry: 'اختر بلدك',
    StringManager.selectCity: 'اختر مدينتك',
    StringManager.selectLocationType: 'اختر نوع الموقع',
    StringManager.locationType: 'نوع الموقع',
    StringManager.onSite: 'في الموقع',
    StringManager.remotely: 'عن بُعد',
    StringManager.hybrid: 'هجين',
    StringManager.fieldsOfWork: 'مجالات العمل الخاصة بك؟',
    StringManager.yourSkills: 'ما هي مهاراتك؟',
    StringManager.searchForSkills: 'البحث عن المهارات...',
    StringManager.selectSkills: 'اختر مهاراتك',
    StringManager.discoverInternships: 'اكتشاف التدريب',
    StringManager.letBeginTheJourney: "لنبدأ الرحلة",
    StringManager.continueWithGoogle: "المتابعة مع Google",
    StringManager.continueWithLinkedin: "المتابعة مع Linkedin",
    StringManager.continueWithApple: "المتابعة مع Apple",
    StringManager.all: "الكل",
    StringManager.freshGraduate: "خريج جديد",
  };

}
