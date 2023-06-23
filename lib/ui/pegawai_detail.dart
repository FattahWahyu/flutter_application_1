import 'dart:async';
import 'package:flutter/material.dart';
import '../service/pegawai_service.dart';
import 'pegawai_page.dart';
import 'pegawai_update_form.dart';
import '../model/pegawai.dart';
import 'package:intl/intl.dart';

class PegawaiDetail extends StatefulWidget {
  final Pegawai pegawai;

  const PegawaiDetail({Key? key, required this.pegawai}) : super(key: key);

  @override
  PegawaiDetailState createState() => PegawaiDetailState();
}

class PegawaiDetailState extends State<PegawaiDetail> {
  Future<Pegawai> getData() async {
    Pegawai data = await PegawaiService().getById(widget.pegawai.id.toString());
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Pegawai")),
      body: FutureBuilder<Pegawai>(
        future: getData(),
        builder: (context, AsyncSnapshot<Pegawai> snapshot) {
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
          Pegawai data = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _buildDetailRow("Nama Pegawai", data.namaPegawai),
                _buildDetailRow("NIP", data.nip),
                _buildDetailRow("Tanggal Lahir", data.tanggalLahir.toString()),
                _buildDetailRow("Nomor Telepon", data.nomorTelepon),
                _buildDetailRow("Email", data.email),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [_tombolUbah(data), _tombolHapus(data)],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              ":",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              label == 'Tanggal Lahir'
                  ? DateFormat('dd MMMM yyyy').format(DateTime.parse(value))
                  : value,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }

  _tombolUbah(Pegawai pegawai) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PegawaiUpdateForm(pegawai: pegawai),
          ),
        );
      },
      style: ElevatedButton.styleFrom(primary: Colors.green),
      child: const Text("Ubah"),
    );
  }

  _tombolHapus(Pegawai pegawai) {
    return ElevatedButton(
      onPressed: () {
        AlertDialog alertDialog = AlertDialog(
          content: const Text("Yakin ingin menghapus data ini?"),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await PegawaiService().hapus(pegawai).then((value) {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PegawaiPage(),
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
