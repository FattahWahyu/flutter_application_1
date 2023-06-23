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
        nomorRm: json["nomor_rm"],
        namaPasien: json["nama"],
        tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
        nomorTelepon: json["nomor_telepon"],
        alamat: json["alamat"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nomor_rm": nomorRm,
        "nama": namaPasien,
        "tanggal_lahir": tanggalLahir.toIso8601String(),
        "nomor_telepon": nomorTelepon,
        "alamat": alamat,
      };
}
