-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: curhatin
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aktivitas`
--

DROP TABLE IF EXISTS `aktivitas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aktivitas` (
  `id_aktivitas` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_materi` bigint(20) unsigned DEFAULT NULL,
  `judul` varchar(150) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `jenis` enum('relaksasi','non_relaksasi') NOT NULL,
  `kategori` varchar(100) NOT NULL,
  `durasi_menit` int(10) unsigned DEFAULT NULL,
  `status` enum('aktif','nonaktif') NOT NULL DEFAULT 'aktif',
  PRIMARY KEY (`id_aktivitas`),
  KEY `fk_aktivitas_materi` (`id_materi`),
  CONSTRAINT `fk_aktivitas_materi` FOREIGN KEY (`id_materi`) REFERENCES `materi_relaksasi` (`id_materi`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aktivitas`
--

LOCK TABLES `aktivitas` WRITE;
/*!40000 ALTER TABLE `aktivitas` DISABLE KEYS */;
INSERT INTO `aktivitas` VALUES (1,4,'Latihan Pernapasan','Ikuti timer napas 4-4-4','relaksasi','pernapasan',3,'aktif'),(2,1,'Dengarkan Suara Hujan','Dengarkan audio relaksasi','relaksasi','audio',10,'aktif'),(3,NULL,'Minum Air Putih','Minum air putih secukupnya','non_relaksasi','hidrasi',2,'aktif'),(4,NULL,'Jalan Santai','Berjalan santai di lingkungan aman','non_relaksasi','fisik',15,'aktif'),(5,NULL,'Menulis Jurnal','Luangkan waktu untuk refleksi','non_relaksasi','jurnal',10,'aktif'),(6,5,'Latihan Grounding','Ikuti latihan grounding','relaksasi','grounding',5,'aktif'),(7,3,'Meditasi Visual','Tonton video relaksasi','relaksasi','meditasi',5,'aktif');
/*!40000 ALTER TABLE `aktivitas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asesmen`
--

DROP TABLE IF EXISTS `asesmen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asesmen` (
  `id_asesmen` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `judul` varchar(150) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `tipe` enum('awal','lanjutan') NOT NULL,
  `status` enum('aktif','nonaktif') NOT NULL DEFAULT 'aktif',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_asesmen`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asesmen`
--

LOCK TABLES `asesmen` WRITE;
/*!40000 ALTER TABLE `asesmen` DISABLE KEYS */;
INSERT INTO `asesmen` VALUES (1,'Asesmen Mandiri DASS-21','Contoh ringkas untuk pengujian relasi, bukan instrumen DASS-21 lengkap','awal','aktif','2026-10-30 13:44:09','2026-10-30 13:44:09'),(2,'Asesmen Lanjutan Kecemasan','Pertanyaan tindak lanjut ilustratif','lanjutan','aktif','2026-10-30 13:44:09','2026-10-30 13:44:09'),(3,'Asesmen Lanjutan Stres','Pertanyaan tindak lanjut ilustratif','lanjutan','aktif','2026-10-30 13:44:09','2026-10-30 13:44:09');
/*!40000 ALTER TABLE `asesmen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_log`
--

DROP TABLE IF EXISTS `audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audit_log` (
  `id_audit` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` bigint(20) unsigned DEFAULT NULL,
  `aksi` varchar(100) NOT NULL,
  `nama_tabel` varchar(100) NOT NULL,
  `id_record` varchar(100) DEFAULT NULL,
  `waktu` datetime NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_audit`),
  KEY `idx_audit_user_waktu` (`id_user`,`waktu`),
  KEY `idx_audit_target` (`nama_tabel`,`id_record`),
  CONSTRAINT `fk_audit_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_log`
--

LOCK TABLES `audit_log` WRITE;
/*!40000 ALTER TABLE `audit_log` DISABLE KEYS */;
INSERT INTO `audit_log` VALUES (1,1,'CREATE','materi_relaksasi','5','2026-10-27 09:00:00','192.0.2.10'),(2,1,'UPDATE','asesmen','1','2026-10-27 09:10:00','192.0.2.10'),(3,1,'UPDATE','forum_postingan','2','2026-10-28 09:00:00','192.0.2.10'),(4,1,'CREATE','aktivitas','7','2026-10-29 09:00:00','192.0.2.10');
/*!40000 ALTER TABLE `audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catatan_mood`
--

DROP TABLE IF EXISTS `catatan_mood`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catatan_mood` (
  `id_catatan_mood` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` bigint(20) unsigned NOT NULL,
  `id_mood` bigint(20) unsigned NOT NULL,
  `id_jurnal` bigint(20) unsigned DEFAULT NULL,
  `tanggal` date NOT NULL,
  `sumber` enum('harian','jurnal') NOT NULL,
  `catatan_encrypted` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_catatan_mood`),
  UNIQUE KEY `uq_mood_harian` (`id_user`,`tanggal`),
  UNIQUE KEY `uq_mood_jurnal` (`id_jurnal`),
  KEY `idx_catatan_mood_tanggal` (`tanggal`),
  KEY `fk_catatan_mood` (`id_mood`),
  CONSTRAINT `fk_catatan_jurnal` FOREIGN KEY (`id_jurnal`) REFERENCES `jurnal` (`id_jurnal`) ON DELETE SET NULL,
  CONSTRAINT `fk_catatan_mood` FOREIGN KEY (`id_mood`) REFERENCES `mood` (`id_mood`),
  CONSTRAINT `fk_catatan_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catatan_mood`
--

LOCK TABLES `catatan_mood` WRITE;
/*!40000 ALTER TABLE `catatan_mood` DISABLE KEYS */;
INSERT INTO `catatan_mood` VALUES (1,2,4,1,'2026-10-28','jurnal','DEMO_ONLY_NOT_ENCRYPTED: Mood dari jurnal','2026-10-30 13:44:10'),(2,2,3,NULL,'2026-10-29','harian','DEMO_ONLY_NOT_ENCRYPTED: Mood dipilih langsung','2026-10-30 13:44:10'),(3,3,2,3,'2026-10-29','jurnal',NULL,'2026-10-30 13:44:10'),(4,4,4,NULL,'2026-10-29','harian',NULL,'2026-10-30 13:44:10'),(5,4,5,NULL,'2026-10-30','harian',NULL,'2026-10-30 13:44:10'),(6,5,4,NULL,'2026-11-04','harian','u2eWR2/adyjleBl2lC5MRxRMPQRTLWaaUM5ye6nAJCGeF2eAHlFUlcnsEUrW3UODDbcW/lEWoQKvks2Np2CqNNBWqkDgHYPNEA==','2026-11-04 19:57:52');
/*!40000 ALTER TABLE `catatan_mood` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatbot_message`
--

DROP TABLE IF EXISTS `chatbot_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chatbot_message` (
  `id_pesan` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_sesi` bigint(20) unsigned NOT NULL,
  `pengirim` enum('user','assistant') NOT NULL,
  `pesan_encrypted` longtext NOT NULL,
  `waktu_kirim` datetime NOT NULL,
  PRIMARY KEY (`id_pesan`),
  KEY `idx_chat_pesan_sesi` (`id_sesi`,`waktu_kirim`),
  CONSTRAINT `fk_chat_pesan_sesi` FOREIGN KEY (`id_sesi`) REFERENCES `chatbot_session` (`id_sesi`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatbot_message`
--

LOCK TABLES `chatbot_message` WRITE;
/*!40000 ALTER TABLE `chatbot_message` DISABLE KEYS */;
INSERT INTO `chatbot_message` VALUES (1,1,'user','DEMO_ONLY_NOT_ENCRYPTED: Hari ini terasa sibuk.','2026-10-28 19:00:00'),(2,1,'assistant','DEMO_ONLY_NOT_ENCRYPTED: Mau cerita bagian yang paling melelahkan?','2026-10-28 19:01:00'),(3,2,'user','DEMO_ONLY_NOT_ENCRYPTED: Saya ingin mengatur waktu.','2026-10-29 20:00:00'),(4,2,'assistant','DEMO_ONLY_NOT_ENCRYPTED: Coba mulai dari tiga prioritas.','2026-10-29 20:03:00'),(5,3,'user','DEMO_ONLY_NOT_ENCRYPTED: Saya ingin refleksi singkat.','2026-10-30 08:00:00');
/*!40000 ALTER TABLE `chatbot_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatbot_session`
--

DROP TABLE IF EXISTS `chatbot_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chatbot_session` (
  `id_sesi` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` bigint(20) unsigned NOT NULL,
  `judul_sesi_encrypted` text DEFAULT NULL,
  `waktu_mulai` datetime NOT NULL,
  `waktu_terakhir` datetime NOT NULL,
  `status` enum('aktif','selesai','dihapus') NOT NULL DEFAULT 'aktif',
  PRIMARY KEY (`id_sesi`),
  KEY `idx_chat_sesi_user` (`id_user`,`waktu_terakhir`),
  CONSTRAINT `fk_chat_sesi_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatbot_session`
--

LOCK TABLES `chatbot_session` WRITE;
/*!40000 ALTER TABLE `chatbot_session` DISABLE KEYS */;
INSERT INTO `chatbot_session` VALUES (1,2,'DEMO_ONLY_NOT_ENCRYPTED: Cerita hari ini','2026-10-28 19:00:00','2026-10-28 19:05:00','selesai'),(2,3,'DEMO_ONLY_NOT_ENCRYPTED: Mengatur jadwal','2026-10-29 20:00:00','2026-10-29 20:03:00','selesai'),(3,4,'DEMO_ONLY_NOT_ENCRYPTED: Refleksi','2026-10-30 08:00:00','2026-10-30 08:02:00','aktif');
/*!40000 ALTER TABLE `chatbot_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_komentar`
--

DROP TABLE IF EXISTS `forum_komentar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_komentar` (
  `id_komentar` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_postingan` bigint(20) unsigned NOT NULL,
  `id_user` bigint(20) unsigned NOT NULL,
  `isi` text NOT NULL,
  `anonim` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('aktif','disembunyikan','dihapus') NOT NULL DEFAULT 'aktif',
  `tanggal` datetime NOT NULL,
  PRIMARY KEY (`id_komentar`),
  KEY `idx_komentar_post_tanggal` (`id_postingan`,`tanggal`),
  KEY `fk_komentar_user` (`id_user`),
  CONSTRAINT `fk_komentar_post` FOREIGN KEY (`id_postingan`) REFERENCES `forum_postingan` (`id_postingan`) ON DELETE CASCADE,
  CONSTRAINT `fk_komentar_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_komentar`
--

LOCK TABLES `forum_komentar` WRITE;
/*!40000 ALTER TABLE `forum_komentar` DISABLE KEYS */;
INSERT INTO `forum_komentar` VALUES (1,1,3,'Saya biasa membuat daftar tiga prioritas.',0,'aktif','2026-10-27 18:10:00'),(2,1,4,'Jadwalkan istirahat juga ya.',0,'aktif','2026-10-27 18:15:00'),(3,2,2,'Terima kasih sudah berbagi.',1,'aktif','2026-10-28 19:10:00');
/*!40000 ALTER TABLE `forum_komentar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_like`
--

DROP TABLE IF EXISTS `forum_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_like` (
  `id_like` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` bigint(20) unsigned NOT NULL,
  `id_postingan` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_like`),
  UNIQUE KEY `uq_forum_like` (`id_user`,`id_postingan`),
  KEY `fk_forum_like_post` (`id_postingan`),
  CONSTRAINT `fk_forum_like_post` FOREIGN KEY (`id_postingan`) REFERENCES `forum_postingan` (`id_postingan`) ON DELETE CASCADE,
  CONSTRAINT `fk_forum_like_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_like`
--

LOCK TABLES `forum_like` WRITE;
/*!40000 ALTER TABLE `forum_like` DISABLE KEYS */;
INSERT INTO `forum_like` VALUES (1,3,1,'2026-10-30 13:44:09'),(2,4,1,'2026-10-30 13:44:09'),(3,2,2,'2026-10-30 13:44:09'),(4,2,3,'2026-10-30 13:44:09');
/*!40000 ALTER TABLE `forum_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_postingan`
--

DROP TABLE IF EXISTS `forum_postingan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_postingan` (
  `id_postingan` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` bigint(20) unsigned NOT NULL,
  `judul` varchar(255) NOT NULL,
  `isi` text NOT NULL,
  `anonim` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('aktif','disembunyikan','dihapus') NOT NULL DEFAULT 'aktif',
  `tanggal` datetime NOT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_postingan`),
  KEY `idx_post_status_tanggal` (`status`,`tanggal`),
  KEY `fk_post_user` (`id_user`),
  CONSTRAINT `fk_post_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_postingan`
--

LOCK TABLES `forum_postingan` WRITE;
/*!40000 ALTER TABLE `forum_postingan` DISABLE KEYS */;
INSERT INTO `forum_postingan` VALUES (1,2,'Cara membagi waktu','Bagaimana kalian mengatur kegiatan kuliah dan istirahat?',0,'aktif','2026-10-27 18:00:00','2026-10-30 13:44:09'),(2,3,'Cerita hari ini','Hari ini saya mencoba latihan pernapasan.',1,'aktif','2026-10-28 19:00:00','2026-10-30 13:44:09'),(3,4,'Rekomendasi aktivitas','Jalan santai sore membuat saya lebih rileks.',0,'aktif','2026-10-29 17:00:00','2026-10-30 13:44:09');
/*!40000 ALTER TABLE `forum_postingan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_repost`
--

DROP TABLE IF EXISTS `forum_repost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_repost` (
  `id_repost` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` bigint(20) unsigned NOT NULL,
  `id_postingan` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_repost`),
  UNIQUE KEY `uq_forum_repost` (`id_user`,`id_postingan`),
  KEY `fk_forum_repost_post` (`id_postingan`),
  CONSTRAINT `fk_forum_repost_post` FOREIGN KEY (`id_postingan`) REFERENCES `forum_postingan` (`id_postingan`) ON DELETE CASCADE,
  CONSTRAINT `fk_forum_repost_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_repost`
--

LOCK TABLES `forum_repost` WRITE;
/*!40000 ALTER TABLE `forum_repost` DISABLE KEYS */;
INSERT INTO `forum_repost` VALUES (1,4,1,'2026-10-30 13:44:09'),(2,2,3,'2026-10-30 13:44:09');
/*!40000 ALTER TABLE `forum_repost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hasil_asesmen`
--

DROP TABLE IF EXISTS `hasil_asesmen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hasil_asesmen` (
  `id_hasil` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` bigint(20) unsigned NOT NULL,
  `id_asesmen` bigint(20) unsigned NOT NULL,
  `id_hasil_awal` bigint(20) unsigned DEFAULT NULL,
  `tanggal` datetime NOT NULL,
  `skor_stres` int(10) unsigned DEFAULT NULL,
  `skor_kecemasan` int(10) unsigned DEFAULT NULL,
  `skor_depresi` int(10) unsigned DEFAULT NULL,
  `skor_total` int(10) unsigned DEFAULT NULL,
  `interpretasi` text DEFAULT NULL,
  PRIMARY KEY (`id_hasil`),
  KEY `idx_hasil_user_tanggal` (`id_user`,`tanggal`),
  KEY `fk_hasil_asesmen` (`id_asesmen`),
  KEY `fk_hasil_awal` (`id_hasil_awal`),
  CONSTRAINT `fk_hasil_asesmen` FOREIGN KEY (`id_asesmen`) REFERENCES `asesmen` (`id_asesmen`),
  CONSTRAINT `fk_hasil_awal` FOREIGN KEY (`id_hasil_awal`) REFERENCES `hasil_asesmen` (`id_hasil`) ON DELETE SET NULL,
  CONSTRAINT `fk_hasil_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hasil_asesmen`
--

LOCK TABLES `hasil_asesmen` WRITE;
/*!40000 ALTER TABLE `hasil_asesmen` DISABLE KEYS */;
INSERT INTO `hasil_asesmen` VALUES (1,2,1,NULL,'2026-10-27 10:00:00',2,3,1,6,'Skor contoh, bukan interpretasi klinis'),(2,3,1,NULL,'2026-10-27 11:00:00',3,1,2,6,'Skor contoh, bukan interpretasi klinis'),(3,4,1,NULL,'2026-10-28 09:00:00',1,1,0,2,'Skor contoh, bukan interpretasi klinis'),(4,2,2,1,'2026-10-28 10:00:00',NULL,4,NULL,4,'Tindak lanjut contoh'),(5,3,3,2,'2026-10-28 11:00:00',4,NULL,NULL,4,'Tindak lanjut contoh');
/*!40000 ALTER TABLE `hasil_asesmen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jawaban_asesmen`
--

DROP TABLE IF EXISTS `jawaban_asesmen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jawaban_asesmen` (
  `id_jawaban` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_hasil` bigint(20) unsigned NOT NULL,
  `id_pertanyaan` bigint(20) unsigned NOT NULL,
  `nilai` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id_jawaban`),
  UNIQUE KEY `uq_jawaban_hasil_pertanyaan` (`id_hasil`,`id_pertanyaan`),
  KEY `fk_jawaban_pertanyaan` (`id_pertanyaan`),
  CONSTRAINT `fk_jawaban_hasil` FOREIGN KEY (`id_hasil`) REFERENCES `hasil_asesmen` (`id_hasil`) ON DELETE CASCADE,
  CONSTRAINT `fk_jawaban_pertanyaan` FOREIGN KEY (`id_pertanyaan`) REFERENCES `pertanyaan_asesmen` (`id_pertanyaan`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jawaban_asesmen`
--

LOCK TABLES `jawaban_asesmen` WRITE;
/*!40000 ALTER TABLE `jawaban_asesmen` DISABLE KEYS */;
INSERT INTO `jawaban_asesmen` VALUES (1,1,1,2),(2,1,2,3),(3,1,3,1),(4,2,1,3),(5,2,2,1),(6,2,3,2),(7,3,1,1),(8,3,2,1),(9,3,3,0),(10,4,4,2),(11,4,5,2),(12,5,6,2),(13,5,7,2);
/*!40000 ALTER TABLE `jawaban_asesmen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jurnal`
--

DROP TABLE IF EXISTS `jurnal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jurnal` (
  `id_jurnal` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` bigint(20) unsigned NOT NULL,
  `id_mood` bigint(20) unsigned DEFAULT NULL,
  `judul_encrypted` text NOT NULL,
  `isi_jurnal_encrypted` longtext NOT NULL,
  `jenis` enum('permanen','sementara') NOT NULL DEFAULT 'permanen',
  `status` enum('aktif','sampah') NOT NULL DEFAULT 'aktif',
  `tanggal` date NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `purge_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_jurnal`),
  KEY `idx_jurnal_user_status_tanggal` (`id_user`,`status`,`tanggal`),
  KEY `idx_jurnal_expires` (`expires_at`),
  KEY `idx_jurnal_purge` (`purge_at`),
  KEY `fk_jurnal_mood` (`id_mood`),
  CONSTRAINT `fk_jurnal_mood` FOREIGN KEY (`id_mood`) REFERENCES `mood` (`id_mood`) ON DELETE SET NULL,
  CONSTRAINT `fk_jurnal_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jurnal`
--

LOCK TABLES `jurnal` WRITE;
/*!40000 ALTER TABLE `jurnal` DISABLE KEYS */;
INSERT INTO `jurnal` VALUES (1,2,4,'DEMO_ONLY_NOT_ENCRYPTED: Hari produktif','DEMO_ONLY_NOT_ENCRYPTED: Saya menyelesaikan beberapa tugas.','permanen','aktif','2026-10-28',NULL,NULL,NULL,'2026-10-30 13:44:09','2026-10-30 13:44:09'),(2,2,3,'DEMO_ONLY_NOT_ENCRYPTED: Catatan sementara','DEMO_ONLY_NOT_ENCRYPTED: Hari ini cukup tenang.','sementara','aktif','2026-10-29','2026-11-10 00:00:00',NULL,NULL,'2026-10-30 13:44:09','2026-10-30 13:44:09'),(3,3,2,'DEMO_ONLY_NOT_ENCRYPTED: Banyak kegiatan','DEMO_ONLY_NOT_ENCRYPTED: Saya merasa lelah.','permanen','aktif','2026-10-29',NULL,NULL,NULL,'2026-10-30 13:44:09','2026-10-30 13:44:09'),(4,4,NULL,'DEMO_ONLY_NOT_ENCRYPTED: Rencana besok','DEMO_ONLY_NOT_ENCRYPTED: Saya akan berjalan santai.','permanen','aktif','2026-10-29',NULL,NULL,NULL,'2026-10-30 13:44:09','2026-10-30 13:44:09'),(5,4,5,'DEMO_ONLY_NOT_ENCRYPTED: Momen menyenangkan','DEMO_ONLY_NOT_ENCRYPTED: Saya menikmati waktu bersama teman.','sementara','sampah','2026-10-27','2026-10-28 00:00:00','2026-10-28 00:00:00','2026-11-04 00:00:00','2026-10-30 13:44:09','2026-10-30 13:44:09'),(6,5,NULL,'Coj1i3GLZPb7jnp11IV+YyTTe7VQIY1aywrC4+n3qNhzx9Sg4XQhQdptxSfeGApLue1Rd/GrQQ==','uRfleKZM7NxEQPYzYWSpWoRsfUQ1gGDgbj3nM+WX4QDXZ03ooYptL2HtpSCdiLl0VJYtHkvXLfNOiR51W7mcLL/ZEG0HygM9cJszb+SkwQ==','permanen','aktif','2026-11-05',NULL,NULL,NULL,'2026-11-04 19:51:54','2026-11-04 19:51:54');
/*!40000 ALTER TABLE `jurnal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `like_relaksasi`
--

DROP TABLE IF EXISTS `like_relaksasi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `like_relaksasi` (
  `id_like` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` bigint(20) unsigned NOT NULL,
  `id_materi` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_like`),
  UNIQUE KEY `uq_like_relaksasi` (`id_user`,`id_materi`),
  KEY `fk_like_relaksasi_materi` (`id_materi`),
  CONSTRAINT `fk_like_relaksasi_materi` FOREIGN KEY (`id_materi`) REFERENCES `materi_relaksasi` (`id_materi`) ON DELETE CASCADE,
  CONSTRAINT `fk_like_relaksasi_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `like_relaksasi`
--

LOCK TABLES `like_relaksasi` WRITE;
/*!40000 ALTER TABLE `like_relaksasi` DISABLE KEYS */;
INSERT INTO `like_relaksasi` VALUES (1,2,1,'2026-10-30 13:44:09'),(2,2,4,'2026-10-30 13:44:09'),(3,3,5,'2026-10-30 13:44:09'),(4,4,3,'2026-10-30 13:44:09');
/*!40000 ALTER TABLE `like_relaksasi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materi_relaksasi`
--

DROP TABLE IF EXISTS `materi_relaksasi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `materi_relaksasi` (
  `id_materi` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `judul` varchar(150) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `jenis` varchar(50) NOT NULL,
  `kategori` varchar(100) NOT NULL,
  `thumbnail` varchar(500) DEFAULT NULL,
  `durasi_menit` int(10) unsigned DEFAULT NULL,
  `status` enum('aktif','nonaktif') NOT NULL DEFAULT 'aktif',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_materi`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materi_relaksasi`
--

LOCK TABLES `materi_relaksasi` WRITE;
/*!40000 ALTER TABLE `materi_relaksasi` DISABLE KEYS */;
INSERT INTO `materi_relaksasi` VALUES (1,'Suara Hujan','Audio hujan untuk relaksasi','audio','musik alam','demo/hujan.jpg',10,'aktif','2026-10-30 13:44:09','2026-10-30 13:44:09'),(2,'Musik Piano Tenang','Musik instrumental','audio','musik','demo/piano.jpg',8,'aktif','2026-10-30 13:44:09','2026-10-30 13:44:09'),(3,'Meditasi Pemandangan Laut','Video relaksasi visual','video','meditasi','demo/laut.jpg',5,'aktif','2026-10-30 13:44:09','2026-10-30 13:44:09'),(4,'Pernapasan 4-4-4','Latihan pernapasan berpola','timer','pernapasan','demo/napas.jpg',3,'aktif','2026-10-30 13:44:09','2026-10-30 13:44:09'),(5,'Grounding 5-4-3-2-1','Latihan perhatian pada lingkungan','timer','grounding','demo/grounding.jpg',5,'aktif','2026-10-30 13:44:09','2026-10-30 13:44:09');
/*!40000 ALTER TABLE `materi_relaksasi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mood`
--

DROP TABLE IF EXISTS `mood`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mood` (
  `id_mood` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nama_mood` varchar(50) NOT NULL,
  `ikon` varchar(100) NOT NULL,
  `nilai` tinyint(3) unsigned NOT NULL,
  `deskripsi` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_mood`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mood`
--

LOCK TABLES `mood` WRITE;
/*!40000 ALTER TABLE `mood` DISABLE KEYS */;
INSERT INTO `mood` VALUES (1,'Sangat Sedih','mood_1',1,'Mood sangat rendah'),(2,'Sedih','mood_2',2,'Mood rendah'),(3,'Biasa Saja','mood_3',3,'Mood netral'),(4,'Senang','mood_4',4,'Mood baik'),(5,'Sangat Senang','mood_5',5,'Mood sangat baik');
/*!40000 ALTER TABLE `mood` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_deliveries`
--

DROP TABLE IF EXISTS `notification_deliveries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_deliveries` (
  `id_delivery` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_notification` bigint(20) unsigned NOT NULL,
  `id_device` bigint(20) unsigned NOT NULL,
  `status` enum('pending','sent','failed') NOT NULL DEFAULT 'pending',
  `sent_at` datetime DEFAULT NULL,
  `error_message` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_delivery`),
  UNIQUE KEY `uq_notif_delivery` (`id_notification`,`id_device`),
  KEY `idx_delivery_device_status` (`id_device`,`status`),
  KEY `idx_delivery_status_created` (`status`,`created_at`),
  CONSTRAINT `fk_delivery_device` FOREIGN KEY (`id_device`) REFERENCES `user_devices` (`id_device`),
  CONSTRAINT `fk_delivery_notification` FOREIGN KEY (`id_notification`) REFERENCES `notifications` (`id_notification`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_deliveries`
--

LOCK TABLES `notification_deliveries` WRITE;
/*!40000 ALTER TABLE `notification_deliveries` DISABLE KEYS */;
INSERT INTO `notification_deliveries` VALUES (1,1,2,'sent','2026-10-29 07:00:05',NULL,'2026-10-30 13:44:10'),(2,1,3,'sent','2026-10-29 07:00:06',NULL,'2026-10-30 13:44:10'),(3,2,2,'pending',NULL,NULL,'2026-10-30 13:44:10'),(4,2,3,'pending',NULL,NULL,'2026-10-30 13:44:10'),(5,3,4,'sent','2026-10-29 18:00:05',NULL,'2026-10-30 13:44:10'),(6,4,5,'sent','2026-10-29 19:05:05',NULL,'2026-10-30 13:44:10'),(7,5,6,'failed',NULL,'Perangkat tidak aktif (simulasi)','2026-10-30 13:44:10');
/*!40000 ALTER TABLE `notification_deliveries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id_notification` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` bigint(20) unsigned NOT NULL,
  `judul` varchar(255) NOT NULL,
  `pesan` text NOT NULL,
  `tipe` varchar(50) NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `data_payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data_payload`)),
  `scheduled_at` datetime DEFAULT NULL,
  `sent_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_notification`),
  KEY `idx_notif_user_created` (`id_user`,`created_at`),
  KEY `idx_notif_scheduled` (`scheduled_at`,`sent_at`),
  CONSTRAINT `fk_notif_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,2,'Aktivitas harian','Ada kegiatan untukmu hari ini.','aktivitas',1,'{\"screen\":\"aktivitas_harian\"}','2026-10-29 07:00:00','2026-10-29 07:00:05','2026-10-30 13:44:10'),(2,2,'Pengingat mood','Bagaimana perasaanmu hari ini?','mood',0,'{\"screen\":\"mood_tracker\"}','2026-10-30 20:00:00',NULL,'2026-10-30 13:44:10'),(3,3,'Waktunya relaksasi','Coba luangkan waktu sejenak.','relaksasi',0,'{\"screen\":\"pojok_relaksasi\",\"id_materi\":5}','2026-10-29 18:00:00','2026-10-29 18:00:05','2026-10-30 13:44:10'),(4,4,'Aktivitas selesai','Terima kasih sudah menyelesaikan kegiatan.','aktivitas',1,'{\"screen\":\"aktivitas_harian\"}',NULL,'2026-10-29 19:05:05','2026-10-30 13:44:10'),(5,5,'Selamat datang','Mulai perjalanan harianmu bersama Curhatin.','sistem',0,'{\"screen\":\"beranda\"}',NULL,NULL,'2026-10-30 13:44:10');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `otp_verifications`
--

DROP TABLE IF EXISTS `otp_verifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `otp_verifications` (
  `id_otp` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `no_telepon` varchar(20) NOT NULL,
  `otp_hash` varchar(255) NOT NULL,
  `expires_at` datetime NOT NULL,
  `attempt_count` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `verified_at` datetime DEFAULT NULL,
  `consumed_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_otp`),
  KEY `idx_otp_phone_created` (`no_telepon`,`created_at`),
  KEY `idx_otp_expires` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `otp_verifications`
--

LOCK TABLES `otp_verifications` WRITE;
/*!40000 ALTER TABLE `otp_verifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `otp_verifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `penggunaan_relaksasi`
--

DROP TABLE IF EXISTS `penggunaan_relaksasi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `penggunaan_relaksasi` (
  `id_penggunaan` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` bigint(20) unsigned NOT NULL,
  `id_materi` bigint(20) unsigned NOT NULL,
  `waktu_mulai` datetime NOT NULL,
  `waktu_selesai` datetime DEFAULT NULL,
  `durasi_penggunaan` int(10) unsigned NOT NULL DEFAULT 0,
  `status` enum('berlangsung','selesai','dibatalkan') NOT NULL DEFAULT 'berlangsung',
  PRIMARY KEY (`id_penggunaan`),
  KEY `idx_penggunaan_user_waktu` (`id_user`,`waktu_mulai`),
  KEY `idx_penggunaan_materi_waktu` (`id_materi`,`waktu_mulai`),
  CONSTRAINT `fk_penggunaan_materi` FOREIGN KEY (`id_materi`) REFERENCES `materi_relaksasi` (`id_materi`),
  CONSTRAINT `fk_penggunaan_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `penggunaan_relaksasi`
--

LOCK TABLES `penggunaan_relaksasi` WRITE;
/*!40000 ALTER TABLE `penggunaan_relaksasi` DISABLE KEYS */;
INSERT INTO `penggunaan_relaksasi` VALUES (1,2,4,'2026-10-28 07:00:00','2026-10-28 07:03:00',180,'selesai'),(2,2,1,'2026-10-29 20:00:00','2026-10-29 20:10:00',600,'selesai'),(3,3,5,'2026-10-29 18:00:00',NULL,150,'berlangsung'),(4,4,3,'2026-10-30 08:00:00','2026-10-30 08:05:00',300,'selesai');
/*!40000 ALTER TABLE `penggunaan_relaksasi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pertanyaan_asesmen`
--

DROP TABLE IF EXISTS `pertanyaan_asesmen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pertanyaan_asesmen` (
  `id_pertanyaan` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_asesmen` bigint(20) unsigned NOT NULL,
  `nomor` int(10) unsigned NOT NULL,
  `pertanyaan` text NOT NULL,
  `kategori` varchar(100) NOT NULL,
  PRIMARY KEY (`id_pertanyaan`),
  UNIQUE KEY `uq_pertanyaan_nomor` (`id_asesmen`,`nomor`),
  CONSTRAINT `fk_pertanyaan_asesmen` FOREIGN KEY (`id_asesmen`) REFERENCES `asesmen` (`id_asesmen`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pertanyaan_asesmen`
--

LOCK TABLES `pertanyaan_asesmen` WRITE;
/*!40000 ALTER TABLE `pertanyaan_asesmen` DISABLE KEYS */;
INSERT INTO `pertanyaan_asesmen` VALUES (1,1,1,'Saya sulit merasa tenang.','stres'),(2,1,2,'Saya merasa khawatir tanpa alasan yang jelas.','kecemasan'),(3,1,3,'Saya sulit menikmati kegiatan yang biasanya menyenangkan.','depresi'),(4,2,1,'Saya menghindari situasi yang membuat khawatir.','kecemasan'),(5,2,2,'Kekhawatiran mengganggu kegiatan sehari-hari.','kecemasan'),(6,3,1,'Saya merasa kewalahan dengan tugas harian.','stres'),(7,3,2,'Saya sulit beristirahat setelah beraktivitas.','stres');
/*!40000 ALTER TABLE `pertanyaan_asesmen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rekomendasi_aktivitas`
--

DROP TABLE IF EXISTS `rekomendasi_aktivitas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rekomendasi_aktivitas` (
  `id_rekomendasi` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` bigint(20) unsigned NOT NULL,
  `id_aktivitas` bigint(20) unsigned NOT NULL,
  `id_hasil` bigint(20) unsigned DEFAULT NULL,
  `id_catatan_mood` bigint(20) unsigned DEFAULT NULL,
  `tanggal_rekomendasi` date NOT NULL,
  `progress_persen` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `alasan` text DEFAULT NULL,
  `status` enum('belum','berlangsung','selesai','dilewati') NOT NULL DEFAULT 'belum',
  `waktu_mulai` datetime DEFAULT NULL,
  `waktu_selesai` datetime DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_rekomendasi`),
  UNIQUE KEY `uq_rekomendasi_harian` (`id_user`,`tanggal_rekomendasi`,`id_aktivitas`),
  KEY `idx_rekomendasi_user_tgl_status` (`id_user`,`tanggal_rekomendasi`,`status`),
  KEY `idx_rekomendasi_purge` (`tanggal_rekomendasi`),
  KEY `fk_rekomendasi_aktivitas` (`id_aktivitas`),
  KEY `fk_rekomendasi_hasil` (`id_hasil`),
  KEY `fk_rekomendasi_catatan` (`id_catatan_mood`),
  CONSTRAINT `fk_rekomendasi_aktivitas` FOREIGN KEY (`id_aktivitas`) REFERENCES `aktivitas` (`id_aktivitas`),
  CONSTRAINT `fk_rekomendasi_catatan` FOREIGN KEY (`id_catatan_mood`) REFERENCES `catatan_mood` (`id_catatan_mood`) ON DELETE SET NULL,
  CONSTRAINT `fk_rekomendasi_hasil` FOREIGN KEY (`id_hasil`) REFERENCES `hasil_asesmen` (`id_hasil`) ON DELETE SET NULL,
  CONSTRAINT `fk_rekomendasi_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rekomendasi_aktivitas`
--

LOCK TABLES `rekomendasi_aktivitas` WRITE;
/*!40000 ALTER TABLE `rekomendasi_aktivitas` DISABLE KEYS */;
INSERT INTO `rekomendasi_aktivitas` VALUES (1,2,1,1,1,'2026-10-28',100,'Latihan singkat berdasarkan asesmen dan mood','selesai','2026-10-28 07:00:00','2026-10-28 07:03:00','2026-10-30 13:44:10'),(2,2,3,1,1,'2026-10-28',100,'Rutinitas hidrasi','selesai','2026-10-28 08:00:00','2026-10-28 08:02:00','2026-10-30 13:44:10'),(3,2,5,1,2,'2026-10-29',50,'Refleksi harian','berlangsung','2026-10-29 20:00:00',NULL,'2026-10-30 13:44:10'),(4,2,2,1,2,'2026-10-29',0,'Relaksasi sebelum istirahat','dilewati',NULL,NULL,'2026-10-30 13:44:10'),(5,2,4,4,2,'2026-10-30',0,'Aktivitas ringan hari ini','belum',NULL,NULL,'2026-10-30 13:44:10'),(6,3,6,2,3,'2026-10-29',50,'Latihan grounding','berlangsung','2026-10-29 18:00:00',NULL,'2026-10-30 13:44:10'),(7,3,3,2,3,'2026-10-29',100,'Pengingat hidrasi','selesai','2026-10-29 09:00:00','2026-10-29 09:02:00','2026-10-30 13:44:10'),(8,3,4,5,3,'2026-10-30',0,'Gerak fisik ringan','belum',NULL,NULL,'2026-10-30 13:44:10'),(9,4,7,3,4,'2026-10-29',100,'Relaksasi visual','selesai','2026-10-29 19:00:00','2026-10-29 19:05:00','2026-10-30 13:44:10'),(10,4,4,3,5,'2026-10-30',0,'Jalan santai sesuai rutinitas','belum',NULL,NULL,'2026-10-30 13:44:10'),(11,4,5,3,5,'2026-10-30',30,'Menulis refleksi','berlangsung','2026-10-30 08:30:00',NULL,'2026-10-30 13:44:10'),(12,5,3,NULL,NULL,'2026-10-30',0,'Rekomendasi umum untuk pengguna baru','belum',NULL,NULL,'2026-10-30 13:44:10');
/*!40000 ALTER TABLE `rekomendasi_aktivitas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relaksasi_audio`
--

DROP TABLE IF EXISTS `relaksasi_audio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relaksasi_audio` (
  `id_materi` bigint(20) unsigned NOT NULL,
  `file_audio` varchar(500) NOT NULL,
  `durasi_detik` int(10) unsigned NOT NULL,
  `loop_audio` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_materi`),
  CONSTRAINT `fk_audio_materi` FOREIGN KEY (`id_materi`) REFERENCES `materi_relaksasi` (`id_materi`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relaksasi_audio`
--

LOCK TABLES `relaksasi_audio` WRITE;
/*!40000 ALTER TABLE `relaksasi_audio` DISABLE KEYS */;
INSERT INTO `relaksasi_audio` VALUES (1,'demo/audio/hujan.mp3',600,1),(2,'demo/audio/piano.mp3',480,0);
/*!40000 ALTER TABLE `relaksasi_audio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relaksasi_timer`
--

DROP TABLE IF EXISTS `relaksasi_timer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relaksasi_timer` (
  `id_materi` bigint(20) unsigned NOT NULL,
  `tipe_timer` varchar(50) NOT NULL,
  `durasi_total_detik` int(10) unsigned NOT NULL,
  `jumlah_pengulangan` int(10) unsigned NOT NULL DEFAULT 1,
  `suara_panduan` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id_materi`),
  CONSTRAINT `fk_timer_materi` FOREIGN KEY (`id_materi`) REFERENCES `materi_relaksasi` (`id_materi`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relaksasi_timer`
--

LOCK TABLES `relaksasi_timer` WRITE;
/*!40000 ALTER TABLE `relaksasi_timer` DISABLE KEYS */;
INSERT INTO `relaksasi_timer` VALUES (4,'pernapasan',180,15,NULL),(5,'grounding',300,1,NULL);
/*!40000 ALTER TABLE `relaksasi_timer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relaksasi_video`
--

DROP TABLE IF EXISTS `relaksasi_video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relaksasi_video` (
  `id_materi` bigint(20) unsigned NOT NULL,
  `file_video` varchar(500) NOT NULL,
  `durasi_detik` int(10) unsigned NOT NULL,
  `autoplay` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_materi`),
  CONSTRAINT `fk_video_materi` FOREIGN KEY (`id_materi`) REFERENCES `materi_relaksasi` (`id_materi`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relaksasi_video`
--

LOCK TABLES `relaksasi_video` WRITE;
/*!40000 ALTER TABLE `relaksasi_video` DISABLE KEYS */;
INSERT INTO `relaksasi_video` VALUES (3,'demo/video/laut.mp4',300,0);
/*!40000 ALTER TABLE `relaksasi_video` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `riwayat_login`
--

DROP TABLE IF EXISTS `riwayat_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `riwayat_login` (
  `id_login` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` bigint(20) unsigned DEFAULT NULL,
  `metode_login` enum('google','phone_otp','password') DEFAULT NULL,
  `device_name` varchar(150) DEFAULT NULL,
  `device_type` enum('android','ios','web') DEFAULT NULL,
  `os_version` varchar(100) DEFAULT NULL,
  `browser` varchar(100) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `lokasi` varchar(255) DEFAULT NULL,
  `waktu_login` datetime NOT NULL,
  `status_login` enum('berhasil','gagal') NOT NULL,
  PRIMARY KEY (`id_login`),
  KEY `idx_login_user_waktu` (`id_user`,`waktu_login`),
  CONSTRAINT `fk_login_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `riwayat_login`
--

LOCK TABLES `riwayat_login` WRITE;
/*!40000 ALTER TABLE `riwayat_login` DISABLE KEYS */;
INSERT INTO `riwayat_login` VALUES (1,1,'google','Laptop Admin','web','Windows 11','Chrome','192.0.2.10','Batam','2026-10-28 08:00:00','berhasil'),(2,2,'google','Pixel Demo','android','Android 15',NULL,'192.0.2.11','Batam','2026-10-28 09:00:00','berhasil'),(3,3,'phone_otp','iPhone Demo','ios','iOS 18',NULL,'192.0.2.12','Batam','2026-10-28 10:00:00','berhasil'),(4,4,'google','Samsung Demo','android','Android 14',NULL,'192.0.2.13','Batam','2026-10-29 09:00:00','berhasil'),(5,NULL,'phone_otp',NULL,'web',NULL,'Chrome','192.0.2.99',NULL,'2026-10-29 10:00:00','gagal');
/*!40000 ALTER TABLE `riwayat_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tahapan_timer`
--

DROP TABLE IF EXISTS `tahapan_timer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tahapan_timer` (
  `id_tahapan` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_materi` bigint(20) unsigned NOT NULL,
  `urutan` int(10) unsigned NOT NULL,
  `nama_tahapan` varchar(100) NOT NULL,
  `instruksi` text DEFAULT NULL,
  `durasi_detik` int(10) unsigned NOT NULL,
  `tipe_animasi` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_tahapan`),
  UNIQUE KEY `uq_tahapan_urutan` (`id_materi`,`urutan`),
  CONSTRAINT `fk_tahapan_timer` FOREIGN KEY (`id_materi`) REFERENCES `relaksasi_timer` (`id_materi`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tahapan_timer`
--

LOCK TABLES `tahapan_timer` WRITE;
/*!40000 ALTER TABLE `tahapan_timer` DISABLE KEYS */;
INSERT INTO `tahapan_timer` VALUES (1,4,1,'Tarik napas','Tarik napas perlahan',4,'membesar'),(2,4,2,'Tahan napas','Tahan sebentar',4,'diam'),(3,4,3,'Hembuskan','Hembuskan perlahan',4,'mengecil'),(4,5,1,'Lihat','Sebutkan lima hal yang terlihat',60,'teks'),(5,5,2,'Sentuh','Sebutkan empat hal yang terasa',60,'teks'),(6,5,3,'Dengar','Sebutkan tiga suara',60,'teks'),(7,5,4,'Cium','Sebutkan dua aroma',60,'teks'),(8,5,5,'Rasakan','Sebutkan satu rasa',60,'teks');
/*!40000 ALTER TABLE `tahapan_timer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_devices`
--

DROP TABLE IF EXISTS `user_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_devices` (
  `id_device` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` bigint(20) unsigned NOT NULL,
  `device_id` varchar(255) NOT NULL,
  `fcm_token` text NOT NULL,
  `platform` enum('android','ios','web') NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `last_seen_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_device`),
  UNIQUE KEY `uq_user_device` (`id_user`,`device_id`),
  KEY `idx_devices_user_active` (`id_user`,`is_active`),
  CONSTRAINT `fk_device_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_devices`
--

LOCK TABLES `user_devices` WRITE;
/*!40000 ALTER TABLE `user_devices` DISABLE KEYS */;
INSERT INTO `user_devices` VALUES (1,1,'dummy_admin_web_01','DUMMY_FCM_TOKEN_ADMIN_WEB_NOT_VALID','web',1,'2026-10-30 08:00:00','2026-10-30 13:44:10','2026-10-30 13:44:10'),(2,2,'dummy_nadia_android_01','DUMMY_FCM_TOKEN_NADIA_ANDROID_NOT_VALID','android',1,'2026-10-30 09:00:00','2026-10-30 13:44:10','2026-10-30 13:44:10'),(3,2,'dummy_nadia_web_01','DUMMY_FCM_TOKEN_NADIA_WEB_NOT_VALID','web',1,'2026-10-29 20:00:00','2026-10-30 13:44:10','2026-10-30 13:44:10'),(4,3,'dummy_raka_ios_01','DUMMY_FCM_TOKEN_RAKA_IOS_NOT_VALID','ios',1,'2026-10-30 08:00:00','2026-10-30 13:44:10','2026-10-30 13:44:10'),(5,4,'dummy_salsa_android_01','DUMMY_FCM_TOKEN_SALSA_ANDROID_NOT_VALID','android',1,'2026-10-30 09:00:00','2026-10-30 13:44:10','2026-10-30 13:44:10'),(6,5,'dummy_bima_android_01','DUMMY_FCM_TOKEN_BIMA_ANDROID_NOT_VALID','android',0,'2026-10-28 09:00:00','2026-10-30 13:44:10','2026-10-30 13:44:10');
/*!40000 ALTER TABLE `user_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id_user` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `google_uid` varchar(128) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `nama` varchar(150) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `email_verified_at` datetime DEFAULT NULL,
  `no_telepon` varchar(20) DEFAULT NULL,
  `no_telepon_verified_at` datetime DEFAULT NULL,
  `foto_profil` varchar(500) DEFAULT NULL,
  `role` enum('user','admin') NOT NULL DEFAULT 'user',
  `status` enum('aktif','nonaktif') NOT NULL DEFAULT 'aktif',
  `streak` int(10) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `firebase_uid` (`google_uid`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `no_telepon` (`no_telepon`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,NULL,NULL,'Admin Curhatin','admin.demo@curhatin.test',NULL,NULL,NULL,NULL,'admin','aktif',0,'2026-10-30 13:44:09','2026-11-03 08:09:39'),(2,NULL,NULL,'Nadia Putri','nadia.demo@curhatin.test',NULL,'+6281100000002',NULL,NULL,'user','aktif',5,'2026-10-30 13:44:09','2026-11-03 08:09:39'),(3,NULL,NULL,'Raka Pratama','raka.demo@curhatin.test',NULL,'+6281100000003',NULL,NULL,'user','aktif',2,'2026-10-30 13:44:09','2026-11-03 08:09:39'),(4,NULL,NULL,'Salsa Amalia','salsa.demo@curhatin.test',NULL,'+6281100000004',NULL,NULL,'user','aktif',7,'2026-10-30 13:44:09','2026-11-03 08:09:39'),(5,NULL,'$2y$10$GLsBsE4nV.IWN0zCC682d.T30qkc87xGzB1lUOCpZLqwEL1keACeC','Bima Saputra','bima.demo@curhatin.test',NULL,'+6281100000005',NULL,NULL,'user','aktif',1,'2026-10-30 13:44:09','2026-11-04 19:39:25');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `v_admin_pengguna`
--

DROP TABLE IF EXISTS `v_admin_pengguna`;
/*!50001 DROP VIEW IF EXISTS `v_admin_pengguna`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_admin_pengguna` AS SELECT
 1 AS `id_user`,
  1 AS `nama`,
  1 AS `role`,
  1 AS `status`,
  1 AS `created_at` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_statistik_asesmen`
--

DROP TABLE IF EXISTS `v_statistik_asesmen`;
/*!50001 DROP VIEW IF EXISTS `v_statistik_asesmen`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_statistik_asesmen` AS SELECT
 1 AS `bulan`,
  1 AS `id_asesmen`,
  1 AS `jumlah_asesmen`,
  1 AS `jumlah_pengguna` */;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'curhatin'
--

--
-- Dumping routines for database 'curhatin'
--

--
-- Final view structure for view `v_admin_pengguna`
--

/*!50001 DROP VIEW IF EXISTS `v_admin_pengguna`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_admin_pengguna` AS select `users`.`id_user` AS `id_user`,`users`.`nama` AS `nama`,`users`.`role` AS `role`,`users`.`status` AS `status`,`users`.`created_at` AS `created_at` from `users` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_statistik_asesmen`
--

/*!50001 DROP VIEW IF EXISTS `v_statistik_asesmen`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_statistik_asesmen` AS select date_format(`hasil_asesmen`.`tanggal`,'%Y-%m') AS `bulan`,`hasil_asesmen`.`id_asesmen` AS `id_asesmen`,count(0) AS `jumlah_asesmen`,count(distinct `hasil_asesmen`.`id_user`) AS `jumlah_pengguna` from `hasil_asesmen` group by date_format(`hasil_asesmen`.`tanggal`,'%Y-%m'),`hasil_asesmen`.`id_asesmen` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-05 18:22:39
