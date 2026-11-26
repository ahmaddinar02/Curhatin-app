<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Journal extends Model
{
    /**
     * Nama tabel di database sesuai curhatin.sql
     */
    protected $table = 'jurnal';

    /**
     * Primary key tabel
     */
    protected $primaryKey = 'id_jurnal';

    /**
     * Kolom yang dapat diisi secara massal
     */
    protected $fillable = [
        'id_user',
        'id_mood',
        'judul_encrypted',
        'isi_jurnal_encrypted',
        'jenis',
        'status',
        'tanggal',
        'expires_at',
        'deleted_at',
        'purge_at',
    ];

    /**
     * Tipe casting kolom
     */
    protected function casts(): array
    {
        return [
            'tanggal'    => 'date',
            'expires_at' => 'datetime',
            'deleted_at' => 'datetime',
            'purge_at'   => 'datetime',
        ];
    }

    /**
     * Accessor judul untuk kompatibilitas frontend
     */
    public function getTitleAttribute(): ?string
    {
        return $this->judul_encrypted;
    }

    /**
     * Accessor isi untuk kompatibilitas frontend
     */
    public function getContentAttribute(): ?string
    {
        return $this->isi_jurnal_encrypted;
    }

    /**
     * Relasi ke user pemilik jurnal
     */
    public function user()
    {
        return $this->belongsTo(User::class, 'id_user', 'id_user');
    }
}
