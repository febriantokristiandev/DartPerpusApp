import 'package:flutter/material.dart';

class ReadBookPage extends StatefulWidget {
  final String title;
  final String directory;

  const ReadBookPage({
    Key? key,
    required this.title,
    required this.directory,
  }) : super(key: key);

  @override
  State<ReadBookPage> createState() => _ReadBookPageState();
}

class _ReadBookPageState extends State<ReadBookPage> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildCoverPage(),
      _buildContentPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.normal,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFEBEDED),
      body: Stack(
        children: [
          pages[_currentPage],
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentPage > 0
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _currentPage--;
                            });
                          },
                          icon: const Icon(Icons.arrow_back),
                          color: Color(0xFF7B94E4),
                        )
                      : const SizedBox(
                          width:
                              48), // Beri lebar tetap untuk menghindari pergeseran
                  Expanded(
                    child: Text(
                      'Halaman ${_currentPage + 1} / ${pages.length}',
                      textAlign: TextAlign.center, // Posisikan teks di tengah
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF7B94E4),
                      ),
                    ),
                  ),
                  _currentPage < pages.length - 1
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _currentPage++;
                            });
                          },
                          icon: const Icon(Icons.arrow_forward),
                          color: Color(0xFF7B94E4),
                        )
                      : const SizedBox(
                          width:
                              48), // Beri lebar tetap untuk menghindari pergeseran
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoverPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.normal,
              fontFamily: 'Poppins',
              color: Color(0xFF7B94E4),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 200,
            height: 300,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                'assets/buku/${widget.directory}',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
          "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
          "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
          "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
          "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. "
          "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia "
          "deserunt mollit anim id est laborum.",
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
