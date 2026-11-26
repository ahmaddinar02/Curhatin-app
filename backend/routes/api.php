<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\JournalController;

/*
|--------------------------------------------------------------------------
| API Routes - Curhatin App
|--------------------------------------------------------------------------
*/

// === AUTHENTICATION ROUTES ===
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

// === JOURNAL ROUTES (Dapat diakses publik atau dengan token) ===
Route::get('/journals', [JournalController::class, 'index']);
Route::get('/journals/trash', [JournalController::class, 'trash']);
Route::post('/journals', [JournalController::class, 'store']);
Route::get('/journals/{id}', [JournalController::class, 'show']);
Route::put('/journals/{id}', [JournalController::class, 'update']);
Route::delete('/journals/{id}', [JournalController::class, 'destroy']);
Route::post('/journals/{id}/restore', [JournalController::class, 'restore']);
Route::delete('/journals/{id}/permanent', [JournalController::class, 'forceDelete']);

// === PROTECTED ROUTES (Sanctum) ===
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/profile', [AuthController::class, 'profile']);

    Route::get('/user', function (Request $request) {
        return $request->user();
    });
});
