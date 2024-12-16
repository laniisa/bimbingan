<?php
namespace App\Controllers;

use App\Models\SupervisionRequestModel;
use App\Models\UserModel;
use App\Models\TaskModel;
use App\Models\ProjectModel;
use CodeIgniter\RESTful\ResourceController;

class DosenController extends RestfulController
{
    protected $modelName = 'App\Models\SupervisionRequestModel';
    protected $format = 'json';
    protected $projectModel;
    protected $taskModel;

    public function __construct()
    {
        $this->projectModel = new ProjectModel();
        $this->taskModel = new TaskModel();
    }

    // Fungsi untuk dosen menyetujui atau menolak pengajuan mahasiswa
    public function updateStatus($request_id, $status)
    {
        $validStatuses = ['approved', 'rejected']; // Status yang valid
        if (!in_array($status, $validStatuses)) {
            return $this->failValidationError('Invalid status'); // Memastikan status yang diberikan valid
        }

        $requestModel = new SupervisionRequestModel();
        $request = $requestModel->find($request_id); // Mendapatkan pengajuan berdasarkan ID

        if (!$request) {
            return $this->failNotFound('Request not found'); // Jika pengajuan tidak ditemukan
        }

        // Update status pengajuan
        $requestModel->update($request_id, ['status' => $status]);

        // Jika status disetujui, update supervisor (dosen) di mahasiswa
        if ($status == 'approved') {
            $userModel = new UserModel();
            $userModel->update($request['student_id'], ['supervisor_id' => $request['lecturer_id']]);
        }

        return $this->respond(['message' => 'Status updated successfully']); // Mengirimkan response bahwa status telah diperbarui
    }

    // Fungsi untuk dosen melihat pengajuan yang masuk
    public function viewRequests()
    {
        $lecturer_id = session()->get('user_id'); // ID dosen dari session

        $supervisionRequestModel = new SupervisionRequestModel();
        $requests = $supervisionRequestModel->where('lecturer_id', $lecturer_id)->findAll(); // Mendapatkan pengajuan untuk dosen ini

        return $this->respond($requests);
    }

    public function listProjects($lecturerId)
{
    // Ambil proyek berdasarkan lecturer_id
    $projects = $this->projectModel->where('lecturer_id', $lecturerId)->findAll();
    return $this->respond($projects);
}


public function updateProjectStatus($projectId)
{
    // Ambil status baru dari request (approved/rejected)
    $status = $this->request->getVar('status');

    if (!in_array($status, ['approved', 'rejected'])) {
        return $this->failValidationErrors('Invalid status');
    }

    // Perbarui status proyek
    $data = [
        'status' => $status,
    ];

    if ($this->projectModel->update($projectId, $data)) {
        return $this->respondUpdated('Project status updated successfully');
    } else {
        return $this->failNotFound('Failed to update project status');
    }
}

    // Dosen memberikan tugas pada proyek
    public function assignTask()
    {
        $data = [
            'project_id'  => $this->request->getVar('project_id'),
            'title'       => $this->request->getVar('title'),
            'description' => $this->request->getVar('description'),
            'status'      => 'pending', // Status default
            'deadline'    => $this->request->getVar('deadline'),
        ];

        if ($this->taskModel->save($data)) {
            return $this->respondCreated('Task assigned successfully');
        } else {
            return $this->failValidationErrors('Failed to assign task');
        }
    }

    // Dosen melihat semua tugas di sebuah proyek
    public function listTasks($projectId)
    {
        $tasks = $this->taskModel->where('project_id', $projectId)->findAll();
        return $this->respond($tasks);
    }
}
