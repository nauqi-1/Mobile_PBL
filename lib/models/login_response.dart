const String apiUrl = 'https://kelompok-2.lleans.dev/api/';

class LoginResponse {
  final bool success;
  final User user;
  final String token;

  LoginResponse(
      {required this.success, required this.user, required this.token});

  // Factory constructor to parse JSON into the object
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }
}

class User {
  final int userId;
  final int levelId;
  final String username;
  final String? createdAt;
  final String? updatedAt;

  User({
    required this.userId,
    required this.levelId,
    required this.username,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor to parse JSON into the object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      levelId: json['level_id'],
      username: json['username'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Mahasiswa {
  final int mahasiswaId;
  final String mahasiswaNama;
  final String mahasiswaKelas;
  final String mahasiswaNim;
  final String mahasiswaProdi;
  final String mahasiswaNoHp;
  final int mahasiswaAlfaLunas;
  final int jumlahAlfa;
  final int userId;

  Mahasiswa({
    required this.mahasiswaId,
    required this.mahasiswaNama,
    required this.mahasiswaKelas,
    required this.mahasiswaNim,
    required this.mahasiswaProdi,
    required this.mahasiswaNoHp,
    required this.mahasiswaAlfaLunas,
    required this.jumlahAlfa,
    required this.userId,
  });

  // Factory constructor to parse JSON into the object
  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return Mahasiswa(
      mahasiswaId: json['mahasiswa']['mahasiswa_id'],
      mahasiswaNama: json['mahasiswa']['mahasiswa_nama'],
      mahasiswaKelas: json['mahasiswa']['mahasiswa_kelas'],
      mahasiswaNim: json['mahasiswa']['mahasiswa_nim'],
      mahasiswaProdi: json['mahasiswa']['mahasiswa_prodi'],
      mahasiswaNoHp: json['mahasiswa']['mahasiswa_noHp'],
      mahasiswaAlfaLunas: json['mahasiswa']['mahasiswa_alfa_lunas'] ?? 0,
      jumlahAlfa: int.tryParse(json['jumlah_alfa'].toString()) ?? 0,
      userId: json['mahasiswa']['user_id'] ?? 0,
    );
  }

  get mahasiswa_id => null;

  // Convert the object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'mahasiswa_id': mahasiswaId,
      'mahasiswa_nama': mahasiswaNama,
      'mahasiswa_kelas': mahasiswaKelas,
      'mahasiswa_nim': mahasiswaNim,
      'mahasiswa_prodi': mahasiswaProdi,
      'mahasiswa_noHp': mahasiswaNoHp,
      'mahasiswa_alfa_lunas': mahasiswaAlfaLunas,
      'jumlah_alfa': jumlahAlfa,
      'user_id': userId,
    };
  }
}

class Dosen {
  final int dosenId;
  final String dosenNama;
  final String dosenNip;
  final String dosenProdi;
  final String dosenNoHp;
  final int userId;

  Dosen({
    required this.dosenId,
    required this.dosenNama,
    required this.dosenNip,
    required this.dosenProdi,
    required this.dosenNoHp,
    required this.userId,
  });

  // Factory constructor to parse JSON into the object
  factory Dosen.fromJson(Map<String, dynamic> json) {
    return Dosen(
      dosenId: json['dosen_id'],
      dosenNama: json['dosen_nama'],
      dosenNip: json['dosen_nip'],
      dosenProdi: json['dosen_prodi'],
      dosenNoHp: json['dosen_noHp'],
      userId: json['user_id'],
    );
  }

  // Convert the object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'dosen_id': dosenId,
      'dosen_nama': dosenNama,
      'dosen_nip': dosenNip,
      'dosen_prodi': dosenProdi,
      'dosen_noHp': dosenNoHp,
      'user_id': userId,
    };
  }
}
