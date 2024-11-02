import 'package:flutter/material.dart';

void main() {
  runApp(VKIHesaplayiciUygulama());
}

class VKIHesaplayiciUygulama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VKIHesaplayici(),
    );
  }
}

class VKIHesaplayici extends StatefulWidget {
  @override
  _VKIHesaplayiciDurumu createState() => _VKIHesaplayiciDurumu();
}

class _VKIHesaplayiciDurumu extends State<VKIHesaplayici> {
  bool cinsiyetErkek = true;
  double boy = 170;
  int kilo = 60;
  int yas = 25;
  double vki = 0;

  void vkiHesapla() {
    vki = kilo / ((boy / 100) * (boy / 100));
    String sonuc = "";

    if (vki < 18.5) {
      sonuc = "Zayıf";
    } else if (vki >= 18.5 && vki < 24.9) {
      sonuc = "Normal";
    } else if (vki >= 25 && vki < 29.9) {
      sonuc = "Kilolu";
    } else {
      sonuc = "Obez";
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SonucSayfasi(vki: vki, sonuc: sonuc),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("VKI Hesaplayıcı"),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Container(
        color: Colors.blueGrey[800],
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: CinsiyetKart(
                    etiket: "ERKEK",
                    ikon: Icons.male,
                    secili: cinsiyetErkek,
                    tiklama: () {
                      setState(() {
                        cinsiyetErkek = true;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CinsiyetKart(
                    etiket: "KADIN",
                    ikon: Icons.female,
                    secili: !cinsiyetErkek,
                    tiklama: () {
                      setState(() {
                        cinsiyetErkek = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Boy",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Text(
              "${boy.toInt()} cm",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Slider(
              value: boy,
              min: 100,
              max: 220,
              onChanged: (deger) {
                setState(() {
                  boy = deger;
                });
              },
            ),
            Row(
              children: [
                Expanded(
                  child: SayacKart(
                    etiket: "Kilo",
                    deger: kilo,
                    artirma: () {
                      setState(() {
                        kilo++;
                      });
                    },
                    azaltma: () {
                      setState(() {
                        if (kilo > 0) kilo--;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: SayacKart(
                    etiket: "Yaş",
                    deger: yas,
                    artirma: () {
                      setState(() {
                        yas++;
                      });
                    },
                    azaltma: () {
                      setState(() {
                        if (yas > 0) yas--;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: vkiHesapla,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              child: Text("HESAPLA"),
            ),
          ],
        ),
      ),
    );
  }
}

class CinsiyetKart extends StatelessWidget {
  final String etiket;
  final IconData ikon;
  final bool secili;
  final VoidCallback tiklama;

  CinsiyetKart({required this.etiket, required this.ikon, required this.secili, required this.tiklama});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tiklama,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: secili ? Colors.blueGrey[600] : Colors.blueGrey[700],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(ikon, color: Colors.white, size: 40),
            SizedBox(height: 10),
            Text(etiket, style: TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

class SayacKart extends StatelessWidget {
  final String etiket;
  final int deger;
  final VoidCallback artirma;
  final VoidCallback azaltma;

  SayacKart({required this.etiket, required this.deger, required this.artirma, required this.azaltma});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blueGrey[700],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(etiket, style: TextStyle(color: Colors.white, fontSize: 18)),
          Text(deger.toString(), style: TextStyle(color: Colors.white, fontSize: 30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: azaltma,
                icon: Icon(Icons.remove, color: Colors.white),
              ),
              IconButton(
                onPressed: artirma,
                icon: Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SonucSayfasi extends StatelessWidget {
  final double vki;
  final String sonuc;

  SonucSayfasi({required this.vki, required this.sonuc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("VKI Değeri"),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Container(
        color: Colors.blueGrey[800],
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "VKI Değeri",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              Text(
                vki.toStringAsFixed(1),
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
              Text(
                sonuc,
                style: TextStyle(
                    color: sonuc == "Normal" ? Colors.green : Colors.red,
                    fontSize: 24),
              ),
              SizedBox(height: 20),
              Text(
                sonuc == "Normal"
                    ? "Normal bir vücut ağırlığınız var. Aferin!"
                    : "Sağlığınıza dikkat edin!",
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                child: Text("YENİDEN HESAPLA"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
