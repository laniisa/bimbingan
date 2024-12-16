<?php
namespace App\Controllers;

use App\Models\SupervisionRequestModel;
use App\Models\UserModel;
use App\Models\ProjectModel;
use CodeIgniter\RESTful\ResourceController;

class MahasiswaController extends RestfulController
{
    protected $modelName = 'App\Models\SupervisionRequestModel';
    protected $format = 'json';
    protected $projectModel;

    public function __construct()
    {
        $this->projectModel = new ProjectModel();

    }


    // Endpoint untuk mengajukan dosen
    public function submit_request()
    {
        $data = $this->request->getJSON();

        // Validasi data yang diterima
        if (!isset($data->lecturer_id)) {
            return $this->failValidationError('Lecturer ID is required');
        }

        // Ambil user_id (mahasiswa) yang sedang login
        $student_id = session()->get('user_id'); // Ambil user_id dari session

        // Simpan pengajuan di tabel supervision_requests
        $supervisionRequestModel = new SupervisionRequestModel();
        $supervisionRequestModel->save([
            'student_id' => $student_id,
            'lecturer_id' => $data->lecturer_id,
            'status' => 'pending'
        ]);

        return $this->respondCreated(['message' => 'Supervision request created successfully']);
    }

    // Endpoint untuk mendapatkan daftar dosen
    public function get_lecturers()
    {
        $userModel = new UserModel();
        $lecturers = $userModel->where('role', 'lecturer')->findAll();

        if (empty($lecturers)) {
            return $this->failNotFound('No lecturers found.');
        }

        return $this->respond($lecturers);
    }

    public function listProjects($studentId)
    {
        $projects = $this->projectModel->where('student_id', $studentId)->findAll();
        return $this->respond($projects);
    }

    // Mahasiswa mengajukan proyek baru
    public function submitProject()
{
    // Ambil ID mahasiswa dari sesi login
    $studentId = session()->get('user_id');

    // Ambil data dari request
    $data = [
        'title'       => $this->request->getVar('title'),
        'description' => $this->request->getVar('description'),
        'student_id'  => $studentId, // ID mahasiswa dari sesi
        'lecturer_id' => $this->request->getVar('lecturer_id'), // ID dosen pembimbing
        'status'      => 'pending', // Status default
    ];

    if ($this->projectModel->save($data)) {
        return $this->respondCreated('Project submitted successfully');
    } else {
        return $this->failValidationErrors('Failed to submit project');
    }
}

    // Mahasiswa melihat detail proyek tertentu
    public function projectDetail($projectId)
    {
        $project = $this->projectModel->find($projectId);

        if ($project) {
            return $this->respond($project);
        } else {
            return $this->failNotFound('Project not found');
        }
    }
}
