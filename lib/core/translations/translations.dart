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
    StringManager.userTokenKey: "مفتاح رمز المستخدم",
    StringManager.unexpectedError: "خطأ غير متوقع",
    StringManager.loginSuccessfully: "تسجيل الدخول بنجاح",
    StringManager.login: "تسجيل الدخول",
    StringManager.welcomeBack: "مرحبًا مجددًا!",
    StringManager.youHaveBeenMissed: "لقد غبت عنا لوقت طويل",
    StringManager.email: "البريد الإلكتروني",
    StringManager.password: "كلمة المرور",
    StringManager.confirmPassword: "تأكيد كلمة المرور",
    StringManager.forgetYourPassword: "هل نسيت كلمة المرور؟",
    StringManager.forgetPassword: "نسيت كلمة المرور",
    StringManager.weWillSend:
        "سنرسل رمزًا إلى هاتفك للتحقق وتعيين كلمة المرور الجديدة",
    StringManager.pleaseEnterYOurCode: "الرجاء إدخال الرمز المرسل إلى",
    StringManager.or: "أو قم بتسجيل الدخول باستخدام",
    StringManager.enterYourMobile: "أدخل رقم هاتفك المحمول",
    StringManager.signUp: "التسجيل",
    StringManager.signIn: "تسجيل الدخول",
    StringManager.sendCode: "إرسال الرمز",
    StringManager.confirm: "تأكيد",
    StringManager.doNotHaveAccount: "ليس لديك حساب؟   ",
    StringManager.youAlready: "لديك بالفعل حساب؟   ",
    StringManager.youCanResend: "يمكنك إعادة إرسال رمز التحقق بعد",
    StringManager.resendCode: "إعادة إرسال الرمز",
    StringManager.verify: "التحقق",
    StringManager.firstName: "الاسم الأول",
    StringManager.secondName: "الاسم الثاني",
    StringManager.phoneNum: "رقم الهاتف",
    StringManager.dateOfBirth: "تاريخ الميلاد",
    StringManager.educationLevel: "مستوى التعليم",
    StringManager.graduationYear: "سنة التخرج",
    StringManager.selectEdu: "اختر مستوى التعليم",
    StringManager.selectGrad: "اختر سنة التخرج",
    StringManager.university: "الجامعة",
    StringManager.major: "التخصص",
    StringManager.jobs: "وظائف",
    StringManager.viewJob: "عرض الوظيفة",
    StringManager.internships: "تدريب",
    StringManager.viewProfile: "عرض الملف الشخصي",
    StringManager.home: "الرئيسية",
    StringManager.companies: "الشركات",
    StringManager.blog: "المدونة",
    StringManager.options: "الخيارات",
    StringManager.logOut: "تسجيل الخروج",
    StringManager.resources: "الموارد",
    StringManager.takeQuiz: "أدخل الاختبار",
    StringManager.whatAreYouLookingFor: "ما الذي تبحث عنه؟",
    StringManager.youCanTakeQuiz:
        "يمكنك إجراء اختبار لتحديد المهنة المناسبة لك.",
    StringManager.selectArea: "اختر المجال",
    StringManager.selectSkill: "اختر المهارة",
    StringManager.search: "بحث",
    StringManager.contactUs: "تواصل معنا",
    StringManager.profile: "الملف الشخصي",
    StringManager.subject: "العنوان",
    StringManager.changeProfilePicture: "تغيير صورة الملف الشخصي",
    StringManager.saveChanges: "حفظ التغيرات",
    StringManager.tabToUploadCV: "تحميل السيرة الذاتية",
    StringManager.pleaseCompleteYourData: "الرجاء اكمال البيانات",
    StringManager.myApplications: "طلباتي",
    StringManager.applyNow: "تقديم طلب",
    StringManager.viewDetails: "التفاصيل",
    StringManager.message: "الرسالة",
    StringManager.send: "ارسال",
  };
}
