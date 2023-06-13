import 'dart:async';
import 'package:flutter/material.dart';
import '../service/pasien_service.dart';
import 'pasien_page.dart';
import 'pasien_update_form.dart';
import '../model/pasien.dart';

class PasienDetail extends StatefulWidget {
  final Pasien pasien;

  const PasienDetail({Key? key, required this.pasien}) : super(key: key);

  @override
  PasienDetailState createState() => PasienDetailState();
}

class PasienDetailState extends State<PasienDetail> {
  Future<Pasien> getData() async {
    Pasien data = await PasienService().getById(widget.pasien.id.toString());
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Pasien")),
      body: FutureBuilder<Pasien>(
        future: getData(),
        builder: (context, AsyncSnapshot<Pasien> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Text('Data Tidak Ditemukan');
          }
          Pasien data = snapshot.data!;
          return Column(
            children: [
              SizedBox(height: 20),
              Text(
                "Nama Pasien: ${data.namaPasien}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Text(
                "Nomor RM: ${data.nomorRm}",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Tanggal Lahir: ${data.tanggalLahir.toString()}",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Nomor Telepon: ${data.nomorTelepon}",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Alamat: ${data.alamat}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [_tombolUbah(data), _tombolHapus(data)],
              ),
            ],
          );
        },
      ),
    );
  }

  _tombolUbah(Pasien pasien) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PasienUpdateForm(pasien: pasien),
          ),
        );
      },
      style: ElevatedButton.styleFrom(primary: Colors.green),
      child: const Text("Ubah"),
    );
  }

  _tombolHapus(Pasien pasien) {
    return ElevatedButton(
      onPressed: () {
        AlertDialog alertDialog = AlertDialog(
          content: const Text("Yakin ingin menghapus data ini?"),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await PasienService().hapus(pasien).then((value) {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PasienPage(),
                    ),
                  );
                });
              },
              child: const Text("YA"),
              style: ElevatedButton.styleFrom(primary: Colors.red),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Tidak"),
              style: ElevatedButton.styleFrom(primary: Colors.green),
            ),
          ],
        );
        showDialog(
          context: context,
          builder: (context) => alertDialog,
        );
      },
      style: ElevatedButton.styleFrom(primary: Colors.red),
      child: const Text("Hapus"),
    );
  }
}
