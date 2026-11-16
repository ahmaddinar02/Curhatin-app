<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;

/*
|--------------------------------------------------------------------------
| API Routes - Curhatin App
|--------------------------------------------------------------------------
|
| Public Routes (tidak perlu token):
|   POST /api/register  -> Daftar akun baru
|   POST /api/login     -> Login dengan nomor telepon + password
|
| Protected Routes (butuh Bearer Token dari Sanctum):
|   POST /api/logout    -> Logout & cabut token
|   GET  /api/profile   -> Ambil data profil user
|   GET  /api/user      -> Alias untuk profil (default Laravel Sanctum)
|
*/

// === RUTE PUBLIK (Auth) ===
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

// === RUTE TERPROTEKSI (Membutuhkan Token Sanctum) ===
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/profile', [AuthController::class, 'profile']);

    // Rute default Laravel Sanctum
    Route::get('/user', function (Request $request) {
        return $request->user();
    });
});
