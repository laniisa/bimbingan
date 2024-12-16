<?php

namespace App\Models;

use CodeIgniter\Model;

// app/Models/UserModel.php
class UserModel extends Model
{
    protected $table = 'users';
    protected $primaryKey = 'user_id';
    protected $allowedFields = ['username', 'email', 'password', 'role', 'supervisor_id'];

    // Menambahkan fungsi untuk mendapatkan data dosen berdasarkan role
    public function getLecturers()
    {
        return $this->where('role', 'lecturer')->findAll();
    }
}

