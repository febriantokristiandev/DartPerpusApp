import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../book_provider.dart';

class BukuPage extends StatefulWidget {
  const BukuPage({super.key});

  @override
  _BukuPageState createState() => _BukuPageState();
}

class _BukuPageState extends State<BukuPage> {
  List<Map<String, dynamic>> _books = [];
  List<Map<String, dynamic>> _filteredBooks = [];
  String selectedCategory = "Siap Baca";

  final List<String> categories = [
    "Siap Baca",
    "Terpinjam",
    "Wishlist",
    "Antrean",
    "Riwayat Pinjam"
  ];

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    final String response = await rootBundle.loadString('assets/buku.json');
    final List<dynamic> data = json.decode(response);

    setState(() {
      _books = data.cast<Map<String, dynamic>>();
      _filteredBooks = _books.where((book) {
        final bookProvider = Provider.of<BookProvider>(context, listen: false);
        bool isBorrowed = bookProvider.borrowedBooks.any((borrowedId) {
          return borrowedId.toString() == book['id'].toString();
        });
        return selectedCategory == "Siap Baca" && isBorrowed;
      }).toList();
    });
  }

  void _filterBooksByCategory(String category) {
    final bookProvider = Provider.of<BookProvider>(context, listen: false);
    setState(() {
      selectedCategory = category;

      if (category == "Siap Baca") {
        _filteredBooks = _books.where((book) {
          bool isBorrowed = bookProvider.borrowedBooks.any((borrowedId) {
            return borrowedId.toString() == book['id'].toString();
          });
          return isBorrowed;
        }).toList();
      } else if (category == "Terpinjam") {
        _filteredBooks = _books.where((book) {
          bool isBorrowed = bookProvider.borrowedBooks.any((borrowedId) {
            return borrowedId.toString() == book['id'].toString();
          });
          return isBorrowed;
        }).toList();
      } else if (category == "Wishlist") {
        _filteredBooks = _books.where((book) {
          bool isInWishlist = bookProvider.wishlist.any((wishlistId) {
            return wishlistId.toString() == book['id'].toString();
          });
          return isInWishlist;
        }).toList();
      } else if (category == "Antrean") {
        _filteredBooks = _books.where((book) {
          bool isQueue = bookProvider.queue.any((queueId) {
            return queueId.toString() == book['id'].toString();
          });
          return isQueue;
        }).toList();
      } else if (category == "Riwayat Pinjam") {
        _filteredBooks = _books.where((book) {
          final borrowAction = bookProvider.actionHistory.firstWhere(
              (action) =>
                  action['bookId'] == book['id'].toString() &&
                  action['action'] == 'borrow_book',
              orElse: () => {});
          final returnAction = bookProvider.actionHistory.firstWhere(
              (action) =>
                  action['bookId'] == book['id'].toString() &&
                  action['action'] == 'return_book',
              orElse: () => {});
          return borrowAction.isNotEmpty;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context, listen: false);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 120.0),
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _filterBooksByCategory(category);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        side: BorderSide(
                          color: const Color(0xFF7b94e4),
                        ),
                        backgroundColor: selectedCategory == category
                            ? const Color(0xFF7b94e4)
                            : const Color(0xFFebeded),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 20.0,
                        ),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: selectedCategory == category
                              ? Colors.white
                              : const Color(0xFF7b94e4),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 0.1),
          child: const Divider(
            color: Colors.grey,
            thickness: 0.5,
            height: 1,
          ),
        ),
        Expanded(
          child: _filteredBooks.isEmpty
              ? selectedCategory == "Antrean"
                  ? const Center(
                      child: Text(
                        'Antrean tidak ditemukan',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : selectedCategory == "Wishlist"
                      ? const Center(
                          child: Text(
                            'Wishlist tidak ditemukan',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : selectedCategory == "Riwayat Pinjam"
                          ? const Center(
                              child: Text(
                                'Riwayat pinjam tidak ditemukan',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : const Center(
                              child: Text(
                                'Tidak ada buku di kategori ini.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                            )
              : ListView.builder(
                  itemCount: _filteredBooks.length,
                  itemBuilder: (context, index) {
                    final book = _filteredBooks[index];
                    String borrowedDate = '';
                    String returnedDate = '';

                    // Get the action history for the current book
                    final actionHistory =
                        bookProvider.actionHistory.where((action) {
                      return action['bookId'] == book['id'].toString();
                    }).toList();

                    // Loop through the history to extract dates
                    for (var action in actionHistory) {
                      if (action['action'] == 'borrow_book') {
                        borrowedDate = action['timestamp']
                            .toLocal()
                            .toString()
                            .split(' ')[0]; // Get only the date part
                      } else if (action['action'] == 'return_book') {
                        returnedDate = action['timestamp']
                            .toLocal()
                            .toString()
                            .split(' ')[0]; // Get only the date part
                      }
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFC7D4FE),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/buku/${book["directory"]}',
                                width: 60,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    book["title"] ?? '',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF333333),
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                  ),
                                  const SizedBox(height: 8.0),
                                  if (selectedCategory == "Riwayat Pinjam") ...[
                                    Text(
                                      book["author"] ?? '',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                      ),
                                    ),
                                    Text(
                                      'Dipinjam pada: ${returnedDate.isNotEmpty ? returnedDate : "-"}',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        color: Color(0xFF333333),
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      'Dikembalikan pada: ${returnedDate.isNotEmpty ? returnedDate : "-"}',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        color: Color(0xFF333333),
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              title: Text(
                                                'Nilai buku ini!',
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 18,
                                                  color: Color(0xFF7289d3),
                                                ),
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Divider(
                                                    color: Color(0xFF8199E5),
                                                    thickness: 1.0,
                                                    indent:
                                                        0.0, // Pastikan tidak ada jarak kiri
                                                    endIndent:
                                                        0.0, // Pastikan tidak ada jarak kanan
                                                  ),
                                                  const SizedBox(height: 8.0),
                                                  Text(
                                                    book["title"] ??
                                                        "Judul Buku",
                                                    style: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 16,
                                                      color: Color(0xFF333333),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8.0),
                                                  Text(
                                                    'Rating:',
                                                    style: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14,
                                                      color: Color(0xFF333333),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: List.generate(5,
                                                        (index) {
                                                      if (index < 4) {
                                                        return Icon(
                                                          Icons.star,
                                                          color: const Color(
                                                              0xFF7B94E4),
                                                          size: 20,
                                                        );
                                                      } else if (index < 4.4) {
                                                        return Icon(
                                                          Icons.star_half,
                                                          color: const Color(
                                                              0xFF7B94E4),
                                                          size: 20,
                                                        );
                                                      } else {
                                                        return Icon(
                                                          Icons.star_border,
                                                          color: Colors.grey,
                                                          size: 20,
                                                        );
                                                      }
                                                    }),
                                                  ),
                                                  const SizedBox(height: 12.0),
                                                  Text(
                                                    'Ulasan:',
                                                    style: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14,
                                                      color: Color(0xFF333333),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8.0),
                                                  TextField(
                                                    maxLines: 4,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          "Tulis ulasan di sini...",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        borderSide: BorderSide(
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: OutlinedButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        style: OutlinedButton
                                                            .styleFrom(
                                                          side: const BorderSide(
                                                              color: Color(
                                                                  0xFF7B94E4)), // Outline color
                                                          backgroundColor:
                                                              const Color(
                                                                  0xFFDFE1E1), // Background color
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                      10.0),
                                                        ),
                                                        child: const Text(
                                                          'Batal',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xFF7B94E4), // Font color
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                        width:
                                                            8.0), // Spacing between buttons
                                                    Expanded(
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                              content: Text(
                                                                'Ulasan telah diberikan.',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFF535ED4),
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              margin: EdgeInsets
                                                                  .all(12.0),
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          2),
                                                            ),
                                                          );
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              const Color(
                                                                  0xFF535ED4), // Background color
                                                          foregroundColor: Colors
                                                              .white, // Text color
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                      10.0),
                                                        ),
                                                        child: const Text(
                                                          'Kirim Ulasan',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF535ed4),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 12.0),
                                        minimumSize: const Size(20, 32.5),
                                      ),
                                      child: const Text(
                                        'Beri Ulasan',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ] else if (selectedCategory == "Wishlist" ||
                                      selectedCategory == "Antrean") ...[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0, horizontal: 8.0),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF7b94e4),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: const Text(
                                            'Tersedia',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        ElevatedButton(
                                          onPressed: () {
                                            String notificationMessage = "";

                                            if (selectedCategory ==
                                                "Wishlist") {
                                              bookProvider.removeFromWishlist(
                                                  book['id'].toString());
                                              notificationMessage =
                                                  "Buku berhasil dihapus dari Wishlist.";
                                            } else if (selectedCategory ==
                                                "Antrean") {
                                              bookProvider.removeFromQueue(
                                                  book['id'].toString());
                                              notificationMessage =
                                                  "Buku berhasil dihapus dari Antrean.";
                                            }
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  notificationMessage,
                                                  style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    const Color(0xFF535ed4),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin:
                                                    const EdgeInsets.all(12.0),
                                                duration:
                                                    const Duration(seconds: 2),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            side: const BorderSide(
                                                color: Color(0xff535ed4)),
                                            backgroundColor:
                                                const Color(0xffc7d4fe),
                                            foregroundColor:
                                                const Color(0xFF535ed4),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 12.0),
                                            minimumSize: const Size(20, 32.5),
                                          ),
                                          child: const Text(
                                            'Hapus',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ] else if (selectedCategory == "Siap Baca" ||
                                      selectedCategory == "Terpinjam") ...[
                                    Text(
                                      'Tanggal Kembali: 04/05/2024',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        color: Color(0xFF333333),
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      '3 hari tersisa',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        color: Color(0xFF4a56c4),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        )
      ],
    );
  }
}
