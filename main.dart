import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF4B4022),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String hasilSapa = "";
  String hasilLuas = "";
  String hasilDiskon = "";

  TextEditingController nama = TextEditingController();
  TextEditingController sisi = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController diskon = TextEditingController();

  // FUNCTION
  String sapa(String n) => "Halo, $n 🤎";
  int luas(int s) => s * s;
  double hitungDiskon(double h, double d) => h - (h * d);

  Widget button(String text, VoidCallback onTap, {Color? color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color ?? Color(0xFF8B6F3D),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Color(0xFFFDEBBA),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget input(String hint, TextEditingController c) {
    return TextField(
      controller: c,
      style: TextStyle(color: Color(0xFFFDEBBA)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Color(0xFF6B532D),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget card(String title, List<Widget> children, String hasil) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF6B532D),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: Color(0xFFFDEBBA),
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          SizedBox(height: 10),
          ...children,
          if (hasil.isNotEmpty) ...[
            SizedBox(height: 10),
            Text(
              hasil,
              style: TextStyle(
                color: Color(0xFFFDEBBA),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ]
        ],
      ),
    );
  }

  void clearAll() {
    setState(() {
      nama.clear();
      sisi.clear();
      harga.clear();
      diskon.clear();

      hasilSapa = "";
      hasilLuas = "";
      hasilDiskon = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("🤎 Fungsi App"),
        backgroundColor: Color(0xFF4B4022),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [

            // MENYAPA
            card("Menyapa", [
              input("Masukkan nama", nama),
              button("Sapa", () {
                setState(() {
                  hasilSapa = sapa(nama.text);
                });
              }),
              button("Clear", () {
                setState(() {
                  nama.clear();
                  hasilSapa = "";
                });
              }, color: Colors.grey),
            ], hasilSapa),

            // PERSEGI
            card("Luas Persegi", [
              input("Masukkan sisi", sisi),
              button("Hitung Luas", () {
                setState(() {
                  hasilLuas = "Luas Persegi: ${luas(int.parse(sisi.text))}";
                });
              }),
              button("Clear", () {
                setState(() {
                  sisi.clear();
                  hasilLuas = "";
                });
              }, color: Colors.grey),
            ], hasilLuas),

            // DISKON
            card("Diskon", [
              input("Masukkan harga", harga),
              input("Masukkan diskon", diskon),
              button("Hitung Diskon", () {
                setState(() {
                  hasilDiskon = "Harga setelah diskon: ${hitungDiskon(
                    double.parse(harga.text),
                    double.parse(diskon.text),
                  )}";
                });
              }),
              button("Clear", () {
                setState(() {
                  harga.clear();
                  diskon.clear();
                  hasilDiskon = "";
                });
              }, color: Colors.grey),
            ], hasilDiskon),

            // CLEAR ALL
            button("CLEAR ALL", clearAll, color: Colors.red),
          ],
        ),
      ),
    );
  }
}