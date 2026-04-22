// lib/models/quiz_data.dart

class Question {
  final int id;
  final String question;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}

class Module {
  final int id;
  final String title;
  final String description;
  final List<Question> questions;

  Module({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
  });
}

// Quiz data for all 7 modules
final List<Module> quizModules = [
  Module(
    id: 1,
    title: 'Penjelasan Umum Desa Cantik',
    description: 'Materi dasar tentang Program Desa Cantik',
    questions: [
      Question(
        id: 1,
        question: 'Apa tujuan utama Program Desa Cantik tahun 2025?',
        options: [
          'Meningkatkan jumlah desa wisata',
          'Meningkatkan literasi dan peran aktif perangkat desa dalam kegiatan statistik',
          'Mengembangkan ekonomi kreatif di desa',
          'Mengurangi jumlah aplikasi pendataan desa',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 2,
        question:
            'Undang-undang apa yang menjadi dasar BPS menjalankan fungsi pembinaan statistik?',
        options: [
          'UU No. 6 Tahun 2014',
          'UU No. 23 Tahun 2019',
          'UU No. 16 Tahun 1997',
          'UU No. 12 Tahun 2011',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 3,
        question: 'Salah satu latar belakang Program Desa Cantik adalah…',
        options: [
          'Jumlah desa yang semakin berkurang',
          'Banyaknya aplikasi pendataan di desa namun SDM pengelola datanya masih rendah',
          'Berkurangnya peran pemerintah pusat',
          'Desa tidak memiliki akses internet',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 4,
        question: 'Output utama untuk predikat Desa Cantik berikut kecuali…',
        options: [
          'Monografi/Profil Desa',
          'Publikasi Statistik',
          'Website dengan data/statistik',
          'Video promosi desa',
        ],
        correctAnswer: 'D',
      ),
      Question(
        id: 5,
        question:
            'Agen Statistik di Desa/Kelurahan minimal harus berasal dari…',
        options: [
          'Ketua RT',
          'Aparat desa/kelurahan',
          'Tokoh masyarakat',
          'Pengurus BUMDes',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 6,
        question: 'Salah satu manfaat dari pembinaan Desa Cantik adalah…',
        options: [
          'Peningkatan jumlah sekolah di desa',
          'Peningkatan kapabilitas statistik desa',
          'Penambahan anggaran desa',
          'Pengurangan aplikasi desa',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 7,
        question:
            'Kriteria desa yang dapat diusulkan sebagai Desa Cantik adalah berikut, kecuali…',
        options: [
          'Belum pernah diusulkan sebelumnya',
          'Memiliki akses internet yang sangat baik',
          'Memiliki minimal 10 agen statistik',
          'Memiliki komputer/laptop di kantor desa',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 8,
        question:
            'Pembinaan statistik pada Program Desa Cantik mengikuti kerangka…',
        options: ['SPM Desa', 'SDGs Desa', 'GSBPM', 'RPJMDes'],
        correctAnswer: 'C',
      ),
      Question(
        id: 9,
        question: 'Salah satu materi dalam kurikulum Desa Cantik adalah…',
        options: [
          'Pengembangan wisata desa',
          'Tata kelola data dan sistem informasi desa',
          'Pembangunan infrastruktur desa',
          'Manajemen keuangan desa',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 10,
        question: 'Desa Cantik terbaik ditetapkan melalui…',
        options: [
          'Musyawarah desa',
          'Rekomendasi camat',
          'Dashboard monitoring Desa Cantik',
          'Penilaian dari BUMDes',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 11,
        question:
            'Siapa pihak yang menetapkan Desa/Kelurahan sebagai Desa Cantik?',
        options: [
          'Camat',
          'Kepala Desa',
          'Kepala BPS melalui Kepka BPS',
          'Kementerian Desa',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 12,
        question:
            'Salah satu peran Kepala Desa/Lurah dalam Program Desa Cantik adalah…',
        options: [
          'Menyusun dashboard monitoring',
          'Membuat laporan statistik nasional',
          'Mendukung kegiatan pembinaan dan menunjuk agen statistik',
          'Melakukan analisis data tingkat kabupaten',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 13,
        question: 'Analisis data dalam kurikulum Desa Cantik umumnya berupa…',
        options: [
          'Analisis regresi lanjutan',
          'Analisis deskriptif data desa',
          'Analisis ekonomi makro',
          'Analisis prediksi iklim',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 14,
        question: 'Tujuan manajemen kualitas data dalam Desa Cantik adalah…',
        options: [
          'Menghilangkan kebutuhan akan survei',
          'Menjamin kualitas data desa yang sederhana dan dapat diterapkan',
          'Mengurangi jumlah komputer yang digunakan',
          'Menghapus aplikasi pendataan desa',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 15,
        question: 'Pembentukan agen statistik dilakukan melalui…',
        options: [
          'Peraturan desa',
          'SK Kepala Desa/Lurah',
          'Keputusan BPS Provinsi',
          'Forum Musrenbang Desa',
        ],
        correctAnswer: 'B',
      ),
    ],
  ),
  Module(
    id: 2,
    title: 'Penyelenggaraan Kegiatan Statistik',
    description: 'Memahami sistem dan kegiatan statistik nasional',
    questions: [
      Question(
        id: 1,
        question: 'Apa yang dimaksud dengan Sistem Statistik Nasional (SSN)?',
        options: [
          'Tatanan unsur kebutuhan data, SDM, metode, sarana prasarana, IPTEK, hukum, dan masukan FMS yang saling berkaitan',
          'Sistem pendataan desa',
          'Sistem keuangan negara',
          'Database sensus nasional',
        ],
        correctAnswer: 'A',
      ),
      Question(
        id: 2,
        question: 'Tujuan utama pengembangan SSN adalah…',
        options: [
          'Meningkatkan kualitas dan keterbandingan data',
          'Mengurangi jumlah penduduk',
          'Meningkatkan pajak',
          'Membatasi akses data',
        ],
        correctAnswer: 'A',
      ),
      Question(
        id: 3,
        question: 'Desa Cantik berperan dalam…',
        options: [
          'Meningkatkan literasi dan peran aktif perangkat desa dalam statistik',
          'Meningkatkan jumlah sensus',
          'Menghapus data lama',
          'Menurunkan standar statistik',
        ],
        correctAnswer: 'A',
      ),
      Question(
        id: 4,
        question: 'Data merupakan…',
        options: [
          'Informasi mentah yang belum diolah',
          'Hasil analisis data',
          'Grafik dan tabel',
          'Kesimpulan penelitian',
        ],
        correctAnswer: 'A',
      ),
      Question(
        id: 5,
        question: 'Statistik merupakan…',
        options: [
          'Hasil pengolahan data dalam bentuk nilai, tabel, atau grafik',
          'Catatan mentah individu',
          'Informasi tanpa proses',
          'Pendapat ahli',
        ],
        correctAnswer: 'A',
      ),
      Question(
        id: 6,
        question: 'Kegiatan statistik bertujuan untuk…',
        options: [
          'Menyediakan data akurat, lengkap, mutakhir untuk pembangunan',
          'Menghasilkan opini publik',
          'Mengurangi jumlah data',
          'Menghapus arsip',
        ],
        correctAnswer: 'A',
      ),
      Question(
        id: 7,
        question: 'Statistik Sektoral digunakan untuk…',
        options: [
          'Memenuhi kebutuhan instansi tertentu',
          'Seluruh masyarakat luas',
          'Kepentingan bisnis semata',
          'Kepentingan pribadi',
        ],
        correctAnswer: 'A',
      ),
      Question(
        id: 8,
        question: 'Sensus adalah…',
        options: [
          'Pencacahan semua unit populasi',
          'Pencacahan sampel saja',
          'Pengolahan data administratif',
          'Penghitungan big data',
        ],
        correctAnswer: 'A',
      ),
      Question(
        id: 9,
        question: 'Survei merupakan…',
        options: [
          'Pencacahan sampel untuk memperkirakan populasi',
          'Pencacahan seluruh populasi',
          'Data dari administrasi',
          'Observasi nonformal',
        ],
        correctAnswer: 'A',
      ),
      Question(
        id: 10,
        question: 'Tahapan pertama GSBPM adalah…',
        options: ['Specify Needs', 'Design', 'Build', 'Collect'],
        correctAnswer: 'A',
      ),
      Question(
        id: 11,
        question: 'Interoperabilitas data bertujuan untuk…',
        options: [
          'Memungkinkan berbagi data antar sistem elektronik',
          'Menghapus data lama',
          'Mengurangi ukuran file',
          'Membatasi akses publik',
        ],
        correctAnswer: 'A',
      ),
      Question(
        id: 12,
        question: 'Metadata adalah…',
        options: [
          'Data tentang data',
          'Data mentah',
          'Grafik statistik',
          'Data rahasia',
        ],
        correctAnswer: 'A',
      ),
      Question(
        id: 13,
        question: 'Kode referensi adalah…',
        options: [
          'Tanda unik sebagai identitas data',
          'Kode rahasia akses file',
          'Format penyimpanan data',
          'Nama variabel',
        ],
        correctAnswer: 'A',
      ),
      Question(
        id: 14,
        question: 'SOP pada tahap Build disusun untuk…',
        options: [
          'Standarisasi proses produksi statistik',
          'Mengatur jam kerja',
          'Menghapus duplikasi file',
          'Membatasi akses metadata',
        ],
        correctAnswer: 'A',
      ),
      Question(
        id: 15,
        question: 'Diseminasi dalam statistik adalah…',
        options: [
          'Penyebarluasan output statistik',
          'Pengumpulan data',
          'Pengolahan data mentah',
          'Pembentukan variabel',
        ],
        correctAnswer: 'A',
      ),
    ],
  ),
  Module(
    id: 3,
    title: 'Pengumpulan Data',
    description: 'Teknik dan metode pengumpulan data',
    questions: [
      Question(
        id: 1,
        question: 'Data yang baik harus…',
        options: [
          'Diperoleh dari internet',
          'Sesuai dengan keadaan sebenarnya',
          'Selalu berupa angka',
          'Selalu bersumber dari survei',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 2,
        question:
            'Data yang dikumpulkan sendiri secara langsung dari objek penelitian disebut…',
        options: ['Sekunder', 'Primer', 'Tersier', 'Arsip'],
        correctAnswer: 'B',
      ),
      Question(
        id: 3,
        question: 'Contoh data sekunder adalah…',
        options: [
          'Hasil wawancara langsung',
          'Hasil observasi lapangan',
          'Data wabah dari Puskesmas',
          'Catatan pengukuran di lapangan',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 4,
        question:
            'Survei Sosial Ekonomi Nasional (Susenas) termasuk dalam cara pengumpulan data…',
        options: ['Sensus', 'Survei', 'Observasi', 'Dokumentasi'],
        correctAnswer: 'B',
      ),
      Question(
        id: 5,
        question:
            'Teknik pengumpulan data melalui pengamatan langsung disebut…',
        options: ['Dokumenter', 'Komunikasi', 'Observasi', 'Sosiometri'],
        correctAnswer: 'C',
      ),
      Question(
        id: 6,
        question:
            'Observasi yang dilakukan tanpa berada di lokasi saat kejadian disebut…',
        options: [
          'Observasi langsung',
          'Observasi tidak langsung',
          'Observasi murni',
          'Observasi fisik',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 7,
        question: 'Wawancara tatap muka termasuk teknik…',
        options: [
          'Observasi',
          'Komunikasi langsung',
          'Dokumentasi',
          'Sosiometri',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 8,
        question: 'Penggunaan angket/kuesioner termasuk komunikasi…',
        options: ['Langsung', 'Tidak langsung', 'Semi langsung', 'Observatif'],
        correctAnswer: 'B',
      ),
      Question(
        id: 9,
        question:
            'Teknik yang digunakan untuk mempelajari hubungan antar individu dalam kelompok adalah…',
        options: ['Observasi', 'Pengukuran', 'Sosiometri', 'Dokumenter'],
        correctAnswer: 'C',
      ),
      Question(
        id: 10,
        question:
            'Dokumen yang ditulis langsung oleh pelaku peristiwa disebut…',
        options: [
          'Data primer',
          'Dokumen primer',
          'Dokumen sekunder',
          'Data tidak langsung',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 11,
        question: 'Instrumen pengumpulan data berfungsi untuk…',
        options: [
          'Memperumit proses wawancara',
          'Mengurangi kebutuhan pencatatan',
          'Memperoleh informasi terstruktur dan akurat',
          'Menghilangkan kesalahan data',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 12,
        question: 'Contoh instrumen untuk metode observasi adalah…',
        options: ['Sosiogram', 'Angket', 'Ceklis', 'Tes darah'],
        correctAnswer: 'C',
      ),
      Question(
        id: 13,
        question: 'Tahapan perancangan pengumpulan data dimulai dengan…',
        options: [
          'Merancang sistem alur kerja',
          'Merancang deskripsi variabel',
          'Menentukan petugas lapangan',
          'Menyusun laporan',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 14,
        question:
            'Pada Program Desa Cantik, salah satu kuesioner yang digunakan adalah…',
        options: [
          'Sensus Penduduk',
          'SDDI.Kewilayahan',
          'PODES Ekonomi',
          'SAK',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 15,
        question:
            'Sebelum mengumpulkan data di desa/kelurahan, perlu dikonfirmasi terkait…',
        options: [
          'Cuaca dan jarak desa',
          'Sumber daya yang diperlukan',
          'Jumlah penduduk',
          'Nama kepala desa',
        ],
        correctAnswer: 'B',
      ),
    ],
  ),
  Module(
    id: 4,
    title: 'Pengolahan Data',
    description: 'Proses dan teknik pengolahan data',
    questions: [
      Question(
        id: 1,
        question: 'Apa perbedaan utama antara data dan informasi?',
        options: [
          'Data bersifat terstruktur, informasi tidak',
          'Data sudah dianalisis, informasi belum',
          'Data mentah belum diproses, informasi sudah diolah',
          'Data digunakan untuk keputusan, informasi tidak',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 2,
        question:
            'Moda pengumpulan data yang menggunakan kertas dan pensil adalah…',
        options: ['CAPI', 'CATI', 'CAWI', 'PAPI'],
        correctAnswer: 'D',
      ),
      Question(
        id: 3,
        question: 'Perangkat apa yang digunakan dalam metode CAPI?',
        options: [
          'Telepon',
          'Komputer',
          'Kertas dan pensil',
          'Gadget seperti handphone atau tablet',
        ],
        correctAnswer: 'D',
      ),
      Question(
        id: 4,
        question: 'Kelebihan CAWI adalah…',
        options: [
          'Tidak membutuhkan internet',
          'Responden dapat mengisi kapan saja dan di mana saja',
          'Tidak memerlukan literasi teknologi',
          'Hanya dapat dilakukan tatap muka',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 5,
        question: 'Moda CATI dilakukan dengan cara…',
        options: [
          'Responden mengisi kuesioner online',
          'Wawancara langsung menggunakan gadget',
          'Wawancara melalui telepon',
          'Pengisian menggunakan kertas',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 6,
        question: 'Salah satu tujuan penyiapan data adalah…',
        options: [
          'Menghapus data yang tidak penting',
          'Menggabungkan data dari berbagai sumber',
          'Mengolah data menjadi grafik',
          'Memberikan kode pada data',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 7,
        question: 'Penerimaan data dari petugas lapangan termasuk dalam tahap…',
        options: [
          'Klasifikasi data',
          'Pemeriksaan data',
          'Penyiapan data',
          'Validasi data',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 8,
        question: 'Klasifikasi data dilakukan untuk…',
        options: [
          'Menghapus data ganda',
          'Mengelompokkan data berdasarkan persamaan',
          'Menghitung total data',
          'Mengubah format data',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 9,
        question: 'Berikut yang termasuk kegiatan klasifikasi data adalah…',
        options: [
          'Menerima data dari petugas',
          'Menyusun dokumen agar mudah dicari',
          'Memeriksa kelengkapan isian',
          'Melakukan entri data',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 10,
        question: 'Pemeriksaan kelengkapan isian termasuk dalam tahap…',
        options: [
          'Penyiapan data',
          'Klasifikasi data',
          'Pemeriksaan dan pengkodean data',
          'Validasi data',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 11,
        question: 'Pemeriksaan konsistensi isian dilakukan untuk…',
        options: [
          'Memastikan data sesuai tipe data',
          'Memastikan logika antarjawaban benar',
          'Memastikan dokumen tertata',
          'Mengubah format data',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 12,
        question: 'Data entri adalah proses…',
        options: [
          'Menghapus data duplikat',
          'Memasukkan data ke dalam sistem komputer',
          'Mengelompokkan data',
          'Mengubah data menjadi grafik',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 13,
        question: 'Yang bukan merupakan sumber input data entri adalah…',
        options: ['Keyboard', 'Scanner', 'Kamera', 'Hard disk'],
        correctAnswer: 'D',
      ),
      Question(
        id: 14,
        question: 'Validasi data bertujuan untuk…',
        options: [
          'Mengubah format data',
          'Mengurangi jumlah data',
          'Memastikan kualitas, akurasi, dan keandalan data',
          'Menyimpan data',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 15,
        question: 'Contoh validasi rentang adalah…',
        options: [
          'Mengecek apakah umur berada antara 18–98',
          'Mengecek format tanggal',
          'Memastikan data numerik tidak berisi teks',
          'Memastikan konsistensi pendidikan dan umur',
        ],
        correctAnswer: 'A',
      ),
    ],
  ),
  Module(
    id: 5,
    title: 'Analisis Data',
    description: 'Teknik analisis dan interpretasi data statistik',
    questions: [
      Question(
        id: 1,
        question: 'Analisis data didefinisikan sebagai…',
        options: [
          'Upaya meningkatkan jumlah data',
          'Upaya mengolah data menjadi informasi',
          'Upaya mengumpulkan data sebanyak mungkin',
          'Upaya memvisualisasikan data saja',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 2,
        question: 'Statistik deskriptif digunakan untuk…',
        options: [
          'Memprediksi kejadian di masa depan',
          'Menguji hipotesis',
          'Menggambarkan fenomena suatu variabel',
          'Membuat model regresi',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 3,
        question: 'Tahapan analisis menurut GSBPM yang pertama adalah…',
        options: [
          'Validasi Output',
          'Interpretasi Output',
          'Menyiapkan Naskah Output',
          'Penyajian Data',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 4,
        question: 'Validasi output dilakukan untuk…',
        options: [
          'Menambah jumlah data',
          'Memeriksa kualitas data tabulasi',
          'Menghapus variabel yang tidak perlu',
          'Membuat grafik',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 5,
        question: 'Contoh penerapan disclosure control adalah…',
        options: [
          'Menambah ukuran sampel',
          'Menghapus semua data',
          'Tidak menyajikan data penerima bansos pada level RT/RW',
          'Mengganti data mentah dengan data palsu',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 6,
        question: 'Jenis data dengan kategori tanpa tingkatan adalah…',
        options: ['Ordinal', 'Rasio', 'Interval', 'Nominal'],
        correctAnswer: 'D',
      ),
      Question(
        id: 7,
        question: 'Data ordinal memiliki ciri…',
        options: [
          'Tidak dapat diurutkan',
          'Berupa angka dengan nol mutlak',
          'Kategorinya memiliki tingkatan',
          'Tidak dapat dihitung frekuensinya',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 8,
        question: 'Data rasio ditandai dengan…',
        options: [
          'Tidak memiliki nol mutlak',
          'Memiliki nol mutlak dan dapat diurutkan',
          'Hanya berupa kategori',
          'Nilai skalanya acak',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 9,
        question: 'Modus adalah…',
        options: [
          'Rata-rata nilai',
          'Nilai tengah',
          'Nilai yang paling sering muncul',
          'Nilai selisih terbesar dan terkecil',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 10,
        question: 'Rumus Sturges digunakan untuk menentukan…',
        options: [
          'Mean',
          'Banyak kelas (K) pada distribusi frekuensi interval',
          'Median',
          'Modus',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 11,
        question: 'Standar deviasi berfungsi untuk mengukur…',
        options: [
          'Pemusatan data',
          'Penyebaran data',
          'Nilai maksimum',
          'Nilai minimum',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 12,
        question: 'Tabel satu arah menyajikan informasi berdasarkan…',
        options: [
          'Dua karakteristik',
          'Tiga karakteristik',
          'Satu karakteristik',
          'Tidak memiliki karakteristik',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 13,
        question: 'Tabel dua arah digunakan untuk…',
        options: [
          'Merinci data menurut tiga variabel',
          'Menyajikan data tanpa tabulasi',
          'Merinci data menurut dua karakteristik',
          'Menghapus variabel tertentu',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 14,
        question: 'Visualisasi tabel satu arah yang umum adalah…',
        options: [
          'Pie chart atau bar chart',
          'Scatter plot',
          'Heatmap',
          'Radar chart',
        ],
        correctAnswer: 'A',
      ),
      Question(
        id: 15,
        question: 'Interpretasi output membutuhkan…',
        options: [
          'Penghapusan data',
          'Pemahaman konsep statistik terkait',
          'Pengumpulan ulang data',
          'Pengurangan jumlah variabel',
        ],
        correctAnswer: 'B',
      ),
    ],
  ),
  Module(
    id: 6,
    title: 'Penyajian Data',
    description: 'Cara menyajikan data melalui tabel dan grafik',
    questions: [
      Question(
        id: 1,
        question: 'Apa definisi tabel dalam penyajian data?',
        options: [
          'Grafik yang menggambarkan perkembangan data',
          'Cara penyajian data berupa angka-angka dalam baris dan kolom',
          'Diagram untuk menunjukkan persentase',
          'Bentuk visualisasi seperti gambar',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 2,
        question: 'Salah satu tujuan penyajian tabel adalah…',
        options: [
          'Mengurangi ukuran data',
          'Membuat data menjadi bergerak',
          'Memudahkan analisis data',
          'Menghilangkan angka',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 3,
        question:
            'Komponen tabel berikut bukan termasuk komponen utama adalah…',
        options: [
          'Judul kolom',
          'Sumber dan catatan',
          'Nomor tabel',
          'Warna background',
        ],
        correctAnswer: 'D',
      ),
      Question(
        id: 4,
        question: 'Tabel yang hanya menjelaskan satu karakteristik disebut…',
        options: [
          'Tabel dua arah',
          'Tabel tiga arah',
          'Tabel satu arah',
          'Tabel komparatif',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 5,
        question: 'Grafik digunakan untuk…',
        options: [
          'Menghapus angka agar lebih ringkas',
          'Menyajikan data visual agar mudah dipahami',
          'Mengganti semua tabel',
          'Menghilangkan perbedaan kategori',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 6,
        question: 'Keunggulan penyajian grafik adalah…',
        options: [
          'Kurang menarik secara visual',
          'Lebih sulit dipahami',
          'Lebih efektif menggambarkan perkembangan waktu',
          'Mengurangi ketepatan angka',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 7,
        question: 'Grafik garis tunggal digunakan untuk…',
        options: [
          'Perbandingan banyak kategori',
          'Perkembangan satu jenis data',
          'Menampilkan peta',
          'Menampilkan proporsi persentase',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 8,
        question: 'Grafik batang digunakan untuk…',
        options: [
          'Menunjukkan lokasi geografis',
          'Menampilkan perkembangan kontinu',
          'Membandingkan antar kategori data',
          'Menampilkan audio visual',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 9,
        question: 'Diagram lingkaran lebih tepat digunakan untuk…',
        options: [
          'Menggambarkan nilai mutlak',
          'Menampilkan persentase per kategori',
          'Menampilkan tren waktu',
          'Menampilkan data kumulatif',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 10,
        question: 'Pictogram (diagram gambar) digunakan untuk…',
        options: [
          'Menampilkan hubungan rumit antar variabel',
          'Memberikan gambaran kasar yang mudah dipahami',
          'Menampilkan peta wilayah',
          'Menampilkan audio-video',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 11,
        question: 'Diagram peta (cartogram) digunakan untuk…',
        options: [
          'Menunjukkan perbandingan presentase',
          'Menunjukkan lokasi dan distribusi geografis data',
          'Menampilkan tren dari tahun ke tahun',
          'Menggambarkan grafik komponen',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 12,
        question: 'Infografis merupakan gabungan antara…',
        options: [
          'Teks dan animasi',
          'Data dan narasi',
          'Informasi dan grafik',
          'Suara dan teks',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 13,
        question: 'Salah satu keunggulan infografis adalah…',
        options: [
          'Menghilangkan kebutuhan data',
          'Membuat pembaca lebih cepat memahami informasi',
          'Mengurangi visualisasi',
          'Mengharuskan animasi',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 14,
        question: 'Infografis dinamis ditampilkan melalui…',
        options: [
          'Koran dan majalah',
          'Media sosial berbasis gambar',
          'Televisi atau YouTube',
          'Buku cetak',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 15,
        question: 'Komponen publikasi BPS bukan termasuk…',
        options: [
          'Cover depan',
          'Halaman isi',
          'Cover belakang',
          'Curriculum vitae penulis',
        ],
        correctAnswer: 'D',
      ),
    ],
  ),
  Module(
    id: 7,
    title: 'Manajemen Kualitas Data',
    description: 'Menjamin kualitas dan keandalan data',
    questions: [
      Question(
        id: 1,
        question: 'Apa definisi data menurut dokumen?',
        options: [
          'Hasil pengolahan informasi',
          'Fakta mentah yang belum diolah',
          'Kumpulan opini masyarakat',
          'Informasi berbasis angka',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 2,
        question: 'Informasi adalah…',
        options: [
          'Fakta mentah yang belum diproses',
          'Hasil pengolahan data agar lebih mudah dipahami',
          'Data yang selalu berbentuk angka',
          'Kesimpulan akhir dari statistik',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 3,
        question: 'Semua statistik adalah informasi, tetapi…',
        options: [
          'Semua informasi adalah statistik',
          'Tidak semua informasi adalah statistik',
          'Statistik tidak selalu berbasis angka',
          'Statistik adalah opini',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 4,
        question: '"Quality is user satisfaction" berarti…',
        options: [
          'Data harus mahal',
          'Data harus teknis',
          'Kualitas ditentukan oleh pemenuhan kebutuhan pengguna',
          'Kualitas ditentukan oleh petugas',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 5,
        question: 'Salah satu manfaat kualitas data yang baik adalah…',
        options: [
          'Meningkatkan biaya operasional',
          'Menurunkan kepercayaan publik',
          'Keputusan lebih tepat dan efektif',
          'Menghambat proses kerja',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 6,
        question: 'Siklus PDCA terdiri dari tahapan berikut, kecuali…',
        options: ['Plan', 'Do', 'Control', 'Act'],
        correctAnswer: 'C',
      ),
      Question(
        id: 7,
        question: 'Fokus utama manajemen kualitas adalah…',
        options: [
          'Menurunkan biaya statistik',
          'Memenuhi kebutuhan pengguna data',
          'Meningkatkan jumlah petugas',
          'Memperbanyak survei',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 8,
        question: 'Relevansi sebagai prinsip kualitas berarti…',
        options: [
          'Data mudah diakses',
          'Data sesuai kebutuhan pengguna',
          'Data disajikan cepat',
          'Data harus berbentuk diagram',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 9,
        question: 'Akurasi dalam statistik adalah…',
        options: [
          'Data disajikan tepat waktu',
          'Data sesuai kondisi sebenarnya',
          'Data mudah dipahami',
          'Data memiliki banyak angka',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 10,
        question: 'Koherensi berarti…',
        options: [
          'Data harus sama setiap tahun',
          'Data harus selaras dengan data lain',
          'Data hanya berasal dari satu sumber',
          'Data harus berbentuk tabel',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 11,
        question: 'Salah satu kesalahan responden adalah…',
        options: [
          'Salah input data',
          'Tidak memahami pertanyaan',
          'Tidak memeriksa data',
          'Menggandakan dokumen',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 12,
        question: 'Kesalahan petugas pengumpulan data terjadi jika…',
        options: [
          'Responden menolak',
          'Petugas tidak memahami konsep data',
          'Responden tidak hadir',
          'Data sudah benar',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 13,
        question: 'Pada tahap perencanaan, salah satu kegiatan adalah…',
        options: [
          'Pengecekan lapangan',
          'Penyiapan instrumen pengumpulan data',
          'Analisis koherensi',
          'Publikasi laporan',
        ],
        correctAnswer: 'B',
      ),
      Question(
        id: 14,
        question:
            'Pada tahap pengolahan data, penggunaan teknologi bertujuan untuk…',
        options: [
          'Membuat survei lebih lama',
          'Memperumit proses kerja',
          'Memudahkan proses pengolahan data',
          'Mengurangi jumlah petugas',
        ],
        correctAnswer: 'C',
      ),
      Question(
        id: 15,
        question: 'Tujuan evaluasi dalam penjaminan kualitas adalah…',
        options: [
          'Mengulangi proses tanpa perubahan',
          'Menentukan siapa yang salah',
          'Mengidentifikasi area perbaikan',
          'Menghapus data lama',
        ],
        correctAnswer: 'C',
      ),
    ],
  ),
];
