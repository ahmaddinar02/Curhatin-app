<?php

namespace App\Http\Controllers;

use App\Models\Journal;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class JournalController extends Controller
{
    /**
     * Ambil daftar jurnal aktif
     */
    public function index(Request $request): JsonResponse
    {
        $userId = $request->user()?->id_user ?? $request->query('user_id');

        $query = Journal::query()->where('status', 'aktif');

        if ($userId) {
            $query->where('id_user', $userId);
        }

        $journals = $query->orderBy('tanggal', 'desc')
            ->orderBy('created_at', 'desc')
            ->get()
            ->map(function ($j) {
                return [
                    'id'         => (string) $j->id_jurnal,
                    'title'      => str_replace('DEMO_ONLY_NOT_ENCRYPTED: ', '', $j->judul_encrypted),
                    'content'    => str_replace('DEMO_ONLY_NOT_ENCRYPTED: ', '', $j->isi_jurnal_encrypted),
                    'jenis'      => $j->jenis,
                    'status'     => $j->status,
                    'tanggal'    => $j->tanggal?->format('Y-m-d') ?? now()->format('Y-m-d'),
                    'created_at' => $j->created_at?->toIso8601String() ?? now()->toIso8601String(),
                ];
            });

        // Hitung juga jumlah di kotak sampah
        $trashCountQuery = Journal::where('status', 'sampah');
        if ($userId) {
            $trashCountQuery->where('id_user', $userId);
        }
        $trashCount = $trashCountQuery->count();

        return response()->json([
            'status'      => 'success',
            'data'        => $journals,
            'trash_count' => $trashCount,
        ]);
    }

    /**
     * Ambil daftar jurnal di kotak sampah
     */
    public function trash(Request $request): JsonResponse
    {
        $userId = $request->user()?->id_user ?? $request->query('user_id');

        $query = Journal::query()->where('status', 'sampah');

        if ($userId) {
            $query->where('id_user', $userId);
        }

        $trashJournals = $query->orderBy('deleted_at', 'desc')
            ->get()
            ->map(function ($j) {
                $deletedDaysAgo = $j->deleted_at ? $j->deleted_at->diffInDays(now()) : 0;
                $daysRemaining = max(0, 30 - $deletedDaysAgo);

                return [
                    'id'               => (string) $j->id_jurnal,
                    'title'            => str_replace('DEMO_ONLY_NOT_ENCRYPTED: ', '', $j->judul_encrypted),
                    'content'          => str_replace('DEMO_ONLY_NOT_ENCRYPTED: ', '', $j->isi_jurnal_encrypted),
                    'jenis'            => $j->jenis,
                    'status'           => $j->status,
                    'tanggal'          => $j->tanggal?->format('Y-m-d') ?? now()->format('Y-m-d'),
                    'deleted_at'       => $j->deleted_at?->toIso8601String(),
                    'days_remaining'   => $daysRemaining,
                    'deleted_days_ago' => $deletedDaysAgo,
                ];
            });

        return response()->json([
            'status' => 'success',
            'data'   => $trashJournals,
        ]);
    }

    /**
     * Tambah catatan jurnal baru
     */
    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'title'   => 'required|string',
            'content' => 'required|string',
        ]);

        $userId = $request->user()?->id_user ?? $request->input('user_id') ?? 2;

        $journal = Journal::create([
            'id_user'              => $userId,
            'judul_encrypted'      => $request->input('title'),
            'isi_jurnal_encrypted' => $request->input('content'),
            'jenis'                => 'permanen',
            'status'               => 'aktif',
            'tanggal'              => now()->toDateString(),
        ]);

        return response()->json([
            'status'  => 'success',
            'message' => 'Jurnal berhasil disimpan.',
            'data'    => [
                'id'         => (string) $journal->id_jurnal,
                'title'      => $journal->judul_encrypted,
                'content'    => $journal->isi_jurnal_encrypted,
                'created_at' => $journal->created_at?->toIso8601String() ?? now()->toIso8601String(),
            ],
        ], 201);
    }

    /**
     * Update catatan jurnal
     */
    public function update(Request $request, $id): JsonResponse
    {
        $journal = Journal::find($id);

        if (!$journal) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Jurnal tidak ditemukan.',
            ], 404);
        }

        if ($request->has('title')) {
            $journal->judul_encrypted = $request->input('title');
        }
        if ($request->has('content')) {
            $journal->isi_jurnal_encrypted = $request->input('content');
        }

        $journal->save();

        return response()->json([
            'status'  => 'success',
            'message' => 'Jurnal berhasil diperbarui.',
            'data'    => [
                'id'      => (string) $journal->id_jurnal,
                'title'   => $journal->judul_encrypted,
                'content' => $journal->isi_jurnal_encrypted,
            ],
        ]);
    }

    /**
     * Pindahkan jurnal ke kotak sampah
     */
    public function destroy($id): JsonResponse
    {
        $journal = Journal::find($id);

        if (!$journal) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Jurnal tidak ditemukan.',
            ], 404);
        }

        $journal->status = 'sampah';
        $journal->deleted_at = now();
        $journal->purge_at = now()->addDays(30);
        $journal->save();

        return response()->json([
            'status'  => 'success',
            'message' => 'Jurnal berhasil dipindahkan ke kotak sampah.',
        ]);
    }

    /**
     * Pulihkan jurnal dari kotak sampah
     */
    public function restore($id): JsonResponse
    {
        $journal = Journal::find($id);

        if (!$journal) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Jurnal tidak ditemukan.',
            ], 404);
        }

        $journal->status = 'aktif';
        $journal->deleted_at = null;
        $journal->purge_at = null;
        $journal->save();

        return response()->json([
            'status'  => 'success',
            'message' => 'Jurnal berhasil dipulihkan.',
        ]);
    }

    /**
     * Hapus permanen dari kotak sampah
     */
    public function forceDelete($id): JsonResponse
    {
        $journal = Journal::find($id);

        if (!$journal) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Jurnal tidak ditemukan.',
            ], 404);
        }

        $journal->delete();

        return response()->json([
            'status'  => 'success',
            'message' => 'Jurnal berhasil dihapus permanen.',
        ]);
    }
}
