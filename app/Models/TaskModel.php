<?php

namespace App\Models;

use CodeIgniter\Model;

class TaskModel extends Model
{
    protected $table      = 'tasks';
    protected $primaryKey = 'task_id';

    protected $returnType     = 'array';
    protected $useSoftDeletes = false;
    protected $allowedFields = ['project_id', 'title', 'description', 'status', 'deadline', 'created_at'];

    // Validasi input
    protected $validationRules    = [
        'title'       => 'required|string|max_length[255]',
        'description' => 'required|string',
        'project_id'  => 'required|integer',
        'status'      => 'required|in_list[pending,in_progress,completed]',
    ];
    protected $validationMessages = [];
}
