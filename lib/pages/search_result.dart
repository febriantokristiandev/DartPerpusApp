import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'detail_buku_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchResultPage extends StatefulWidget {
  final String searchQuery;

  const SearchResultPage({
    Key? key,
    this.searchQuery = "",
  }) : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  TextEditingController _searchController = TextEditingController();
  String _selectedFilter = "Judul";

  List<dynamic> _books = [];
  List<dynamic> _filteredBooks = [];

  @override
  void initState() {
    super.initState();
    _loadBooks();
    _searchController.text = widget.searchQuery;
  }

  Future<void> _loadBooks() async {
    final String response = await rootBundle.loadString('assets/buku.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      _books = data;
      _filteredBooks = _filterBooks(widget.searchQuery);
    });
  }

  List<dynamic> _filterBooks(String query) {
    return _books.where((book) {
      switch (_selectedFilter) {
        case "Judul":
          return (book['title']?.toLowerCase() ?? "")
              .contains(query.toLowerCase());
        case "Penerbit":
          return (book['publisher']?.toLowerCase() ?? "")
              .contains(query.toLowerCase());
        case "Penulis":
          return (book['author']?.toLowerCase() ?? "")
              .contains(query.toLowerCase());
        default:
          return false; // Tidak cocok dengan filter yang tersedia
      }
    }).toList();
  }

  void _applyFilter(String? filter) {
    setState(() {
      _selectedFilter =
          filter ?? "Judul"; // Jika filter kosong, default ke "Judul"
      _filteredBooks = _filterBooks(_searchController.text);
    });
  }

  void onChangedFilter(String? value) {
    setState(() {
      _selectedFilter = value ?? "Judul";
    });
  }

  void _onSearchSubmitted(String query) {
    setState(() {
      _filteredBooks = _filterBooks(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEDED),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
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
                    color: Color(0xFFEBEDED),
                    borderRadius: BorderRadius.circular(1000),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: (String query) {
                      setState(() {
                        _filteredBooks = _filterBooks(query);
                      });
                    },
                    style: TextStyle(color: Color(0xFF545454)),
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
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.only(
                          left: 100.0, right: 100.0, bottom: 20.0),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  _searchController.clear();
                                  _filteredBooks = []; // Reset hasil filter
                                });
                              },
                              child: Icon(
                                Icons.clear,
                                color: Color(0xFF545454),
                              ),
                            )
                          : null,
                    ),
                    scrollPhysics: NeverScrollableScrollPhysics(),
                  ),
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                icon: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/images/icons/filter_icon_2.svg',
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    barrierColor: Colors.black.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (BuildContext context) {
                      final List<String> filters = [
                        "Judul",
                        "Penerbit",
                        "Penulis"
                      ];
                      return StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter setModalState) {
                          return DraggableScrollableSheet(
                            initialChildSize: 0.5,
                            minChildSize: 0.3,
                            maxChildSize: 0.9,
                            expand: false,
                            builder: (context, scrollController) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 40,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 12.0),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: IconButton(
                                            icon: SvgPicture.asset(
                                              'assets/images/icons/angle-small-left-icon.svg',
                                              height: 15,
                                              width: 15,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Filter Buku',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF7b94e4),
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      controller: scrollController,
                                      child: Column(
                                        children: filters.map((filter) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0,
                                                vertical: 8.0),
                                            child: InkWell(
                                              onTap: () {
                                                setModalState(() {
                                                  _selectedFilter = filter;
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      filter,
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xFF7b94e4),
                                                      ),
                                                    ),
                                                  ),
                                                  Radio<String>(
                                                    value: filter,
                                                    groupValue: _selectedFilter,
                                                    onChanged: (value) {
                                                      setModalState(() {
                                                        _selectedFilter =
                                                            value!;
                                                      });
                                                    },
                                                    activeColor:
                                                        Color(0xFF7b94e4),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 100.0,
                                        right: 100.0,
                                        bottom: 20.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _applyFilter(_selectedFilter);
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Terapkan Filter',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Color(0xFF7b94e4),
                                          ),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          padding: MaterialStateProperty.all(
                                            const EdgeInsets.symmetric(
                                                vertical: 12.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
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
      body: _books.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : _filteredBooks.isEmpty
              ? const Center(
                  child: Text(
                    'Maaf, buku yang kamu cari tidak ditemukan.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                )
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
                                        Text(
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
