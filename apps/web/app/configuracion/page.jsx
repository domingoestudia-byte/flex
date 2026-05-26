"use client";

import { useState } from "react";

import {
  Bell,
  Camera,
  ChevronRight,
  CreditCard,
  Crown,
  Globe,
  Lock,
  MoonStar,
  ShieldCheck,
  Smartphone,
  Sparkles,
  User2,
} from "lucide-react";

export default function ConfiguracionPage() {
  const [pushEnabled, setPushEnabled] = useState(true);
  const [vipMode, setVipMode] = useState(true);
  const [darkMode, setDarkMode] = useState(true);
  const [marketing, setMarketing] = useState(false);

  return (
    <div className="space-y-8 p-6 md:p-8">
      {/* HERO */}
      <section className="relative overflow-hidden rounded-3xl border border-zinc-800 bg-zinc-900">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_right,rgba(212,168,67,0.18),transparent_35%)]" />

        <div className="relative flex flex-col gap-8 p-8 lg:flex-row lg:items-center lg:justify-between">
          <div>
            <div className="mb-3 flex items-center gap-2 text-gold-400">
              <Sparkles size={18} />

              <span className="text-sm font-medium uppercase tracking-[0.2em]">
                Settings Center
              </span>
            </div>

            <h1 className="text-4xl font-black tracking-tight text-white">
              Configuración
            </h1>

            <p className="mt-4 max-w-2xl text-zinc-400">
              Personaliza tu experiencia dentro del club, gestiona tu cuenta y
              controla tus preferencias VIP.
            </p>
          </div>

          <button className="rounded-2xl bg-gold-500 px-6 py-3 text-sm font-semibold text-zinc-950 transition-colors hover:bg-gold-600">
            Guardar cambios
          </button>
        </div>
      </section>

      {/* CONTENT */}
      <div className="grid gap-6 xl:grid-cols-[280px_1fr]">
        {/* SIDEBAR */}
        <aside className="rounded-3xl border border-zinc-800 bg-zinc-900 p-4">
          <nav className="space-y-2">
            <SidebarButton
              icon={User2}
              label="Perfil"
              active
            />

            <SidebarButton
              icon={Bell}
              label="Notificaciones"
            />

            <SidebarButton
              icon={ShieldCheck}
              label="Privacidad"
            />

            <SidebarButton
              icon={CreditCard}
              label="Pagos"
            />

            <SidebarButton
              icon={Lock}
              label="Seguridad"
            />
          </nav>

          {/* VIP CARD */}
          <div className="mt-6 overflow-hidden rounded-2xl border border-gold-500/20 bg-gradient-to-br from-zinc-950 to-zinc-900">
            <div className="p-5">
              <div className="inline-flex rounded-2xl bg-gold-500/10 p-3 text-gold-400">
                <Crown size={22} />
              </div>

              <h3 className="mt-5 text-lg font-bold text-white">
                VIP Access
              </h3>

              <p className="mt-2 text-sm leading-relaxed text-zinc-500">
                Mejora tu experiencia con acceso prioritario y ventajas
                exclusivas.
              </p>

              <button className="mt-5 w-full rounded-xl bg-gold-500 py-3 text-sm font-semibold text-zinc-950 transition-colors hover:bg-gold-600">
                Upgrade VIP
              </button>
            </div>
          </div>
        </aside>

        {/* MAIN */}
        <div className="space-y-6">
          {/* PROFILE */}
          <section className="rounded-3xl border border-zinc-800 bg-zinc-900 p-6">
            <div className="mb-8">
              <div className="mb-2 flex items-center gap-2 text-gold-400">
                <User2 size={18} />

                <span className="text-xs font-semibold uppercase tracking-widest">
                  Perfil
                </span>
              </div>

              <h2 className="text-2xl font-bold text-white">
                Información personal
              </h2>
            </div>

            <div className="flex flex-col gap-8 lg:flex-row">
              {/* AVATAR */}
              <div className="flex flex-col items-center">
                <div className="relative">
                  <div className="flex h-28 w-28 items-center justify-center rounded-full border border-zinc-800 bg-zinc-950 text-3xl font-black text-gold-400">
                    A
                  </div>

                  <button className="absolute bottom-0 right-0 rounded-full bg-gold-500 p-2 text-zinc-950 transition-colors hover:bg-gold-600">
                    <Camera size={16} />
                  </button>
                </div>

                <p className="mt-4 text-sm text-zinc-500">
                  Cambiar foto
                </p>
              </div>

              {/* FORM */}
              <div className="grid flex-1 gap-5 md:grid-cols-2">
                <InputField
                  label="Nombre"
                  defaultValue="Alex"
                />

                <InputField
                  label="Apellidos"
                  defaultValue="Martinez"
                />

                <div className="md:col-span-2">
                  <InputField
                    label="Correo electrónico"
                    defaultValue="alex@email.com"
                  />
                </div>

                <div className="md:col-span-2">
                  <InputField
                    label="Teléfono"
                    defaultValue="+34 600 000 000"
                  />
                </div>
              </div>
            </div>
          </section>

          {/* PREFERENCES */}
          <section className="rounded-3xl border border-zinc-800 bg-zinc-900 p-6">
            <div className="mb-8">
              <div className="mb-2 flex items-center gap-2 text-gold-400">
                <Bell size={18} />

                <span className="text-xs font-semibold uppercase tracking-widest">
                  Preferencias
                </span>
              </div>

              <h2 className="text-2xl font-bold text-white">
                Ajustes de experiencia
              </h2>
            </div>

            <div className="space-y-4">
              <ToggleCard
                icon={Bell}
                title="Notificaciones push"
                description="Recibe alertas sobre pedidos y actividades."
                enabled={pushEnabled}
                onToggle={() => setPushEnabled(!pushEnabled)}
              />

              <ToggleCard
                icon={Crown}
                title="Modo VIP"
                description="Experiencia premium personalizada."
                enabled={vipMode}
                onToggle={() => setVipMode(!vipMode)}
              />

              <ToggleCard
                icon={MoonStar}
                title="Modo oscuro"
                description="Mantener apariencia dark premium."
                enabled={darkMode}
                onToggle={() => setDarkMode(!darkMode)}
              />

              <ToggleCard
                icon={Smartphone}
                title="Promociones y eventos"
                description="Recibir novedades y promociones especiales."
                enabled={marketing}
                onToggle={() => setMarketing(!marketing)}
              />
            </div>
          </section>

          {/* SECURITY */}
          <section className="overflow-hidden rounded-3xl border border-zinc-800 bg-zinc-900">
            <div className="relative">
              <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_right,rgba(212,168,67,0.14),transparent_35%)]" />

              <div className="relative p-6">
                <div className="mb-8">
                  <div className="mb-2 flex items-center gap-2 text-gold-400">
                    <ShieldCheck size={18} />

                    <span className="text-xs font-semibold uppercase tracking-widest">
                      Seguridad
                    </span>
                  </div>

                  <h2 className="text-2xl font-bold text-white">
                    Protección de cuenta
                  </h2>
                </div>

                <div className="grid gap-4 md:grid-cols-2">
                  <SecurityCard
                    title="Cambiar contraseña"
                    description="Actualiza tu contraseña periódicamente."
                    button="Actualizar"
                  />

                  <SecurityCard
                    title="Autenticación 2FA"
                    description="Añade una capa extra de seguridad."
                    button="Activar"
                    primary
                  />
                </div>
              </div>
            </div>
          </section>

          {/* EXTRA */}
          <section className="rounded-3xl border border-zinc-800 bg-zinc-900 p-6">
            <div className="mb-8">
              <div className="mb-2 flex items-center gap-2 text-gold-400">
                <Globe size={18} />

                <span className="text-xs font-semibold uppercase tracking-widest">
                  General
                </span>
              </div>

              <h2 className="text-2xl font-bold text-white">
                Configuración general
              </h2>
            </div>

            <div className="space-y-4">
              <ActionRow label="Idioma">
                Español
              </ActionRow>

              <ActionRow label="Zona horaria">
                Madrid (GMT+1)
              </ActionRow>

              <ActionRow label="Eliminar cuenta" danger>
                Solicitar
              </ActionRow>
            </div>
          </section>
        </div>
      </div>
    </div>
  );
}

function SidebarButton({
  icon: Icon,
  label,
  active = false,
}) {
  return (
    <button
      className={`flex w-full items-center gap-3 rounded-2xl px-4 py-3 text-left transition-colors ${
        active
          ? "bg-gold-500 text-zinc-950"
          : "text-zinc-400 hover:bg-zinc-800 hover:text-white"
      }`}
    >
      <Icon size={18} />

      <span className="font-medium">
        {label}
      </span>
    </button>
  );
}

function InputField({
  label,
  defaultValue,
}) {
  return (
    <div>
      <label className="mb-2 block text-sm font-medium text-zinc-400">
        {label}
      </label>

      <input
        defaultValue={defaultValue}
        className="h-12 w-full rounded-2xl border border-zinc-800 bg-zinc-950 px-4 text-sm text-white outline-none transition-colors placeholder:text-zinc-500 focus:border-gold-500"
      />
    </div>
  );
}

function ToggleCard({
  icon: Icon,
  title,
  description,
  enabled,
  onToggle,
}) {
  return (
    <article className="flex items-center justify-between gap-4 rounded-2xl border border-zinc-800 bg-zinc-950 p-5">
      <div className="flex items-start gap-4">
        <div className="rounded-2xl bg-gold-500/10 p-3 text-gold-400">
          <Icon size={20} />
        </div>

        <div>
          <h3 className="font-semibold text-white">
            {title}
          </h3>

          <p className="mt-2 max-w-xl text-sm leading-relaxed text-zinc-500">
            {description}
          </p>
        </div>
      </div>

      <button
        onClick={onToggle}
        className={`relative h-7 w-14 rounded-full transition-colors ${
          enabled ? "bg-gold-500" : "bg-zinc-700"
        }`}
      >
        <div
          className={`absolute top-1 h-5 w-5 rounded-full bg-white transition-all ${
            enabled ? "left-8" : "left-1"
          }`}
        />
      </button>
    </article>
  );
}

function SecurityCard({
  title,
  description,
  button,
  primary = false,
}) {
  return (
    <article className="rounded-2xl border border-zinc-800 bg-zinc-950 p-5">
      <h3 className="font-semibold text-white">
        {title}
      </h3>

      <p className="mt-2 text-sm leading-relaxed text-zinc-500">
        {description}
      </p>

      <button
        className={`mt-5 rounded-xl px-4 py-2 text-sm font-semibold transition-colors ${
          primary
            ? "bg-gold-500 text-zinc-950 hover:bg-gold-600"
            : "border border-zinc-700 text-zinc-300 hover:bg-zinc-800"
        }`}
      >
        {button}
      </button>
    </article>
  );
}

function ActionRow({
  label,
  children,
  danger = false,
}) {
  return (
    <div className="flex items-center justify-between rounded-2xl border border-zinc-800 bg-zinc-950 p-5">
      <span className="font-medium text-white">
        {label}
      </span>

      <button
        className={`flex items-center gap-2 text-sm font-medium transition-colors ${
          danger
            ? "text-red-400 hover:text-red-300"
            : "text-gold-400 hover:text-gold-300"
        }`}
      >
        {children}

        <ChevronRight size={16} />
      </button>
    </div>
  );
}