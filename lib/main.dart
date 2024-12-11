import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/buku_page.dart';
import 'pages/profil_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'book_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // imageCache.clear();
  runApp(
    ChangeNotifierProvider(
      create: (_) => BookProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  String? _selectedCategory;
  String _searchQuery = "";
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    HomePage(),
    BukuPage(),
    ProfilPage(),
  ];

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
      _selectedIndex = 0;
    });
    _pageController.jumpToPage(0);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: _pages.map((page) {
              if (page is HomePage) {
                return HomePage(
                    searchQuery: _searchQuery,
                    selectedCategory: _selectedCategory);
              }
              return page;
            }).toList(),
          ),
          // Rounded AppBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PreferredSize(
              preferredSize: Size.fromHeight(
                _selectedIndex == 2 ? 200 : 80,
              ),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: Color(0xFF7b94e4),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: _selectedIndex == 2
                      ? Center(
                          key: ValueKey('profileAppBar'),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                        top: 70.0, bottom: 15.0)
                                    .add(
                                        EdgeInsets.symmetric(horizontal: 40.0)),
                                child: Image.asset(
                                  'assets/images/profile_photo.png',
                                  fit: BoxFit.cover,
                                  height: 100,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 20.0).add(
                                    EdgeInsets.symmetric(horizontal: 40.0)),
                                child: Text(
                                  'John Doe',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : _selectedIndex == 1
                          ? AppBar(
                              key: ValueKey('booksAppBar'),
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              toolbarHeight: 80,
                              centerTitle: true,
                              title: Text(
                                "Cek buku kamu di sini!",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : AppBar(
                              toolbarHeight: 80,
                              key: ValueKey('defaultAppBar'),
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              title: Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(1000),
                                        ),
                                        child: TextField(
                                          onChanged: _onSearchChanged,
                                          decoration: InputDecoration(
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: SvgPicture.asset(
                                                'assets/images/icons/search_icon.svg',
                                              ),
                                            ),
                                            hintText: "Cari bukumu disini...",
                                            hintStyle: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF7b94e4),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide.none,
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              vertical: 12,
                                              horizontal: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    IconButton(
                                      icon: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                          'assets/images/icons/filter_icon.svg',
                                        ),
                                      ),
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.white,
                                          barrierColor:
                                              Colors.black.withOpacity(0.1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20),
                                            ),
                                          ),
                                          builder: (BuildContext context) {
                                            final List<String> categories = [
                                              "All categories",
                                              "Adult Fiction",
                                              "Art, Music & Photography",
                                              "Business & Investing",
                                              "Children Age 8-12",
                                              "Comics & Graphic Novels",
                                              "Education & Test Preparation",
                                              "Fiction & Literature",
                                              "Food, Drink & Cookbook",
                                              "Health, Fitness & Wellness",
                                              "Islam",
                                              "Jawa",
                                              "National",
                                              "Newspaper",
                                              "Poem & Short Story",
                                              "Politics, Affairs & Social Sciences",
                                              "Reference & Dictionary",
                                              "Romance",
                                              "Science & Nature",
                                              "Teen & Young Adult Fiction",
                                              "Travel",
                                            ];
                                            return DraggableScrollableSheet(
                                              initialChildSize: 0.5,
                                              minChildSize: 0.3,
                                              maxChildSize: 0.9,
                                              expand: false,
                                              builder:
                                                  (context, scrollController) {
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 8),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Container(
                                                        width: 40,
                                                        height: 4,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.grey[300],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(2),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 16.0,
                                                          vertical: 12.0),
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                                top: Radius
                                                                    .circular(
                                                                        20)),
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: IconButton(
                                                              icon: SvgPicture
                                                                  .asset(
                                                                'assets/images/icons/angle-small-left-icon.svg',
                                                                height: 15,
                                                                width: 15,
                                                              ),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              'Kategori',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xFF7b94e4),
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: ListView.builder(
                                                        controller:
                                                            scrollController,
                                                        itemCount:
                                                            categories.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        16.0,
                                                                    vertical:
                                                                        8.0),
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                _onCategorySelected(
                                                                    categories[
                                                                        index]);
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Color(
                                                                        0xFF7b94e4),
                                                                foregroundColor:
                                                                    Colors
                                                                        .white,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        12.0,
                                                                    horizontal:
                                                                        16.0),
                                                              ),
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  categories[
                                                                      index],
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, -4),
              blurRadius: 5,
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SizedBox(
                  child: SvgPicture.asset(
                    'assets/images/icons/beranda_icon.svg',
                    colorFilter: _selectedIndex == 0
                        ? ColorFilter.mode(Color(0xFF7b94e4), BlendMode.srcIn)
                        : ColorFilter.mode(Color(0xFFC3C3C3), BlendMode.srcIn),
                  ),
                ),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  child: SvgPicture.asset(
                    'assets/images/icons/buku_icon.svg',
                    colorFilter: _selectedIndex == 1
                        ? ColorFilter.mode(Color(0xFF7b94e4), BlendMode.srcIn)
                        : ColorFilter.mode(Color(0xFFC3C3C3), BlendMode.srcIn),
                  ),
                ),
                label: 'Buku',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  child: SvgPicture.asset(
                    'assets/images/icons/profil_icon.svg',
                    colorFilter: _selectedIndex == 2
                        ? ColorFilter.mode(Color(0xFF7b94e4), BlendMode.srcIn)
                        : ColorFilter.mode(Color(0xFFC3C3C3), BlendMode.srcIn),
                  ),
                ),
                label: 'Profil',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Color(0xFF7b94e4),
            selectedLabelStyle: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 10),
            unselectedLabelStyle: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 10),
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
