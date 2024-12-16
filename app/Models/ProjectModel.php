<?php

namespace App\Models;

use CodeIgniter\Model;

class ProjectModel extends Model
{
    protected $table      = 'projects';
    protected $primaryKey = 'project_id';

    protected $returnType     = 'array';
    protected $useSoftDeletes = false;
    protected $allowedFields = ['title', 'description', 'student_id', 'lecturer_id', 'status', 'created_at'];

    // Validasi input
    protected $validationRules    = [
        'title'       => 'required|string|max_length[255]',
        'description' => 'required|string',
        'student_id'  => 'required|integer',
        'lecturer_id' => 'required|integer',
    ];
    protected $validationMessages = [];
}
