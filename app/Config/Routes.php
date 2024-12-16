<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'Home::index');
$routes->post('register', 'AuthController::register');
$routes->post('login', 'AuthController::login');

//Mahasiswa

$routes->group('mahasiswa', ['namespace' => 'App\Controllers'], function($routes) {
    $routes->post('submit_request', 'MahasiswaController::submit_request');// Pengajuan dosen
    $routes->get('get_lecturers', 'MahasiswaController::get_lecturers');// Mendapatkan daftar dosen
    $routes->get('projects/(:num)', 'MahasiswaController::listProjects/$1'); // Melihat daftar proyek mahasiswa
    $routes->get('project/(:num)', 'MahasiswaController::projectDetail/$1'); // Detail proyek
    $routes->post('project', 'MahasiswaController::submitProject'); // Mengajukan proyek baru

});


//Dosen
// app/Config/Routes.php
// Dosen Routes
$routes->group('dosen', ['namespace' => 'App\Controllers'], function($routes) {
    $routes->get('viewRequests', 'DosenController::viewRequests');// Melihat pengajuan yang masuk
    $routes->put('updateStatus/(:num)/(:any)', 'DosenController::updateStatus/$1/$2');// Memperbarui status pengajuan
    $routes->get('projects/(:num)', 'DosenController::listProjects/$1'); // Melihat daftar proyek
    $routes->put('project/(:num)', 'DosenController::updateProjectStatus/$1'); // Menyetujui/mereject proyek
    $routes->post('task', 'DosenController::assignTask'); // Memberikan tugas baru
    $routes->get('tasks/(:num)', 'DosenController::listTasks/$1'); // Melihat tugas pada proyek

});

