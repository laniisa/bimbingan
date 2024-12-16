<?php
namespace App\Models;

use CodeIgniter\Model;

class SupervisionRequestModel extends Model
{
    protected $table = 'supervision_requests';
    protected $primaryKey = 'request_id';
    protected $allowedFields = ['student_id', 'lecturer_id', 'status'];
    protected $useTimestamps = true;
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';

    // Menambahkan relasi jika perlu
    public function getRequestByStudent($student_id)
    {
        return $this->where('student_id', $student_id)->findAll();
    }

    public function getRequestByLecturer($lecturer_id)
    {
        return $this->where('lecturer_id', $lecturer_id)->findAll();
    }
}
