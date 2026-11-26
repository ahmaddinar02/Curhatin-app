import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

class ApiService {
  /// Base URL API Laravel
  /// - Android Emulator: 10.0.2.2:8000
  /// - Windows / Web / iOS Simulator: 127.0.0.1:8000
  /// - HP Fisik: Ganti dengan IP laptop Anda (contoh: http://192.168.1.10:8000/api)
  static String get defaultBaseUrl {
    if (kIsWeb) return 'http://127.0.0.1:8000/api';
    try {
      if (Platform.isAndroid) {
        return 'http://10.0.2.2:8000/api';
      }
    } catch (_) {}
    return 'http://127.0.0.1:8000/api';
  }

  static String baseUrl = defaultBaseUrl;

  /// Token sesi pengguna aktif
  static String? token;

  /// Data pengguna yang sedang login
  static Map<String, dynamic>? currentUser;

  static Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

  // ── AUTHENTICATION ─────────────────────────────────────────────

  /// Registrasi akun baru
  static Future<Map<String, dynamic>> register({
    required String name,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/register');
      final response = await http
          .post(
            url,
            headers: _headers,
            body: jsonEncode({
              'nama': name,
              'no_telepon': phone,
              'password': password,
              'password_confirmation': confirmPassword,
            }),
          )
          .timeout(const Duration(seconds: 10));

      final data = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        if (data['data'] != null) {
          token = data['data']['token'];
          currentUser = data['data']['user'];
        }
        return {'success': true, 'message': data['message'] ?? 'Pendaftaran berhasil'};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Registrasi gagal (${response.statusCode})',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Gagal terhubung ke server backend: $e',
      };
    }
  }

  /// Login akun (bisa nomor telepon atau nama lengkap)
  static Future<Map<String, dynamic>> login({
    required String phone,
    required String password,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/login');
      final response = await http
          .post(
            url,
            headers: _headers,
            body: jsonEncode({
              'identifier': phone,
              'no_telepon': phone,
              'nama': phone,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 10));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (data['data'] != null) {
          token = data['data']['token'];
          currentUser = data['data']['user'];
        }
        return {
          'success': true,
          'message': data['message'] ?? 'Login berhasil',
          'user': currentUser,
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Nama/Nomor telepon atau password salah',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Gagal terhubung ke backend: $e. Pastikan server backend aktif.',
      };
    }
  }

  /// Logout akun dari sesi aplikasi dan server
  static Future<void> logout() async {
    try {
      final url = Uri.parse('$baseUrl/logout');
      await http.post(url, headers: _headers).timeout(const Duration(seconds: 5));
    } catch (_) {}
    token = null;
    currentUser = null;
  }

  // ── JURNAL DIGITAL ─────────────────────────────────────────────

  /// Ambil daftar jurnal aktif
  static Future<Map<String, dynamic>> getJournals() async {
    try {
      final userId = currentUser?['id'];
      final url = Uri.parse(userId != null ? '$baseUrl/journals?user_id=$userId' : '$baseUrl/journals');
      final response = await http.get(url, headers: _headers).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'data': data['data'] ?? [],
          'trash_count': data['trash_count'] ?? 0,
        };
      }
    } catch (e) {
      // Backend offline
    }
    return {'success': false, 'data': []};
  }

  /// Ambil daftar kotak sampah jurnal
  static Future<List<dynamic>> getTrashJournals() async {
    try {
      final userId = currentUser?['id'];
      final url = Uri.parse(userId != null ? '$baseUrl/journals/trash?user_id=$userId' : '$baseUrl/journals/trash');
      final response = await http.get(url, headers: _headers).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] ?? [];
      }
    } catch (_) {}
    return [];
  }

  /// Simpan jurnal baru
  static Future<Map<String, dynamic>> createJournal({
    required String title,
    required String content,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/journals');
      final response = await http
          .post(
            url,
            headers: _headers,
            body: jsonEncode({
              'title': title,
              'content': content,
              'user_id': currentUser?['id'],
            }),
          )
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'success': true, 'data': data['data']};
      }
    } catch (_) {}
    return {'success': false};
  }

  /// Perbarui catatan jurnal yang sudah ada
  static Future<Map<String, dynamic>> updateJournal({
    required String id,
    required String title,
    required String content,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/journals/$id');
      final response = await http
          .put(
            url,
            headers: _headers,
            body: jsonEncode({
              'title': title,
              'content': content,
            }),
          )
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'success': true, 'data': data['data']};
      }
    } catch (_) {}
    return {'success': false};
  }

  /// Pindahkan jurnal ke kotak sampah
  static Future<bool> deleteJournal(String id) async {
    try {
      final url = Uri.parse('$baseUrl/journals/$id');
      final response = await http.delete(url, headers: _headers).timeout(const Duration(seconds: 6));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  /// Pulihkan jurnal dari kotak sampah
  static Future<bool> restoreJournal(String id) async {
    try {
      final url = Uri.parse('$baseUrl/journals/$id/restore');
      final response = await http.post(url, headers: _headers).timeout(const Duration(seconds: 6));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  /// Hapus permanen jurnal
  static Future<bool> permanentDeleteJournal(String id) async {
    try {
      final url = Uri.parse('$baseUrl/journals/$id/permanent');
      final response = await http.delete(url, headers: _headers).timeout(const Duration(seconds: 6));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
