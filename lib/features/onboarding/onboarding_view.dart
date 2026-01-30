import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:appbutawarna/core/theme/app_theme.dart';
import 'package:appbutawarna/features/auth/login_page.dart';
import 'package:appbutawarna/features/onboarding/data/onboarding_items.dart';
import 'package:appbutawarna/features/onboarding/widgets/onboarding_title.dart';
import 'package:appbutawarna/features/onboarding/widgets/onboarding_description.dart';
import 'package:appbutawarna/features/onboarding/widgets/onboarding_image.dart';
import 'package:appbutawarna/features/onboarding/widgets/onboarding_next_button.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  void onNext() {
    if (_index < onboardingItems.length - 1) {
      setState(() => _index++);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = onboardingItems[_index];
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              OnboardingTitle(title: data.title),

              const SizedBox(height: 8,),

              OnboardingDescription(description: data.description),

              const SizedBox(height: 40,),

              OnboardingImage(image: data.image),

              const Spacer(),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OnboardingNextButton(onTap: onNext)
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}