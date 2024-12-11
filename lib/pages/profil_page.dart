import 'package:flutter/material.dart';
import './login_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 250.0, bottom: 30.0)
                .add(EdgeInsets.symmetric(horizontal: 40.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Color(0xFFebf0ff),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/icons/envelope_icon.svg',
                          width: 18,
                          height: 18,
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'johndoe@gmail.com',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFc7d4fe),
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1000),
                      ),
                    ),
                    child: Text(
                      'Ubah Kata Sandi',
                      style: TextStyle(
                        color: Color(0xFF5f6fd8),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Color(0xFF5f6fd8),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lainnya',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          ..._buildMenuItems(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Color(0xFF7b94e4)),
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: Colors.transparent,
                  minimumSize: Size(200, 43),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/images/icons/logout_icon.svg',
                      width: 14,
                      height: 14,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Keluar',
                      style: TextStyle(
                        color: Color(0xFF7b94e4),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildMenuItems() {
    return [
      _buildMenuItem(
        icon: 'assets/images/icons/language_icon.svg',
        title: 'Bahasa',
        onTap: () {},
      ),
      _buildMenuItem(
        icon: 'assets/images/icons/dark_mode_icon.svg',
        title: 'Dark Mode',
        onTap: () {},
      ),
      _buildMenuItem(
        icon: 'assets/images/icons/about_us_icon.svg',
        title: 'Tentang Kami',
        onTap: () {},
      ),
    ];
  }

  Widget _buildMenuItem({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
          child: TextButton(
            onPressed: onTap,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              textStyle: TextStyle(
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 35,
                  height: 35,
                  child: Center(
                    child: SvgPicture.asset(
                      icon,
                      width: 18,
                      height: 18,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(title),
                Spacer(),
                SvgPicture.asset(
                  'assets/images/icons/pointer_icon.svg',
                  width: 16,
                  height: 16,
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Color(0xFFc7d4fe),
        ),
      ],
    );
  }
}
