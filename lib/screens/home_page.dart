import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:blur/blur.dart';
import 'package:coffee_ui/data/sample_data.dart';
import 'package:coffee_ui/utils/components/coffee_type.dart';
import 'package:coffee_ui/utils/components/icon_dot.dart';
import 'package:coffee_ui/utils/components/special_for_you.dart';
import 'package:coffee_ui/utils/constants.dart';
import 'package:coffee_ui/utils/widget_functions.dart';
import 'package:flutter/material.dart';

import '../utils/components/coffee_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  List<TabItem> items = [
    const TabItem(
      icon: Icons.home_rounded,
      count: IconDot(
        counter: 2,
      ),
    ),
    const TabItem(
      icon: Icons.shopping_bag_rounded,
      count: IconDot(),
    ),
    const TabItem(
      icon: Icons.favorite_rounded,
      count: IconDot(),
    ),
    const TabItem(
      icon: Icons.person_rounded,
      count: IconDot(
        counter: 1,
      ),
    ),
  ];

  // User tapped on coffee types
  coffeeTypeSelected(int index) {
    setState(() {
      for (int num = 0; num < coffeeTypes.length; num++) {
        coffeeTypes[num][1] = false;
      }
      coffeeTypes[index][1] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: const Icon(Icons.menu_rounded),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(Icons.person),
            ),
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  scrollbars: false,
                  physics: const BouncingScrollPhysics(),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Text
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: pageSpacing),
                        child: Text(
                          'Find the best coffee for you',
                          style: themeData.textTheme.headline1,
                        ),
                      ),
                      addVerticalSpace(pageSpacing),
                      // Text Field
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: pageSpacing),
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.only(left: 18, right: 18),
                              child: Icon(
                                Icons.coffee_rounded,
                                color: borderColor,
                              ),
                            ),
                            hintText: 'Find your coffee...',
                          ),
                        ),
                      ),
                      // Coffee Types
                      Padding(
                        padding: EdgeInsets.only(bottom: pageSpacing, top: 30),
                        child: SizedBox(
                          height: 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: coffeeTypes.length,
                            itemBuilder: (BuildContext context, int index) {
                              List items = coffeeTypes[index];
                              return CoffeeType(
                                coffeeType: items[0],
                                selected: items[1],
                                onTap: () => coffeeTypeSelected(index),
                              );
                            },
                          ),
                        ),
                      ),
                      // Coffee Tiles
                      SizedBox(
                        height: 310,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: coffeeTiles.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> item = coffeeTiles[index];
                            return CoffeeTile(
                              index: index,
                              path: item['path'],
                              price: item['price'],
                              extras: item['extras'],
                              coffee: item['coffee'],
                              rating: item['rating'],
                            );
                          },
                        ),
                      ),
                      // The 'Special for you text'
                      Padding(
                        padding: EdgeInsets.only(
                          left: pageSpacing + 10,
                          right: pageSpacing,
                          top: 25,
                        ),
                        child: Text(
                          'Special for you',
                          style: themeData.textTheme.headline6?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ),
                      const SpecialForYou(),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 25,
                  ),
                  child: BottomBarFloating(
                    indexSelected: currentIndex,
                    colorSelected: const Color(0xffCF7742),
                    backgroundColor: Colors.transparent,
                    items: items,
                    iconSize: 26,
                    paddingVertical: 20,
                    color: const Color(0xff4E5053),
                    onTap: (int index) => setState(() {
                      currentIndex = index;
                    }),
                    duration: const Duration(milliseconds: 200),
                    animated: true,
                  ).frosted(
                    blur: 10,
                    borderRadius: circularBorder2,
                    frostColor: colorPrimary,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
