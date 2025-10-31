import 'package:flutter/material.dart';

class CountrySelectionScreen extends StatelessWidget {
  final String currentCountry;

  CountrySelectionScreen({super.key, required this.currentCountry});

  final List<Map<String, dynamic>> countries = [
    {'name': 'Kuwait', 'flag': '🇰🇼', 'color': Colors.green},
    {'name': 'USA', 'flag': '🇺🇸', 'color': Colors.blue},
    {'name': 'Bahrain', 'flag': '🇧🇭', 'color': Colors.red},
    {'name': 'UAE', 'flag': '🇦🇪', 'color': Colors.red},
    {'name': 'Oman', 'flag': '🇴🇲', 'color': Colors.red},
    {'name': 'Qatar', 'flag': '🇶🇦', 'color': Colors.purple},
    {'name': 'Jordan', 'flag': '🇯🇴', 'color': Colors.black},
    {'name': 'Egypt', 'flag': '🇪🇬', 'color': Colors.red},
    {'name': 'Iraq', 'flag': '🇮🇶', 'color': Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Choose your country',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context, currentCountry),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: Colors.white,
            child: Text(
              'Where will we deliver to?',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  final isSelected = country['name'] == currentCountry;

                  return InkWell(
                    onTap: () {
                      // Immediately pop back with selected country
                      Navigator.pop(context, country['name']);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[200]!,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: country['color'].withOpacity(0.1),
                              border: Border.all(
                                color: country['color'],
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                country['flag'],
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              country['name'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          if (isSelected)
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.orange,
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            height: 4,
            width: 50,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
