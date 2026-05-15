# Arc Network Transaction Monitor 🔍

Aplikasi web real-time untuk memonitor transaksi stablecoin di Arc Network.

![Tech Stack](https://img.shields.io/badge/React-18-61DAFB?logo=react) ![FastAPI](https://img.shields.io/badge/FastAPI-0.111-009688?logo=fastapi) ![TailwindCSS](https://img.shields.io/badge/Tailwind-3-38B2AC?logo=tailwindcss) ![Python](https://img.shields.io/badge/Python-3.9+-3776AB?logo=python)

---

## ✨ Fitur

- **📊 Real-time Dashboard** — Stats jaringan diperbarui setiap 15 detik otomatis
- **🔍 Filter Canggih** — Filter berdasarkan wallet, tipe transaksi, token, status, rentang nilai, stablecoin only
- **📈 Visualisasi Grafik** — Area chart, bar chart harian (7 hari), hourly chart 24 jam, pie chart per token
- **💎 Detail Transaksi** — Klik transaksi untuk lihat detail lengkap dengan modal
- **📋 Copy to Clipboard** — Salin hash/alamat dengan satu klik
- **🔗 Explorer Links** — Link langsung ke Arc Explorer
- **📱 Responsive** — Tampil baik di desktop dan mobile

---

## 🛠 Tech Stack

| Layer | Technology | Fungsi |
|---|---|---|
| Frontend | React 18 + Vite | UI utama |
| Styling | TailwindCSS 3 | Desain responsif |
| Charts | Recharts | Visualisasi data |
| Icons | Lucide React | Icon set |
| Routing | React Router 6 | Navigasi halaman |
| HTTP Client | Axios | Request ke backend |
| Backend | FastAPI (Python) | REST API server |
| Blockchain | Web3.py / httpx | Koneksi Arc RPC |
| Scheduler | APScheduler | Auto-fetch transaksi |
| Server | Uvicorn | ASGI server |

---

## 📁 Struktur Project

```
arc-monitor/
├── backend/
│   ├── main.py              # Entry point FastAPI
│   ├── requirements.txt     # Dependencies Python
│   ├── .env.example         # Template environment variables
│   ├── routes/
│   │   └── transactions.py  # API endpoints
│   ├── services/
│   │   └── arc_service.py   # Logic blockchain & data fetching
│   └── models/
│       └── database.py      # SQLAlchemy models
│
├── frontend/
│   ├── index.html
│   ├── vite.config.js
│   ├── tailwind.config.js
│   ├── package.json
│   └── src/
│       ├── main.jsx          # Entry point React
│       ├── App.jsx           # Root component
│       ├── index.css         # Global styles
│       ├── pages/
│       │   └── Dashboard.jsx # Halaman utama
│       ├── components/
│       │   ├── StatsGrid.jsx      # Kartu statistik
│       │   ├── FilterBar.jsx      # Bar filter transaksi
│       │   ├── TransactionTable.jsx # Tabel transaksi
│       │   ├── Charts.jsx         # Grafik volume
│       │   └── TxDetailModal.jsx  # Modal detail transaksi
│       ├── hooks/
│       │   └── useAutoRefresh.js  # Hook auto-refresh data
│       └── utils/
│           └── api.js             # API calls + helper functions
│
├── setup.sh    # Script instalasi otomatis
└── README.md
```

---

## 🚀 Cara Install & Jalankan

### Prasyarat
- Python 3.9 atau lebih baru
- Node.js 18 atau lebih baru
- npm atau yarn

### Langkah 1: Clone / Download Project

```bash
# Kalau dari git:
git clone <repo-url>
cd arc-monitor

# Atau ekstrak ZIP dan masuk ke folder
```

### Langkah 2: Setup Backend (Python/FastAPI)

```bash
# Masuk ke folder backend
cd backend

# Buat virtual environment (isolasi dependencies Python)
python3 -m venv venv

# Aktifkan virtual environment:
# Linux/Mac:
source venv/bin/activate
# Windows:
venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Salin file environment
cp .env.example .env
```

### Langkah 3: Setup Frontend (React)

```bash
# Masuk ke folder frontend (buka terminal baru!)
cd frontend

# Install dependencies Node.js
npm install
```

### Langkah 4: Jalankan Kedua Server

**Terminal 1 - Backend:**
```bash
cd backend
source venv/bin/activate  # atau venv\Scripts\activate di Windows
python main.py
# ✅ Server berjalan di http://localhost:8000
```

**Terminal 2 - Frontend:**
```bash
cd frontend
npm run dev
# ✅ App berjalan di http://localhost:5173
```

### Langkah 5: Buka di Browser

Buka: **http://localhost:5173**

API Docs (Swagger): **http://localhost:8000/docs**

---

## 🔌 Koneksi ke Arc Network Nyata

Saat ini app menggunakan **mock data** untuk demo. Untuk koneksi ke Arc Network asli:

1. Edit file `backend/.env`:
```env
ARC_RPC_URL=https://rpc.arcnetwork.io      # Ganti dengan RPC Arc Network
ARC_EXPLORER_API=https://explorer.arcnetwork.io/api
```

2. Edit `backend/services/arc_service.py`:
   - Ganti fungsi `generate_mock_transaction()` dengan parsing data dari RPC
   - Fungsi `fetch_latest_transactions()` sudah ada template untuk koneksi nyata

---

## 📡 API Endpoints

| Method | Endpoint | Deskripsi |
|---|---|---|
| GET | `/api/transactions` | List transaksi (dengan filter & pagination) |
| GET | `/api/transactions/{hash}` | Detail satu transaksi |
| GET | `/api/stats` | Statistik jaringan |
| GET | `/api/volume/daily?days=7` | Volume harian |
| GET | `/api/volume/hourly?hours=24` | Volume per jam |
| GET | `/api/wallet/{address}/stats` | Statistik wallet |
| GET | `/api/tokens` | Daftar token |
| GET | `/docs` | Swagger UI (API docs interaktif) |

### Contoh Filter Transaksi:
```
GET /api/transactions?wallet=0x1234...&tx_type=transfer&token=USDT&min_value=1000&limit=50
```

---

## ⚙️ Konfigurasi (.env)

```env
# Arc Network
ARC_RPC_URL=https://rpc.arcnetwork.io
ARC_EXPLORER_API=https://explorer.arcnetwork.io/api

# Database (SQLite default, bisa diganti PostgreSQL)
DATABASE_URL=sqlite+aiosqlite:///./arc_monitor.db

# App
POLL_INTERVAL_SECONDS=15    # Seberapa sering fetch data baru
CORS_ORIGINS=http://localhost:3000,http://localhost:5173
```

---

## 🐛 Troubleshooting

**Backend error "Module not found":**
```bash
# Pastikan virtual environment aktif
source venv/bin/activate
pip install -r requirements.txt
```

**Frontend tidak bisa connect ke backend:**
- Pastikan backend berjalan di port 8000
- Cek `vite.config.js` proxy setting

**Port sudah dipakai:**
```bash
# Ganti port backend di main.py:
uvicorn.run("main:app", host="0.0.0.0", port=8001, reload=True)
```

---

## 🔮 Rencana Pengembangan

- [ ] WebSocket untuk update real-time tanpa polling
- [ ] Notifikasi (alert saat transaksi besar terdeteksi)
- [ ] Export data ke CSV/Excel
- [ ] Halaman profil wallet
- [ ] Dark/light mode toggle
- [ ] Multi-network support
- [ ] Database PostgreSQL untuk production

---

## 📄 Lisensi

MIT License - bebas digunakan dan dimodifikasi.
