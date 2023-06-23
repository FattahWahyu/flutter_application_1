import 'package:flutter/material.dart';
import '../model/pegawai.dart';
import '../service/pegawai_service.dart';
import 'pegawai_detail.dart';
import 'package:intl/intl.dart';

class PegawaiUpdateForm extends StatefulWidget {
  final Pegawai pegawai;

  const PegawaiUpdateForm({Key? key, required this.pegawai}) : super(key: key);
  _PegawaiUpdateFormState createState() => _PegawaiUpdateFormState();
}

class _PegawaiUpdateFormState extends State<PegawaiUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _nipCtrl = TextEditingController();
  final _namaPegawaiCtrl = TextEditingController();
  final _tanggalLahirCtrl = TextEditingController();
  final _nomorTeleponCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  Future<Pegawai> getData() async {
    Pegawai data = await PegawaiService().getById(widget.pegawai.id.toString());
    setState(() {
      if (data.nip != null) {
        _nipCtrl.text = data.nip;
      }
      if (data.namaPegawai != null) {
        _namaPegawaiCtrl.text = data.namaPegawai;
      }
      if (data.tanggalLahir != null) {
        _tanggalLahirCtrl.text =
            DateFormat('yyyy-MM-dd').format(data.tanggalLahir);
      }
      if (data.nomorTelepon != null) {
        _nomorTeleponCtrl.text = data.nomorTelepon;
      }
      if (data.email != null) {
        _emailCtrl.text = data.email;
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
              _fieldNip(),
              _fieldNamaPegawai(),
              _fieldTanggalLahir(),
              _fieldNomorTelepon(),
              _fieldEmail(),
              _fieldPassword(),
              SizedBox(height: 20),
              _tombolSimpan()
            ],
          ),
        ),
      ),
    );
  }

  _fieldNip() {
    return TextField(
      decoration: const InputDecoration(labelText: "NIP"),
      controller: _nipCtrl,
    );
  }

  _fieldNamaPegawai() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Pegawai"),
      controller: _namaPegawaiCtrl,
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

  _fieldEmail() {
    return TextField(
      decoration: const InputDecoration(labelText: "Email"),
      controller: _emailCtrl,
    );
  }

  _fieldPassword() {
    return TextField(
      decoration: const InputDecoration(labelText: "Password"),
      controller: _passwordCtrl,
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          Pegawai pegawai = Pegawai(
            nip: _nipCtrl.text,
            namaPegawai: _namaPegawaiCtrl.text,
            tanggalLahir: DateTime.parse(
                _tanggalLahirCtrl.text), // Mengubah String menjadi DateTime
            nomorTelepon: _nomorTeleponCtrl.text,
            email: _emailCtrl.text,
          );
          String id = widget.pegawai.id.toString();
          await PegawaiService().ubah(pegawai, id).then((value) {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PegawaiDetail(pegawai: value),
              ),
            );
          });
        }
      },
      child: const Text("Simpan Perubahan"),
    );
  }
}
