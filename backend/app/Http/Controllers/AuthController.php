<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    /**
     * Normalisasi nomor telepon (+62 / 08 / 8xxx).
     */
    private function normalizePhone(string $phone): string
    {
        $phone = preg_replace('/[^0-9]/', '', $phone);
        if (str_starts_with($phone, '0')) {
            $phone = '62' . substr($phone, 1);
        } elseif (!str_starts_with($phone, '62')) {
            $phone = '62' . $phone;
        }
        return '+' . $phone;
    }

    /**
     * Registrasi pengguna baru.
     */
    public function register(Request $request): JsonResponse
    {
        // Support field 'name' / 'nama', dan 'phone' / 'no_telepon'
        $name = $request->input('nama') ?? $request->input('name');
        $rawPhone = $request->input('no_telepon') ?? $request->input('phone');
        $password = $request->input('password');
        $passwordConfirmation = $request->input('password_confirmation') ?? $request->input('confirmPassword');

        if (empty($name)) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Nama lengkap harus diisi.',
            ], 422);
        }

        if (empty($rawPhone)) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Nomor telepon harus diisi.',
            ], 422);
        }

        if (empty($password) || strlen($password) < 6) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Password minimal harus 6 karakter.',
            ], 422);
        }

        if (!empty($passwordConfirmation) && $password !== $passwordConfirmation) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Konfirmasi password tidak cocok.',
            ], 422);
        }

        $phone = $this->normalizePhone($rawPhone);

        // Cek duplikasi nomor telepon
        $existing = User::where('no_telepon', $phone)
            ->orWhere('no_telepon', $rawPhone)
            ->first();

        if ($existing) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Nomor telepon ini sudah terdaftar. Silakan langsung masuk ke akun Anda.',
            ], 422);
        }

        $user = User::create([
            'nama'          => $name,
            'no_telepon'    => $phone,
            'password_hash' => Hash::make($password),
            'role'          => 'user',
            'status'        => 'aktif',
            'streak'        => 0,
        ]);

        $token = method_exists($user, 'createToken')
            ? $user->createToken('curhatin-mobile')->plainTextToken
            : bin2hex(random_bytes(24));

        return response()->json([
            'status'  => 'success',
            'message' => 'Pendaftaran berhasil! Selamat datang, ' . $user->nama,
            'data'    => [
                'user' => [
                    'id'    => $user->id_user,
                    'name'  => $user->nama,
                    'phone' => $user->no_telepon,
                    'role'  => $user->role,
                ],
                'token' => $token,
            ],
        ], 201);
    }

    /**
     * Login menggunakan nomor telepon atau nama dan password.
     */
    public function login(Request $request): JsonResponse
    {
        $identifier = trim(
            $request->input('identifier')
            ?? $request->input('nama')
            ?? $request->input('name')
            ?? $request->input('username')
            ?? $request->input('no_telepon')
            ?? $request->input('phone')
            ?? ''
        );
        $password = $request->input('password');

        if (empty($identifier) || empty($password)) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Nama / Nomor telepon dan password harus diisi.',
            ], 422);
        }

        // 1. Cari berdasarkan nama (case-insensitive)
        $user = User::whereRaw('LOWER(nama) = ?', [strtolower($identifier)])->first();

        // 2. Jika belum ditemukan, coba cari berdasarkan nomor telepon
        if (!$user) {
            $normalizedPhone = $this->normalizePhone($identifier);
            $user = User::where('no_telepon', $normalizedPhone)
                ->orWhere('no_telepon', $identifier)
                ->orWhere('no_telepon', preg_replace('/[^0-9]/', '', $identifier))
                ->first();
        }

        // 3. Jika belum ditemukan, coba cari berdasarkan email
        if (!$user) {
            $user = User::where('email', $identifier)->first();
        }

        if (!$user || !Hash::check($password, $user->password_hash)) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Nama/Nomor telepon atau password yang dimasukkan salah.',
            ], 401);
        }

        if ($user->status !== 'aktif') {
            return response()->json([
                'status'  => 'error',
                'message' => 'Akun Anda dinonaktifkan. Silakan hubungi admin.',
            ], 403);
        }

        // Hapus token lama jika memakai Sanctum
        if (method_exists($user, 'tokens')) {
            try {
                $user->tokens()->delete();
            } catch (\Throwable $e) {}
        }

        $token = method_exists($user, 'createToken')
            ? $user->createToken('curhatin-mobile')->plainTextToken
            : bin2hex(random_bytes(24));

        return response()->json([
            'status'  => 'success',
            'message' => 'Login berhasil! Selamat datang kembali, ' . $user->nama,
            'data'    => [
                'user' => [
                    'id'    => $user->id_user,
                    'name'  => $user->nama,
                    'phone' => $user->no_telepon,
                    'role'  => $user->role,
                    'streak'=> $user->streak,
                ],
                'token' => $token,
            ],
        ]);
    }

    /**
     * Logout pengguna.
     */
    public function logout(Request $request): JsonResponse
    {
        if ($request->user() && method_exists($request->user(), 'currentAccessToken')) {
            $token = $request->user()->currentAccessToken();
            if ($token) {
                $token->delete();
            }
        }

        return response()->json([
            'status'  => 'success',
            'message' => 'Logout berhasil.',
        ]);
    }

    /**
     * Profil pengguna yang sedang login.
     */
    public function profile(Request $request): JsonResponse
    {
        $user = $request->user();

        if (!$user) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Unauthenticated.',
            ], 401);
        }

        return response()->json([
            'status' => 'success',
            'data'   => [
                'user' => [
                    'id'     => $user->id_user,
                    'name'   => $user->nama,
                    'phone'  => $user->no_telepon,
                    'email'  => $user->email,
                    'role'   => $user->role,
                    'streak' => $user->streak,
                ],
            ],
        ]);
    }
}
