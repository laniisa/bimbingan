-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 16, 2024 at 09:22 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bimbingan`
--

-- --------------------------------------------------------

--
-- Table structure for table `approvals`
--

CREATE TABLE `approvals` (
  `approval_id` int(11) NOT NULL,
  `task_id` int(11) DEFAULT NULL,
  `file_id` int(11) DEFAULT NULL,
  `lecturer_id` int(11) DEFAULT NULL,
  `status` enum('approved','revision_needed') NOT NULL,
  `comments` text DEFAULT NULL,
  `approval_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE `files` (
  `file_id` int(11) NOT NULL,
  `project_id` int(11) DEFAULT NULL,
  `uploader_id` int(11) DEFAULT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jadwal_bimbingan`
--

CREATE TABLE `jadwal_bimbingan` (
  `id_jadwal` int(11) NOT NULL,
  `dosen_id` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `waktu_mulai` time NOT NULL,
  `waktu_selesai` time NOT NULL,
  `max_peserta` int(11) DEFAULT 1,
  `peserta_terdaftar` int(11) DEFAULT 0,
  `status` enum('available','booked') DEFAULT 'available',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pengajuan_waktu`
--

CREATE TABLE `pengajuan_waktu` (
  `id_pengajuan` int(11) NOT NULL,
  `mahasiswa_id` int(11) NOT NULL,
  `id_jadwal` int(11) NOT NULL,
  `status_pengajuan` enum('pending','approved','rejected') DEFAULT 'pending',
  `alasan_penolakan` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `project_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `student_id` int(11) DEFAULT NULL,
  `lecturer_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('pending','approved','rejected') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `supervision_requests`
--

CREATE TABLE `supervision_requests` (
  `request_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `lecturer_id` int(11) NOT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supervision_requests`
--

INSERT INTO `supervision_requests` (`request_id`, `student_id`, `lecturer_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 'pending', '2024-12-16 03:17:52', '2024-12-16 03:17:52');

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `task_id` int(11) NOT NULL,
  `project_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `status` enum('pending','in_progress','completed') DEFAULT 'pending',
  `deadline` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('student','lecturer') NOT NULL,
  `supervisor_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password`, `role`, `supervisor_id`) VALUES
(1, 'tes', 'tes@example.com', 'b93939873fd4923043b9dec975811f66', 'student', NULL),
(2, 'tesdos', 'tes.dosen@example.com', 'b93939873fd4923043b9dec975811f66', 'lecturer', NULL),
(3, 'lanisa', 'lani@gmail.com', 'lanisa', 'student', NULL),
(4, '', 'email@example.com', '$2y$10$eFXX5W9CGyMfctK5PZp5.OwfZ9bQc90R/NQJr28/SzB2iWC1OMGbW', 'student', NULL),
(11, 'user123', 'email123@example.com', '$2y$10$4UVP92R8LmRpVQAuuhJlQOJnZKKo9bMCD4OSzqnK5Pe3FPOTB8U1K', 'lecturer', NULL),
(25, 'student123', 'email123@gmail.com', '$2y$10$ngpPbOcxDevXDdP4Mdbk4u0ucgDIWerw9WbZgh4qgu25BjUnESHcK', 'student', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `approvals`
--
ALTER TABLE `approvals`
  ADD PRIMARY KEY (`approval_id`),
  ADD KEY `task_id` (`task_id`),
  ADD KEY `file_id` (`file_id`),
  ADD KEY `lecturer_id` (`lecturer_id`);

--
-- Indexes for table `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`file_id`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `uploader_id` (`uploader_id`);

--
-- Indexes for table `jadwal_bimbingan`
--
ALTER TABLE `jadwal_bimbingan`
  ADD PRIMARY KEY (`id_jadwal`),
  ADD KEY `dosen_id` (`dosen_id`);

--
-- Indexes for table `pengajuan_waktu`
--
ALTER TABLE `pengajuan_waktu`
  ADD PRIMARY KEY (`id_pengajuan`),
  ADD KEY `mahasiswa_id` (`mahasiswa_id`),
  ADD KEY `id_jadwal` (`id_jadwal`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`project_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `lecturer_id` (`lecturer_id`);

--
-- Indexes for table `supervision_requests`
--
ALTER TABLE `supervision_requests`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `lecturer_id` (`lecturer_id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`task_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `supervisor_id` (`supervisor_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `approvals`
--
ALTER TABLE `approvals`
  MODIFY `approval_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `files`
--
ALTER TABLE `files`
  MODIFY `file_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jadwal_bimbingan`
--
ALTER TABLE `jadwal_bimbingan`
  MODIFY `id_jadwal` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pengajuan_waktu`
--
ALTER TABLE `pengajuan_waktu`
  MODIFY `id_pengajuan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `project_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `supervision_requests`
--
ALTER TABLE `supervision_requests`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `task_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `approvals`
--
ALTER TABLE `approvals`
  ADD CONSTRAINT `approvals_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`task_id`),
  ADD CONSTRAINT `approvals_ibfk_2` FOREIGN KEY (`file_id`) REFERENCES `files` (`file_id`),
  ADD CONSTRAINT `approvals_ibfk_3` FOREIGN KEY (`lecturer_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `files_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`),
  ADD CONSTRAINT `files_ibfk_2` FOREIGN KEY (`uploader_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `jadwal_bimbingan`
--
ALTER TABLE `jadwal_bimbingan`
  ADD CONSTRAINT `jadwal_bimbingan_ibfk_1` FOREIGN KEY (`dosen_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `pengajuan_waktu`
--
ALTER TABLE `pengajuan_waktu`
  ADD CONSTRAINT `pengajuan_waktu_ibfk_1` FOREIGN KEY (`mahasiswa_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pengajuan_waktu_ibfk_2` FOREIGN KEY (`id_jadwal`) REFERENCES `jadwal_bimbingan` (`id_jadwal`) ON DELETE CASCADE;

--
-- Constraints for table `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `projects_ibfk_2` FOREIGN KEY (`lecturer_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `supervision_requests`
--
ALTER TABLE `supervision_requests`
  ADD CONSTRAINT `supervision_requests_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `supervision_requests_ibfk_2` FOREIGN KEY (`lecturer_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`supervisor_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
