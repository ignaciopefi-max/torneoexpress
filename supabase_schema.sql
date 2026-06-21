-- ============================================================
-- Torneos Express — Schema Supabase
-- Ejecutar en: Supabase Dashboard > SQL Editor > New query
-- ============================================================

-- Tabla 1: torneos (un registro por torneo, datos completos como JSONB)
create table if not exists tournaments (
  id         text        primary key,
  data       jsonb       not null,
  updated_at timestamptz not null default now()
);

-- Tabla 2: ranking (un registro por categoría)
create table if not exists ranking (
  category   text        primary key,
  players    jsonb       not null default '[]',
  updated_at timestamptz not null default now()
);

-- Tabla 3: nómina de jugadores conocidos (array completo como JSONB)
create table if not exists players_registry (
  id         text        primary key default 'main',
  data       jsonb       not null default '[]',
  updated_at timestamptz not null default now()
);

-- Tabla 4: inscripciones pendientes (un registro por solicitud)
create table if not exists inscripciones (
  id         text        primary key,
  data       jsonb       not null,
  created_at timestamptz not null default now()
);

-- Tabla 5: demanda por categoría (array completo como JSONB)
create table if not exists demanda (
  id         text        primary key default 'main',
  data       jsonb       not null default '[]',
  updated_at timestamptz not null default now()
);

-- Tabla 6: noticias / novedades (un registro por publicación)
create table if not exists noticias (
  id         text        primary key,
  data       jsonb       not null,
  updated_at timestamptz not null default now()
);

-- Tabla 7: configuración global (video de presentación, ajustes)
create table if not exists app_settings (
  key        text        primary key,
  value      jsonb,
  updated_at timestamptz not null default now()
);

-- ============================================================
-- Row Level Security — acceso completo para la clave anon
-- (la app usa la clave pública sin autenticación de usuarios)
-- ============================================================
alter table tournaments      enable row level security;
alter table ranking          enable row level security;
alter table players_registry enable row level security;
alter table inscripciones    enable row level security;
alter table demanda          enable row level security;
alter table noticias         enable row level security;
alter table app_settings     enable row level security;

create policy "anon_all" on tournaments      for all to anon using (true) with check (true);
create policy "anon_all" on ranking          for all to anon using (true) with check (true);
create policy "anon_all" on players_registry for all to anon using (true) with check (true);
create policy "anon_all" on inscripciones    for all to anon using (true) with check (true);
create policy "anon_all" on demanda          for all to anon using (true) with check (true);
create policy "anon_all" on noticias         for all to anon using (true) with check (true);
create policy "anon_all" on app_settings     for all to anon using (true) with check (true);

-- ============================================================
-- Privilegios de tabla para el rol anon
-- (RLS controla las filas; GRANT controla el acceso a la tabla)
-- ============================================================
grant select, insert, update, delete on public.tournaments      to anon;
grant select, insert, update, delete on public.ranking          to anon;
grant select, insert, update, delete on public.players_registry to anon;
grant select, insert, update, delete on public.inscripciones    to anon;
grant select, insert, update, delete on public.demanda          to anon;
grant select, insert, update, delete on public.noticias         to anon;
grant select, insert, update, delete on public.app_settings     to anon;
