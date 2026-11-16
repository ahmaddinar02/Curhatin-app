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
     * Registrasi pengguna baru menggunakan nama, nomor telepon, dan password.
     */
    public function register(Request $request): JsonResponse
    {
        try {
            $request->validate([
                'name'             => 'required|string|max:255',
                'phone'            => 'required|string|max:20|unique:users,phone',
                'password'         => 'required|string|min:6|confirmed',
            ], [
                'name.required'    => 'Nama lengkap harus diisi.',
                'phone.required'   => 'Nomor telepon harus diisi.',
                'phone.unique'     => 'Nomor telepon ini sudah terdaftar.',
                'password.required' => 'Password harus diisi.',
                'password.min'     => 'Password minimal 6 karakter.',
                'password.confirmed' => 'Konfirmasi password tidak cocok.',
            ]);
        } catch (ValidationException $e) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Validasi gagal.',
                'errors'  => $e->errors(),
            ], 422);
        }

        $user = User::create([
            'name'     => $request->name,
            'phone'    => $request->phone,
            'password' => $request->password, // Otomatis di-hash karena cast 'hashed'
        ]);

        $token = $user->createToken('curhatin-mobile')->plainTextToken;

        return response()->json([
            'status'  => 'success',
            'message' => 'Pendaftaran berhasil! Selamat datang, ' . $user->name,
            'data'    => [
                'user'  => [
                    'id'    => $user->id,
                    'name'  => $user->name,
                    'phone' => $user->phone,
                ],
                'token' => $token,
            ],
        ], 201);
    }

    /**
     * Login menggunakan nomor telepon dan password.
     */
    public function login(Request $request): JsonResponse
    {
        try {
            $request->validate([
                'phone'    => 'required|string',
                'password' => 'required|string',
            ], [
                'phone.required'    => 'Nomor telepon harus diisi.',
                'password.required' => 'Password harus diisi.',
            ]);
        } catch (ValidationException $e) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Validasi gagal.',
                'errors'  => $e->errors(),
            ], 422);
        }

        $user = User::where('phone', $request->phone)->first();

        if (! $user || ! Hash::check($request->password, $user->password)) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Nomor telepon atau password salah.',
            ], 401);
        }

        // Hapus token lama (opsional: untuk keamanan single session)
        $user->tokens()->delete();

        $token = $user->createToken('curhatin-mobile')->plainTextToken;

        return response()->json([
            'status'  => 'success',
            'message' => 'Login berhasil! Selamat datang kembali, ' . $user->name,
            'data'    => [
                'user'  => [
                    'id'    => $user->id,
                    'name'  => $user->name,
                    'phone' => $user->phone,
                ],
                'token' => $token,
            ],
        ]);
    }

    /**
     * Logout pengguna (cabut token aktif).
     */
    public function logout(Request $request): JsonResponse
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'status'  => 'success',
            'message' => 'Logout berhasil.',
        ]);
    }

    /**
     * Ambil data profil pengguna yang sedang login.
     */
    public function profile(Request $request): JsonResponse
    {
        return response()->json([
            'status' => 'success',
            'data'   => [
                'user' => [
                    'id'    => $request->user()->id,
                    'name'  => $request->user()->name,
                    'phone' => $request->user()->phone,
                ],
            ],
        ]);
    }
}

