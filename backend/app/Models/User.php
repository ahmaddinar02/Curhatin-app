<?php

namespace App\Models;

use Database\Factories\UserFactory;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    /** @use HasFactory<UserFactory> */
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * Nama tabel di database sesuai skema curhatin.sql
     */
    protected $table = 'users';

    /**
     * Primary key tabel users
     */
    protected $primaryKey = 'id_user';

    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'nama',
        'email',
        'no_telepon',
        'password_hash',
        'google_uid',
        'foto_profil',
        'role',
        'status',
        'streak',
    ];

    /**
     * The attributes that should be hidden for serialization.
     */
    protected $hidden = [
        'password_hash',
        'remember_token',
    ];

    /**
     * Beritahu Laravel auth untuk menggunakan kolom password_hash
     */
    public function getAuthPassword()
    {
        return $this->password_hash;
    }

    /**
     * Accessor untuk nama agar kompatibel dengan pemanggilan $user->name
     */
    public function getNameAttribute(): ?string
    {
        return $this->nama;
    }

    /**
     * Mutator untuk nama
     */
    public function setNameAttribute($value): void
    {
        $this->attributes['nama'] = $value;
    }

    /**
     * Accessor untuk no_telepon agar kompatibel dengan pemanggilan $user->phone
     */
    public function getPhoneAttribute(): ?string
    {
        return $this->no_telepon;
    }

    /**
     * Mutator untuk no_telepon
     */
    public function setPhoneAttribute($value): void
    {
        $this->attributes['no_telepon'] = $value;
    }

    /**
     * Cast attributes.
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'no_telepon_verified_at' => 'datetime',
        ];
    }
}
