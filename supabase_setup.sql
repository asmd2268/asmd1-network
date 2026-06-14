-- ══════════════════════════════════════════════════
--  ASMD Network Manager — Supabase Schema
--  تشغيل هذا الكود في Supabase SQL Editor
-- ══════════════════════════════════════════════════

-- ── ASMD1: Clients (العملاء) ──────────────────────
CREATE TABLE IF NOT EXISTS asmd1_clients (
  id         BIGSERIAL PRIMARY KEY,
  name       TEXT NOT NULL DEFAULT '',
  ip         TEXT NOT NULL DEFAULT '',
  mac        TEXT NOT NULL DEFAULT '',
  model      TEXT NOT NULL DEFAULT 'Tenda Router',
  type       TEXT NOT NULL DEFAULT 'auto', -- 'auto' | 'static'
  label      TEXT NOT NULL DEFAULT '',
  row_color  TEXT NOT NULL DEFAULT '',
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ── ASMD1: Devices + Passwords (الأجهزة) ─────────
CREATE TABLE IF NOT EXISTS asmd1_devices (
  id         BIGSERIAL PRIMARY KEY,
  n          INTEGER NOT NULL DEFAULT 0,
  name       TEXT NOT NULL DEFAULT '',
  mode       TEXT NOT NULL DEFAULT 'AP',  -- 'AP' | 'STA'
  ssid       TEXT NOT NULL DEFAULT '',
  product    TEXT NOT NULL DEFAULT '',
  ip         TEXT NOT NULL DEFAULT '',
  mac        TEXT NOT NULL DEFAULT '',
  pw         TEXT NOT NULL DEFAULT '',
  row_color  TEXT NOT NULL DEFAULT '',
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ── ASMD2: Clients ────────────────────────────────
CREATE TABLE IF NOT EXISTS asmd2_clients (
  id         BIGSERIAL PRIMARY KEY,
  name       TEXT NOT NULL DEFAULT '',
  ip         TEXT NOT NULL DEFAULT '',
  mac        TEXT NOT NULL DEFAULT '',
  model      TEXT NOT NULL DEFAULT '',
  type       TEXT NOT NULL DEFAULT 'auto',
  label      TEXT NOT NULL DEFAULT '',
  row_color  TEXT NOT NULL DEFAULT '',
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ── ASMD2: Devices ────────────────────────────────
CREATE TABLE IF NOT EXISTS asmd2_devices (
  id         BIGSERIAL PRIMARY KEY,
  name       TEXT NOT NULL DEFAULT '',
  mode       TEXT NOT NULL DEFAULT 'AP',
  ssid       TEXT NOT NULL DEFAULT '',
  product    TEXT NOT NULL DEFAULT '',
  ip         TEXT NOT NULL DEFAULT '',
  mac        TEXT NOT NULL DEFAULT '',
  pw         TEXT NOT NULL DEFAULT '',
  row_color  TEXT NOT NULL DEFAULT '',
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ── ASMD2: Settings (subnet + other config) ───────
CREATE TABLE IF NOT EXISTS asmd2_settings (
  key        TEXT PRIMARY KEY,
  value      TEXT NOT NULL DEFAULT '',
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- تفعيل Realtime على الجداول (اختياري للـ live sync)
ALTER PUBLICATION supabase_realtime ADD TABLE asmd1_clients;
ALTER PUBLICATION supabase_realtime ADD TABLE asmd1_devices;
ALTER PUBLICATION supabase_realtime ADD TABLE asmd2_clients;
ALTER PUBLICATION supabase_realtime ADD TABLE asmd2_devices;

-- ── Row Level Security: اجعل الجداول مفتوحة للقراءة/الكتابة ──
-- (مناسب للاستخدام الشخصي مع كلمة مرور في الواجهة)
ALTER TABLE asmd1_clients  ENABLE ROW LEVEL SECURITY;
ALTER TABLE asmd1_devices  ENABLE ROW LEVEL SECURITY;
ALTER TABLE asmd2_clients  ENABLE ROW LEVEL SECURITY;
ALTER TABLE asmd2_devices  ENABLE ROW LEVEL SECURITY;
ALTER TABLE asmd2_settings ENABLE ROW LEVEL SECURITY;

-- سياسة: السماح لكل العمليات بدون مصادقة (anon key)
CREATE POLICY "allow_all_asmd1_clients"  ON asmd1_clients  FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "allow_all_asmd1_devices"  ON asmd1_devices  FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "allow_all_asmd2_clients"  ON asmd2_clients  FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "allow_all_asmd2_devices"  ON asmd2_devices  FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "allow_all_asmd2_settings" ON asmd2_settings FOR ALL USING (true) WITH CHECK (true);
