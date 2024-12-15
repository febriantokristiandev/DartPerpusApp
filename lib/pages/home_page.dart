import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'detail_buku_page.dart';

class HomePage extends StatefulWidget {
  // final String searchQuery;
  final String? selectedCategory;

  const HomePage({
    Key? key,
    // this.searchQuery = "",
    this.selectedCategory,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _books = [];
  List<dynamic> _filteredBooks = [];

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    final String response = await rootBundle.loadString('assets/buku.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      _books = data;
      _filteredBooks = data;
    });
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (oldWidget.searchQuery != widget.searchQuery ||
    //     oldWidget.selectedCategory != widget.selectedCategory) {
    //   _filterBooks(widget.searchQuery, widget.selectedCategory);
    // }

    if (oldWidget.selectedCategory != widget.selectedCategory) {
      _filterBooks(widget.selectedCategory);
    }
  }

  // void _filterBooks(String query, String? category) {
  //   setState(() {
  //     _filteredBooks = _books.where((book) {
  //       final matchesSearchQuery = query.isEmpty ||
  //           (book['title']?.toLowerCase() ?? "")
  //               .contains(query.toLowerCase()) ||
  //           (book['author']?.toLowerCase() ?? "").contains(query.toLowerCase());
  //       final matchesCategory = category == null ||
  //           category == "All categories" ||
  //           (book['category'] == category);
  //       return matchesSearchQuery && matchesCategory;
  //     }).toList();
  //   });
  // }

  void _filterBooks(String? category) {
    setState(() {
      _filteredBooks = _books.where((book) {
        final matchesCategory = category == null ||
            category == "All categories" ||
            (book['category'] == category);
        return matchesCategory;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEDED),
      body: _books.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : _filteredBooks.isEmpty
              ? const Center(
                  child: Text(
                  'Maaf, buku yang kamu cari \n tidak ditemukan.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ))
              : Center(
                  child: SingleChildScrollView(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount = 2;
                        if (constraints.maxWidth > 600) {
                          crossAxisCount = 3;
                        }
                        if (constraints.maxWidth > 900) {
                          crossAxisCount = 4;
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 20.0,
                              childAspectRatio: 2 / 3,
                            ),
                            itemCount: _filteredBooks.length,
                            itemBuilder: (context, index) {
                              final book = _filteredBooks[index];
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.transparent,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BookDetailPage(book: book),
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        height: 210,
                                        width: 180,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          child: Image.asset(
                                            'assets/buku/${book["directory"]}',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BookDetailPage(book: book),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            book["title"] ?? "-",
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF545454),
                                              fontFamily: 'Poppins',
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BookDetailPage(book: book),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            book["author"] ?? "-",
                                            style: const TextStyle(
                                              fontSize: 8,
                                              color: Colors.grey,
                                              fontFamily: 'Poppins',
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
    );
  }
}
