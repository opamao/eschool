import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';

import '../../../../../constants/constants.dart';
import '../../../../themes/themes.dart';
import '../../../../widgets/widgets.dart';
import '../../forgot/forgot.dart';
import '../../register/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  var login = TextEditingController();
  var password = TextEditingController();

  String phoneIndicator = "";
  String initialCountry = 'CI';
  PhoneNumber number = PhoneNumber(isoCode: 'CI');

  final _snackBar = const SnackBar(
    content: Text("Tous les champs sont obligatoires"),
    backgroundColor: Colors.red,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        iconTheme: IconThemeData(color: appWhite),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: appColor.withOpacity(.1),
                        borderRadius: BorderRadius.all(Radius.circular(8.w)),
                      ),
                      child: Icon(
                        Icons.settings_input_composite,
                        color: appColor,
                      ),
                    ),
                  ),
                  Gap(2.h),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Connexion a votre compte",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: appBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                        ),
                        Text(
                          "Bienvenu à vous, vous nous \navez manqué !",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: appBlack,
                            fontWeight: FontWeight.normal,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(2.h),
                  Container(
                    padding: EdgeInsets.only(left: 4.w),
                    decoration: BoxDecoration(
                      color: appColor.withOpacity(.08),
                      borderRadius: BorderRadius.circular(3.w),
                      border: Border.all(
                        color: _isFocused ? appColor : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: InternationalPhoneNumberInput(
                      focusNode: _focusNode,
                      onInputChanged: (PhoneNumber number) {
                        phoneIndicator = number.phoneNumber!;
                        print(phoneIndicator);
                      },
                      onInputValidated: (bool value) {},
                      errorMessage: "Le numéro est invalide",
                      hintText: "Numéro de téléphone",
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      initialValue: number,
                      textFieldController: login,
                      formatInput: true,
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: true,
                        decimal: true,
                      ),
                      inputBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      onSaved: (PhoneNumber number) {},
                    ),
                  ),
                  Gap(2.h),
                  InputPassword(
                    hintText: "Mot de passe",
                    controller: password,
                    validatorMessage: "Veuillez saisir votre mot de passe",
                    suffixIcon: IconButton(
                        icon: Icon(
                          _obscure ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscure = !_obscure;
                          });
                        }),
                  ),
                  Gap(1.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Mot de passe oublié?",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: appColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Gap(1.h),
                  SubmitButton(
                    AppConstants.btnLogin,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                      }
                    },
                  ),
                  Gap(3.h),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Vous n'avez pas de compte? ",
                            style: TextStyle(
                              color: appBlack,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          TextSpan(
                            text: "S'enregistrer",
                            style: TextStyle(
                              color: appColor,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterPage(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
