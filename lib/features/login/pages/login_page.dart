import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:finals_fe/extensions/build_context.ext.dart';
import 'package:finals_fe/routers/router_name.dart';

import '../../../helpers/widgets/buttons/buttons.dart';
import '../../../helpers/widgets/textfield/custom_textfield.dart';
import '../../../utils/assets.gen.dart';

final formkey = GlobalKey<FormState>();

class LoginPage extends HookWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final username = useTextEditingController();
    final password = useTextEditingController();
    final isButtonEnabled = useState(false);

    useEffect(() {
      void updateButtonState() {
        isButtonEnabled.value = username.text.isNotEmpty && password.text.isNotEmpty;
      }

      username.addListener(updateButtonState);
      password.addListener(updateButtonState);

      return () {
        username.removeListener(updateButtonState);
        password.removeListener(updateButtonState);
      };
    }, [username, password]);

    return Scaffold(
      backgroundColor: const Color(0xFF0F1323),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(165),
              Center(
                child: Hero(
                  tag: 'logo',
                  child: Image.asset(
                    Assets.images.logoApp.path,
                    height: 75,
                  ),
                ),
              ),
              Text(
                'Digital Touch Point',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontSize: 29.50,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Image.asset(
                    Assets.images.mountainElement.path,
                    fit: BoxFit.cover,
                    height: context.deviceHeight * 0.6,
                    width: context.deviceWidth,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      gradient: RadialGradient(
                        center: Alignment(0.3167, 0.1506),
                        radius: 39.16,
                        colors: [
                          Color.fromRGBO(255, 255, 255, 0.19),
                          Color.fromRGBO(255, 255, 255, 0),
                        ],
                      ),
                    ),
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Masuk',
                            style: GoogleFonts.montserrat(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Silahkan masuk untuk melanjutkan',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Gap(16),
                          CustomTextField(
                            isBorder: false,
                            filled: const Color(0xFF242134),
                            controller: username,
                            label: 'Username',
                          ),
                          const Gap(12),
                          CustomTextField(
                            isBorder: false,
                            filled: const Color(0xFF242134),
                            controller: password,
                            obscureText: true,
                            label: 'Password',
                          ),
                          const Gap(16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                context.pushNamed(RouteName.forgotPassword);
                              },
                              child: Text(
                                'Lupa Password?',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Gap(16),
                          Container(
                            height: 52,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(34),
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF9069FF),
                                  Color(0xFF8258E5),
                                ],
                              ),
                            ),
                            child: Button.filled(
                              borderRadius: 34,
                              height: 52,
                              color: Colors.transparent,
                              disabled: !isButtonEnabled.value,
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  context.pushReplacementNamed(RouteName.main);
                                }
                              },
                              label: 'Masuk',
                            ),
                          ),
                          const Gap(16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Belum memiliki akun?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const Gap(4),
                              GestureDetector(
                                onTap: () {
                                  context.pushNamed(RouteName.register);
                                },
                                child: Text(
                                  'Daftar Akun',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF9069FF),
                                    decoration: TextDecoration.underline,
                                    decorationColor: const Color(0xFF9069FF),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(26),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
