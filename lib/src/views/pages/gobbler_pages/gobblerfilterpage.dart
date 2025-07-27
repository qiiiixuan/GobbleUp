import 'package:GobbleUp/src/views/widgets/selectbutton.dart';
import 'package:flutter/material.dart';
import 'package:GobbleUp/src/data/constants.dart';

// create data to be passed to the GobblerHomePage
class FilterData{
  final List<String> cuisines;
  final String priceRange;

  FilterData({required this.cuisines, required this.priceRange});
}

class GobblerFilterPage extends StatefulWidget {
  const GobblerFilterPage({super.key});

  @override
  State<GobblerFilterPage> createState() => _GobblerFilterPageState();
}

class _GobblerFilterPageState extends State<GobblerFilterPage> {
  double selectVal = 0.0; // Slider value for price range
  List<int> selectCat = [];

  List<String> cuisines = [
    'Italian',
    'Chinese',
    'Indian',
    'Mexican',
    'Japanese',
    'Thai',
    'Western',
   'Vegetarian',
   'Other',
  ];

  final Map<int, String?> priceRange = {
    0: 'Less than \$10',
    1: '\$10 - \$20',
    2: '\$20 - \$30',
    3: '\$30 - \$40',
    4: 'More than \$40',
    5: 'Any Price Range',
  };

  final Map<int,String> Cuisine = {
    0: 'Italian',
    1: 'Chinese',
    2: 'Indian',
    3: 'Mexican',
    4: 'Japanese',
    5: 'Thai',
    6: 'Western',
    7: 'Vegetarian',
    8: 'Other',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Filters',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Select Categories',
                style: KTextStyle.normalTextStyle,
              ),

              GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 9,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 8.0,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 2.2),
                  itemBuilder: (context, index) {
                    return

                    SelectButton(
                      text: cuisines[index],
                      isSelected: selectCat.contains(index),
                      onPressed: () {
                        setState(() {
                          if (selectCat.contains(index)) {
                            selectCat.remove(index);
                          } else {
                            selectCat.add(index);
                          }
                        });
                      },
                    );
            
                  }),

              const SizedBox(height: 40.0),

              Text(
                'Price Range',
                style: KTextStyle.normalTextStyle,
              ),

              // Display the selected price range
              Text(
                'Price : ${selectVal == 0 ? 'Less than \$10' : selectVal == 1 ? 'Between \$10 - \$20' : selectVal == 2 ? 'Between \$20 - \$30' : selectVal == 3 ? 'Between \$30 - \$40' : selectVal == 4?  'More than \$40' : 'Any Price Range'}',
                style: KTextStyle.normalTextStyle,
              ),

              // Slider for price range selection
              Slider(
                min: 0,
                max: 5,
                value: selectVal,
                divisions: 5,
                onChanged: (newVal) {
                  setState(() {
                    selectVal = newVal;
                  });
                },
                activeColor: Color(0xFFFF6666),
                inactiveColor: Colors.grey,
              ),


              // include location filter in the future
              // Text(
              //   'Location',
              //   style: KTextStyle.normalTextStyle,
              // ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Color(0xFFFF6666),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: SafeArea(
              child: Row(
            children: [
              Expanded(
                child: TextButton(
                  style: KButtonStyle.elevatedButtonStyle,
                  onPressed: () {
                    setState(() {
                      selectVal = 5.0; // Reset price range
                      selectCat.clear(); // Clear selected categories
                    });
                  },
                  child: Text(
                    'Reset Filters',
                    style: KTextStyle.buttonTextStyle,
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.white,
              ),
              Expanded(
                child: TextButton(
                  style: KButtonStyle.elevatedButtonStyle,
                  onPressed: () {
                    // send the selected filters back to the GobblerHomePage
                    FilterData filterData = FilterData(
                      cuisines: selectCat.map((index) => Cuisine[index]!).toList(),
                      priceRange: 
                      priceRange[selectVal.toInt()]!,
                    );
                    Navigator.pop(context, filterData);
                  },
                  child: Text(
                    'Apply Filters',
                    style: KTextStyle.buttonTextStyle,
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}
