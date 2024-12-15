import 'package:flutter/material.dart';
import '../book_provider.dart';
import './read_book_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookDetailPage extends StatelessWidget {
  final Map<String, dynamic> book;

  const BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    bool isInWishlist = bookProvider.wishlist.contains(book['id'].toString());
    bool isInQueue = bookProvider.queue.contains(book['id'].toString());
    bool isBorrowed =
        bookProvider.borrowedBooks.contains(book['id'].toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Buku',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Color(0xFF545454),
            fontFamily: 'Poppins',
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFebeded),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    'assets/buku/${book["directory"]}',
                    height: 200,
                    width: 150,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                book['title'] ?? 'Tidak ada judul',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(5, (index) {
                    if (index < 4) {
                      return Icon(
                        Icons.star,
                        color: const Color(0xFF7B94E4),
                        size: 20,
                      );
                    } else if (index < 4.4) {
                      return Icon(
                        Icons.star_half,
                        color: const Color(0xFF7B94E4),
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
                  const SizedBox(width: 8),
                  const Text(
                    '4.4/5',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Halaman',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${book['pages'] ?? 'Tidak tersedia'}',
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins',
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(width: 50),
                  Column(
                    children: [
                      const Text(
                        'Ukuran file',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${book['size']} MB',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 50),
                  Column(
                    children: [
                      const Text(
                        'Copy tersedia',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${book['copies']}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      bottom: 10.0,
                    ),
                    child: const Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                      height: 1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/icons/calendar-clock-icon.svg',
                        height: 32,
                        width: 32,
                      ),
                      const SizedBox(width: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Batas waktu peminjaman: 7 hari',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins',
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Buku akan dikembalikan pada 23/12/24',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins',
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: const Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                      height: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Diterbitkan oleh',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            book['publisher'] ?? 'Tidak tersedia',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Tahun terbit',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            book['publish_year'] != null
                                ? '${book['publish_year']}'
                                : 'Tidak tersedia',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Kategori',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            book['category'] ?? 'Tidak tersedia',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: const Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                      height: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 15.0,
                      bottom: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sinopsis',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                          'Consequentia exquirere, quoad sit id, quod volumus, effectum. '
                          'Et nemo nimium beatus est; Duo Reges: constructio interrete. '
                          'Quamquam non negatis nos intellegere quid sit voluptas, sed quid ille dicat. '
                          'Quia dolori non voluptas contraria est, sed doloris privatio. '
                          'Cur igitur easdem res, inquam, Peripateticis dicentibus verbum nullum est, quod non intellegatur?',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins',
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: const Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                      height: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 15.0,
                      bottom: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/images/person_dummy/person_1.png',
                                width: 25,
                                height: 25,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Alya P.',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            ...List.generate(5, (index) {
                              if (index < 4) {
                                return const Icon(
                                  Icons.star,
                                  color: Color(0xFF7B94E4),
                                  size: 20,
                                );
                              } else if (index < 4.0) {
                                return const Icon(
                                  Icons.star_half,
                                  color: Color(0xFF7B94E4),
                                  size: 20,
                                );
                              } else {
                                return const Icon(
                                  Icons.star_border,
                                  color: Colors.grey,
                                  size: 20,
                                );
                              }
                            }),
                            const SizedBox(width: 8),
                            const Text(
                              '7/24/23',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Buku ini benar-benar membuka wawasan baru! Alur ceritanya mengalir dengan gaya bahasa yang ringan namun penuh makna. Hanya saja, beberapa bagian terasa terlalu cepat selesai.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 15.0,
                      bottom: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/images/person_dummy/person_2.png',
                                width: 25,
                                height: 25,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Rizky S.',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            ...List.generate(5, (index) {
                              if (index < 4) {
                                return const Icon(
                                  Icons.star,
                                  color: Color(0xFF7B94E4),
                                  size: 20,
                                );
                              } else if (index < 4.0) {
                                return const Icon(
                                  Icons.star_half,
                                  color: Color(0xFF7B94E4),
                                  size: 20,
                                );
                              } else {
                                return const Icon(
                                  Icons.star_border,
                                  color: Colors.grey,
                                  size: 20,
                                );
                              }
                            }),
                            const SizedBox(width: 8),
                            const Text(
                              '5/13/23',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Saya merasa terhubung dengan tokoh utama di buku ini. Pesan moralnya menyentuh dan relate dengan kehidupan sehari-hari. Sangat direkomendasikan untuk pembaca muda.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 15.0,
                      bottom: 250.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/images/person_dummy/person_1.png',
                                width: 25,
                                height: 25,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Nadia L.',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            ...List.generate(5, (index) {
                              if (index < 4) {
                                return const Icon(
                                  Icons.star,
                                  color: Color(0xFF7B94E4),
                                  size: 20,
                                );
                              } else if (index < 4.0) {
                                return const Icon(
                                  Icons.star_half,
                                  color: Color(0xFF7B94E4),
                                  size: 20,
                                );
                              } else {
                                return const Icon(
                                  Icons.star_border,
                                  color: Colors.grey,
                                  size: 20,
                                );
                              }
                            }),
                            const SizedBox(width: 8),
                            const Text(
                              '3/11/23',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Cerita yang cukup menarik, tetapi saya merasa ada beberapa bagian yang kurang mendalam. Namun, ilustrasinya sangat indah dan menambah daya tarik buku ini.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFEBEDED),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6.0,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: isInWishlist
                    ? () {
                        bookProvider.removeFromWishlist(book['id'].toString());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Buku dihapus dari Wishlist'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    : isBorrowed
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReadBookPage(
                                  title: book['title'].toString(),
                                  directory: book['directory'],
                                ),
                              ),
                            );
                          }
                        : () {
                            bookProvider.addToWishlist(book['id'].toString());
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Buku ditambahkan ke Wishlist'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isBorrowed
                      ? const Color(0xFF7B94E4)
                      : const Color(0xFFEBEDED),
                  side: const BorderSide(color: Color(0xFF7B94E4)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
                child: Text(
                  isBorrowed
                      ? "Baca Sekarang"
                      : (isInWishlist ? "Remove from wishlist" : "+ Wishlist"),
                  style: TextStyle(
                    color: isBorrowed
                        ? Colors.white
                        : const Color(
                            0xFF7B94E4), // White color for "Baca Sekarang"
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: ElevatedButton(
                onPressed: book['status'] == 'unavailable'
                    ? isInQueue
                        ? () {
                            bookProvider.removeFromQueue(book['id'].toString());
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Queue canceled successfully'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        : () {
                            bookProvider.addToQueue(book['id'].toString());
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Buku sedang tidak tersedia. Anda ditambahkan ke antrean.'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                    : isBorrowed
                        ? () {
                            bookProvider.returnBook(book['id'].toString());
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Buku telah dikembalikan'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        : () {
                            bookProvider.borrowBook(book['id'].toString());
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Buku berhasil dipinjam'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isBorrowed || isInQueue
                      ? const Color(0xFFEBEDED)
                      : const Color(0xFF7B94E4),
                  side: BorderSide(
                    color: isBorrowed || book['status'] == 'unavailable'
                        ? const Color(0xFF7B94E4)
                        : Colors.transparent,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
                child: Text(
                  book['status'] == 'unavailable'
                      ? isInQueue
                          ? "Batalkan antrean"
                          : "Antre"
                      : isBorrowed
                          ? "Kembalikan"
                          : "Pinjam",
                  style: TextStyle(
                    color: book['status'] == 'unavailable'
                        ? isInQueue
                            ? const Color(
                                0xFF7B94E4) // Warna khusus untuk "Batalkan antrean"
                            : Colors.white
                        : isBorrowed
                            ? const Color(0xFF7B94E4)
                            : Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
