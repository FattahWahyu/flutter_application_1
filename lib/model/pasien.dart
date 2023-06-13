class Pasien {
  int? id;
  String nomorRm;
  String namaPasien;
  DateTime tanggalLahir;
  String nomorTelepon;
  String alamat;

  Pasien({
    this.id,
    required this.nomorRm,
    required this.namaPasien,
    required this.tanggalLahir,
    required this.nomorTelepon,
    required this.alamat,
  });

  factory Pasien.fromJson(Map<String, dynamic> json) => Pasien(
        id: json["id"],
        nomorRm: json["no_rm"],
        namaPasien: json["nama"],
        tanggalLahir: DateTime.parse(json["tgl_lahir"]),
        nomorTelepon: json["no_telp"],
        alamat: json["alamat"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "no_rm": nomorRm,
        "nama": namaPasien,
        "tgl_lahir": tanggalLahir.toIso8601String(),
        "no_telp": nomorTelepon,
        "alamat": alamat,
      };
}
