class Pegawai {
  int? id;
  String nip;
  String namaPegawai;
  DateTime tanggalLahir;
  String nomorTelepon;
  String email;
  String password;

  Pegawai({
    this.id,
    required this.nip,
    required this.namaPegawai,
    required this.tanggalLahir,
    required this.nomorTelepon,
    required this.email,
    required this.password,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) => Pegawai(
        id: json["id"],
        nip: json["nip"],
        namaPegawai: json["nama"],
        tanggalLahir: DateTime.parse(json["tgl_lahir"]),
        nomorTelepon: json["no_telp"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nip": nip,
        "nama": namaPegawai,
        "tgl_lahir": tanggalLahir.toIso8601String(),
        "no_telp": nomorTelepon,
        "email": email,
        "password": password,
      };
}
