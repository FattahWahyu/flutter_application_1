import 'package:flutter/material.dart';
import '../model/pasien.dart';
import '../service/pasien_service.dart';
import 'pasien_detail.dart';
import 'package:intl/intl.dart';

class PasienUpdateForm extends StatefulWidget {
  final Pasien pasien;

  const PasienUpdateForm({Key? key, required this.pasien}) : super(key: key);
  _PasienUpdateFormState createState() => _PasienUpdateFormState();
}

class _PasienUpdateFormState extends State<PasienUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomorRmCtrl = TextEditingController();
  final _namaPasienCtrl = TextEditingController();
  final _tanggalLahirCtrl = TextEditingController();
  final _nomorTeleponCtrl = TextEditingController();
  final _alamatCtrl = TextEditingController();

  Future<Pasien> getData() async {
    Pasien data = await PasienService().getById(widget.pasien.id.toString());
    setState(() {
      if (data.nomorRm != null) {
        _nomorRmCtrl.text = data.nomorRm;
      }
      if (data.namaPasien != null) {
        _namaPasienCtrl.text = data.namaPasien;
      }
      if (data.tanggalLahir != null) {
        _tanggalLahirCtrl.text =
            DateFormat('yyyy-MM-dd').format(data.tanggalLahir);
      }
      if (data.nomorTelepon != null) {
        _nomorTeleponCtrl.text = data.nomorTelepon;
      }
      if (data.alamat != null) {
        _alamatCtrl.text = data.alamat;
      }
    });
    return data;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Pegawai")),
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Tanggal lahir tidak boleh kosong';
            }
            return null;
          },
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
        if (_formKey.currentState!.validate()) {
          Pasien pasien = Pasien(
            nomorRm: _nomorRmCtrl.text,
            namaPasien: _namaPasienCtrl.text,
            tanggalLahir: DateTime.parse(
                _tanggalLahirCtrl.text), // Mengubah String menjadi DateTime
            nomorTelepon: _nomorTeleponCtrl.text,
            alamat: _alamatCtrl.text,
          );
          String id = widget.pasien.id.toString();
          await PasienService().ubah(pasien, id).then((value) {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PasienDetail(pasien: value),
              ),
            );
          });
        }
      },
      child: const Text("Simpan Perubahan"),
    );
  }
}
