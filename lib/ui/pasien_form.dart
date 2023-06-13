import 'package:flutter/material.dart';
import '../model/pasien.dart';
import '../service/pasien_service.dart';
import 'pasien_detail.dart';
import 'package:intl/intl.dart';

class PasienForm extends StatefulWidget {
  const PasienForm({Key? key}) : super(key: key);
  _PasienFormState createState() => _PasienFormState();
}

class _PasienFormState extends State<PasienForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomorRmCtrl = TextEditingController();
  final _namaPasienCtrl = TextEditingController();
  final _tanggalLahirCtrl = TextEditingController();
  final _nomorTeleponCtrl = TextEditingController();
  final _alamatCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Pasien")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _fieldNomorRM(),
              _fieldNamaPasien(),
              _fieldTanggalLahir(),
              _fieldNomorTelepon(),
              _fieldAlamat(),
              SizedBox(height: 20),
              _tombolSimpan()
            ],
          ),
        ),
      ),
    );
  }

  _fieldNomorRM() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nomor RM"),
      controller: _nomorRmCtrl,
    );
  }

  _fieldNamaPasien() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Pasien"),
      controller: _namaPasienCtrl,
    );
  }

  _fieldTanggalLahir() {
    return GestureDetector(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        ).then((selectedDate) {
          if (selectedDate != null) {
            setState(() {
              _tanggalLahirCtrl.text =
                  DateFormat('yyyy-MM-dd').format(selectedDate);
            });
          }
        });
      },
      child: AbsorbPointer(
        child: TextFormField(
          decoration: const InputDecoration(labelText: "Tanggal Lahir"),
          controller: _tanggalLahirCtrl,
        ),
      ),
    );
  }

  _fieldNomorTelepon() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nomor Telepon"),
      controller: _nomorTeleponCtrl,
    );
  }

  _fieldAlamat() {
    return TextField(
      decoration: const InputDecoration(labelText: "Alamat"),
      controller: _alamatCtrl,
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        DateTime tanggalLahir = DateFormat('yyyy-MM-dd')
            .parse(_tanggalLahirCtrl.text); // Mengubah string ke objek DateTime
        Pasien pasien = new Pasien(
            nomorRm: _nomorRmCtrl.text,
            namaPasien: _namaPasienCtrl.text,
            tanggalLahir: tanggalLahir,
            nomorTelepon: _nomorTeleponCtrl.text,
            alamat: _alamatCtrl.text,);
        await PasienService().simpan(pasien).then((value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PasienDetail(pasien: value),
            ),
          );
        });
      },
      child: const Text("Simpan"),
    );
  }
}
