import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'profile.dart';
import 'homepage.dart';
import 'daftar_request.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.title});

  final String title;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String nim = '2241760046';

  void _editProfile() {
    print('Edit Profile');
  }

  void _logOut() {
    print('Log Out');
  }

  void _indexMhs() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MhsHomepageHutang()));
  }

  void _tugasMhs() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MhsDaftarRequest()));
  }

  void _notifMhs() {
    print('Notifikasi Mahasiswa');
  }

  void _profileMhs() {
    print('Profile Mahasiswa');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const MhsProfilePage(title: 'Sistem Kompensasi')));
  }

  void _saveEdit() {
    print('Simpan data');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const MhsProfilePage(title: 'Sistem Kompensasi')),
                    (Route<dynamic> route) => false);
              },
              child: const AlertDialog(
                  title: Text(
                    'Perubahan berhasil disimpan!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  content: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline_outlined,
                        size: 50,
                        color: Colors.green,
                      )
                    ],
                  )));
        });
  }

  void _confirmEdit() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Simpan Perubahan?',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _saveEdit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min, // Adjust size to content
                    children: <Widget>[
                      Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff2d1b6b),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                        text: 'J',
                        style: TextStyle(
                            color: Colors.brown,
                            fontSize: 19,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: 'T',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'I',
                      style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ' Polinema',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                      ),
                    ),
                  ]),
                )
              ],
            ),
            IconButton(
                onPressed: _notifMhs,
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(
                  child: Icon(
                Icons.account_circle_outlined,
                size: 100,
              )),
              const SizedBox(height: 20),
              const Text(
                'Nama Lengkap',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Nama Lengkap',
                  hintStyle: TextStyle(color: Color(0xffd9d9d9)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Color(0xFFd9d9d9),
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'NIM',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 500,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                    color: const Color(0xFFDCDCDC),
                    border:
                        Border.all(color: const Color(0xFFE4E4E4), width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  nim,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Program Studi',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Program Studi',
                  hintStyle: TextStyle(color: Color(0xffd9d9d9)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Color(0xFFd9d9d9),
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Kelas',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Kelas',
                  hintStyle: TextStyle(color: Color(0xffd9d9d9)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Color(0xFFd9d9d9),
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'No. HP',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  hintText: '08XXXXXX',
                  hintStyle: TextStyle(color: Color(0xffd9d9d9)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Color(0xFFd9d9d9),
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Kompetensi',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Kompetensi',
                  hintStyle: TextStyle(color: Color(0xffd9d9d9)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Color(0xFFd9d9d9),
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: _confirmEdit,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          backgroundColor: const Color(0xFF2c2c2c),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.save_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )),
                  ]),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
          height: 70,
          child: Container(
            color: const Color(0xff2d1b6b),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: _indexMhs,
                    icon: const Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                      size: 35,
                    )),
                IconButton(
                    onPressed: _notifMhs,
                    icon: const Icon(
                      Icons.list_sharp,
                      color: Colors.white,
                      size: 30,
                    )),
                IconButton(
                    onPressed: _notifMhs,
                    icon: const Icon(
                      CupertinoIcons.briefcase,
                      color: Colors.white,
                      size: 30,
                    )),
                IconButton(
                    onPressed: _notifMhs,
                    icon: const Icon(Icons.account_circle_outlined,
                        color: Colors.white, size: 35))
              ],
            ),
          )),
    );
  }
}
