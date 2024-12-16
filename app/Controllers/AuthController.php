<?php

namespace App\Controllers;

use App\Models\UserModel;

class AuthController extends RestfulController
{
    public function register()
{
    // Ambil input dari request
    $username     = $this->request->getVar('username');
    $email    = $this->request->getVar('email');
    $password = $this->request->getVar('password');

    // Validasi jika ada field yang kosong
    if (empty($username) || empty($email) || empty($password)) {
        return $this->failValidationErrors('All fields are required');
    }

    // Validasi apakah email sudah terdaftar
    $model = new UserModel();
    if ($model->where('email', $email)->first()) {
        return $this->failValidationErrors('Email already registered');
    }

    // Hash password
    $data = [
        'username' => $username,
        'email'    => $email,
        'password' => password_hash($password, PASSWORD_DEFAULT),
        'role'     => 'student',
        'supervisor_id' =>NULL,
    ];

    // Simpan data ke database
    if ($model->save($data)) {
        return $this->responseHasil(200, true, "Registrasi Berhasil");
    } else {
        return $this->failValidationErrors('Registration failed. ' . print_r($model->errors(), true));
    }
    
}



public function login()
{
    $email = $this->request->getVar('email');
    $password = $this->request->getVar('password');

    $model = new UserModel();
    $member = $model->where(['email' => $email])->first();
    if (!$member) {
        return $this->responseHasil(400, false, "Email tidak ditemukan");
    }
    if (!password_verify($password, $member['password'])) {
        return $this->responseHasil(400, false, "Password tidak valid");
    }

    $login = new UserModel();
    $auth_key = $this->RandomString();
    $data = [
        'token' => $auth_key,
        'user' => [
            'id' => $member['user_id'],
            'username' => $member['username'],
            'email' => $member['email'],
            'role' => $member['role']
        ]
    ];
    return $this->responseHasil(200, true, $data);
}

private function RandomString($length = 100)
{
    $karakkter ='012345678dssd9abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $panjang_karakter = strlen($karakkter);
    $str = '';
    for ($i = 0; $i < $length; $i++) {
        $str .= $karakkter[rand(0, $panjang_karakter - 1)];
    }
    return $str;
}
}
