class Pegawai {
  int? id;
  String nip;
  String namaPegawai;
  DateTime tanggalLahir;
  String nomorTelepon;
  String email;

  Pegawai({
    this.id,
    required this.nip,
    required this.namaPegawai,
    required this.tanggalLahir,
    required this.nomorTelepon,
    required this.email,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) => Pegawai(
        id: json["id"],
        nip: json["nip"],
        namaPegawai: json["nama"],
        tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
        nomorTelepon: json["nomor_telepon"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nip": nip,
        "nama": namaPegawai,
        "tanggal_lahir": tanggalLahir.toIso8601String(),
        "nomor_telepon": nomorTelepon,
        "email": email,
      };
}
