import 'package:flutter/material.dart';
import 'package:flutter_application_2/sign_up/set_up.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PreferenceScreen extends StatefulWidget {
  @override
  _PreferenceScreenState createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  int currentStep = 0;
  List<String> selectedCountries = [];
  List<String> selectedCuisines = [];
  List<String> selectedDislikes = [];

  final List<PreferenceOption> countryOptions = [
    PreferenceOption(label: 'France', iconPath: 'image/icons/fr.svg'),
    PreferenceOption(label: 'Russia', iconPath: 'image/icons/ru.svg'),
    PreferenceOption(label: 'China', iconPath: 'image/icons/cn.svg'),
    PreferenceOption(label: 'Taiwan', iconPath: 'image/icons/tw.svg'),
    PreferenceOption(label: 'Brazil', iconPath: 'image/icons/br.svg'),
    PreferenceOption(label: 'Norway', iconPath: 'image/icons/no.svg'),
    PreferenceOption(label: 'America', iconPath: 'image/icons/us.svg'),
    PreferenceOption(label: 'Australia', iconPath: 'image/icons/au.svg'),
    PreferenceOption(label: 'Indonesia', iconPath: 'image/icons/id.svg'),
  ];

  final List<PreferenceOption> cuisineOptions = [
    PreferenceOption(label: 'Sushi', iconPath: 'image/icons/su.svg'),
    PreferenceOption(label: 'Curry', iconPath: 'image/icons/cu.svg'),
    PreferenceOption(label: 'Salad', iconPath: 'image/icons/sa.svg'),
    PreferenceOption(label: 'Seafood', iconPath: 'image/icons/fru.svg'),
    PreferenceOption(label: 'Chicken', iconPath: 'image/icons/po.svg'),
    PreferenceOption(label: 'Noodles', iconPath: 'image/icons/nou.svg'),
    PreferenceOption(label: 'Soup', iconPath: 'image/icons/sop.svg'),
    PreferenceOption(label: 'Meat', iconPath: 'image/icons/vi.svg'),
    PreferenceOption(label: 'Spaghetti', iconPath: 'image/icons/pa.svg'),
  ];

  final List<PreferenceOption> dislikeOptions = [
    PreferenceOption(label: 'Veggies', iconPath: 'image/icons/leg.svg'),
    PreferenceOption(label: 'Egg', iconPath: 'image/icons/oe.svg'),
    PreferenceOption(label: 'Sushi', iconPath: 'image/icons/su.svg'),
    PreferenceOption(label: 'Bacon', iconPath: 'image/icons/ba.svg'),
    PreferenceOption(label: 'Chicken', iconPath: 'image/icons/po.svg'),
    PreferenceOption(label: 'Octopus', iconPath: 'image/icons/cal.svg'),
    PreferenceOption(label: 'Bread', iconPath: 'image/icons/bag.svg'),
    PreferenceOption(label: 'Seafood', iconPath: 'image/icons/fru.svg'),
  ];

  void toggleOption(String option, List<String> selectedList) {
    setState(() {
      if (selectedList.contains(option)) {
        selectedList.remove(option);
      } else {
        selectedList.add(option);
      }
    });
  }

  void nextStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep++;
      });
    } else {
      // Handle completion of all steps and navigate to the next screen
      print('Preferences completed!');
      print('Selected Countries: $selectedCountries');
      print('Selected Cuisines: $selectedCuisines');
      print('Selected Dislikes: $selectedDislikes');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AccountSetupScreen()),
      );
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEF5ED),
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(),
            Expanded(
              child: IndexedStack(
                index: currentStep,
                children: [
                  PreferenceStep(
                    title: 'Your preferred country food?',
                    options: countryOptions,
                    selectedOptions: selectedCountries,
                    onOptionToggle: (country) =>
                        toggleOption(country, selectedCountries),
                    onContinue: nextStep,
                  ),
                  PreferenceStep(
                    title: 'Your preferred cuisines?',
                    options: cuisineOptions,
                    selectedOptions: selectedCuisines,
                    onOptionToggle: (cuisine) =>
                        toggleOption(cuisine, selectedCuisines),
                    onContinue: nextStep,
                  ),
                  PreferenceStep(
                    title: 'Any Dislikes?',
                    options: dislikeOptions,
                    selectedOptions: selectedDislikes,
                    onOptionToggle: (dislike) =>
                        toggleOption(dislike, selectedDislikes),
                    onContinue: nextStep,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: Row(
        children: [
          if (currentStep > 0)
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: previousStep,
            ),
          Expanded(
            child: StepProgressIndicator(currentStep: currentStep),
          ),
          TextButton(
            child: Text('Skip', style: TextStyle(color: Colors.grey)),
            onPressed: () {/* Handle skip */},
          ),
        ],
      ),
    );
  }
}

class StepProgressIndicator extends StatelessWidget {
  final int currentStep;

  StepProgressIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            height: 8.0,
            decoration: BoxDecoration(
              color:
                  index <= currentStep ? Color(0xFFFF9F5A) : Colors.grey[300],
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        );
      }),
    );
  }
}

class PreferenceStep extends StatelessWidget {
  final String title;
  final List<PreferenceOption> options;
  final List<String> selectedOptions;
  final ValueChanged<String> onOptionToggle;
  final VoidCallback onContinue;

  PreferenceStep({
    required this.title,
    required this.options,
    required this.selectedOptions,
    required this.onOptionToggle,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: options.map((option) {
                final isSelected = selectedOptions.contains(option.label);
                return GestureDetector(
                  onTap: () => onOptionToggle(option.label),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFF5D3EBE) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white.withOpacity(0.2)
                                : Color(0xFFFFF5EE),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              option.iconPath,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          option.label,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF9F5A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                minimumSize: Size(double.infinity, 56),
              ),
              child: Text(
                'Continue',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PreferenceOption {
  final String label;
  final String iconPath;

  PreferenceOption({required this.label, required this.iconPath});
}
