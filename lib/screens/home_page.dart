import 'package:flutter/material.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  _HomeScreenContentState createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final List<String> imgList = [
    'assets/images/farmer_banner.png',
    'assets/images/farmer_banner.png',
    'assets/images/farmer_banner.png',
    'assets/images/farmer_banner.png',
    'assets/images/farmer_banner.png',
    'assets/images/farmer_banner.png',
    'assets/images/farmer_banner.png',
  ];

  @override
  void initState() {
    super.initState();
    // Auto-slide functionality
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoSlide();
    });
  }

  void _autoSlide() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_pageController.hasClients) {
        int nextPage = _currentPage + 1;
        if (nextPage == imgList.length) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        setState(() {
          _currentPage = nextPage;
        });
      }
      _autoSlide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Auto-sliding cards with PageView
          SizedBox(
            height: 200.0,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: imgList.length,
              itemBuilder: (context, index) {
                return Image.asset(imgList[index]); // Changed to Image.asset
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _pageController.animateToPage(
                  entry.key,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (_currentPage == entry.key
                        ? Colors.green
                        : Colors.grey),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          // New Orders Section
          // new order heading--------------------------------------------------
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'New Orders',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 21,vertical: 12),
            decoration: BoxDecoration(
              color: Color.fromRGBO(208, 207, 207, 0.3),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 220.0, // Set a fixed height for the list to scroll
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(), // Smooth scrolling
                itemCount: 30,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.asset('assets/images/red_pepper.png'),
                    title: const Text('Bell Pepper Red'),
                    subtitle: const Text('1kg, Price'),
                    trailing: const Text('\$4.99'),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Pending Payments Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Pending Payments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 21, vertical: 12),
            decoration: BoxDecoration(
              color: Color.fromRGBO(208, 207, 207, 0.3),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 220.0, // Set a fixed height for the list to scroll
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(), // Smooth scrolling
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.asset('assets/images/red_pepper.png'),
                    title: const Text('Bell Pepper Red'),
                    subtitle: const Text('1kg, Price'),
                    trailing: const Text('\$4.99'),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
