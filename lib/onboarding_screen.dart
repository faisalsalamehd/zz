import 'package:flutter/material.dart';
import 'package:zz/custom_illustrations.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: 'Discover amazing products',
      description:
          'Search and explore a wide range of premium products tailored to your preferences',
      illustrationBuilder: (color) =>
          CustomIllustrations.searchIllustration(color: color),
      primaryColor: Color(0xFF6C63FF),
      secondaryColor: Color(0xFF9C93FF),
    ),
    OnboardingData(
      title: 'Shop for white essentials',
      description:
          'Find the perfect white essentials for your wardrobe with our curated collection',
      illustrationBuilder: (color) =>
          CustomIllustrations.shoppingCartIllustration(color: color),
      primaryColor: Color(0xFFFF6B6B),
      secondaryColor: Color(0xFFFF8E8E),
    ),
    OnboardingData(
      title: 'Find trends & reference stories',
      description:
          'Stay ahead with the latest trends and discover inspiring stories from our community',
      illustrationBuilder: (color) =>
          CustomIllustrations.trendsIllustration(color: color),
      primaryColor: Color(0xFF4ECDC4),
      secondaryColor: Color(0xFF7EDDD6),
    ),
    OnboardingData(
      title: 'Find the perfect gift',
      description:
          'Discover thoughtful and unique gifts for your loved ones on every special occasion',
      illustrationBuilder: (color) =>
          CustomIllustrations.giftIllustration(color: color),
      primaryColor: Color(0xFFFFD93D),
      secondaryColor: Color(0xFFFFE066),
    ),
    OnboardingData(
      title: 'Express for real souls',
      description:
          'Express your authentic self with products that truly reflect your unique personality',
      illustrationBuilder: (color) =>
          CustomIllustrations.profileIllustration(color: color),
      primaryColor: Color(0xFFFF8A80),
      secondaryColor: Color(0xFFFFA8A0),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top navigation
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 200),
                    opacity: _currentPage > 0 ? 1.0 : 0.0,
                    child: IconButton(
                      onPressed: _currentPage > 0 ? _previousPage : null,
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black87,
                        size: 20,
                      ),
                    ),
                  ),
                  Text(
                    'Onboarding',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      letterSpacing: 0.5,
                    ),
                  ),
                  TextButton(
                    onPressed: _skipToEnd,
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 16,
                        color: _pages[_currentPage].primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Page content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                  _fadeController.reset();
                  _fadeController.forward();
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: _buildPage(_pages[index]),
                  );
                },
              ),
            ),

            // Bottom navigation
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 40),
              child: Column(
                children: [
                  // Page indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => _buildIndicator(index),
                    ),
                  ),

                  SizedBox(height: 40),

                  // Next/Get Started button
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [
                          _pages[_currentPage].primaryColor,
                          _pages[_currentPage].secondaryColor,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _pages[_currentPage].primaryColor.withOpacity(
                            0.3,
                          ),
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: _currentPage == _pages.length - 1
                            ? _getStarted
                            : _nextPage,
                        child: Center(
                          child: Text(
                            _currentPage == _pages.length - 1
                                ? 'Get Started'
                                : 'Next',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration container
          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  data.primaryColor.withOpacity(0.1),
                  data.secondaryColor.withOpacity(0.05),
                  Colors.transparent,
                ],
              ),
              borderRadius: BorderRadius.circular(110),
            ),
            child: Center(child: data.illustrationBuilder(data.primaryColor)),
          ),

          SizedBox(height: 60),

          // Title
          Text(
            data.title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.copyWith(color: Colors.black87),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 20),

          // Description
          Text(
            data.description,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(int index) {
    bool isActive = _currentPage == index;

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 28 : 8,
      height: 8,
      decoration: BoxDecoration(
        gradient: isActive
            ? LinearGradient(
                colors: [
                  _pages[_currentPage].primaryColor,
                  _pages[_currentPage].secondaryColor,
                ],
              )
            : null,
        color: isActive ? null : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _skipToEnd() {
    _pageController.animateToPage(
      _pages.length - 1,
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  void _getStarted() {
    // Show success with haptic feedback
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green, Colors.green.shade300],
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Icon(Icons.check, color: Colors.white, size: 40),
              ),
              SizedBox(height: 20),
              Text(
                'Welcome aboard!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10),
              Text(
                'You\'re ready to start your journey',
                style: TextStyle(color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigate to main app here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final Widget Function(Color) illustrationBuilder;
  final Color primaryColor;
  final Color secondaryColor;

  OnboardingData({
    required this.title,
    required this.description,
    required this.illustrationBuilder,
    required this.primaryColor,
    required this.secondaryColor,
  });
}
