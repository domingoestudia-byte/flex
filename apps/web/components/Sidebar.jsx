"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import {
  Activity,
  Bell,
  Clock,
  Crown,
  HelpCircle,
  Home,
  Music,
  Settings,
  ShoppingBag,
  Ticket,
} from "lucide-react";

const NAV_ITEMS = [
  { icon: Home, label: "Inicio", href: "/" },
  { icon: ShoppingBag, label: "Menu", href: "/menu" },
  { icon: Music, label: "Pedir cancion", href: "/canciones" },
  { icon: Clock, label: "Mi turno", href: "/turno" },
  { icon: Ticket, label: "Mis entradas", href: "/entradas" },
  { icon: Crown, label: "Salas VIP", href: "/vip" },
  { icon: Activity, label: "Actividades", href: "/actividades" },
  { icon: Bell, label: "Notificaciones", href: "/notificaciones" },
  { icon: HelpCircle, label: "Ayuda", href: "/ayuda" },
  { icon: Settings, label: "Configuracion", href: "/configuracion" },
];

export default function Sidebar() {
  const pathname = usePathname();

  return (
    <aside className="hidden w-64 shrink-0 flex-col border-r border-zinc-800 bg-zinc-900 md:flex">
      <div className="border-b border-zinc-800 px-6 py-6">
        <span className="text-2xl font-bold tracking-widest text-gold-400">
          FLEX
        </span>
      </div>

      <nav className="flex-1 space-y-1 px-3 py-4">
        {NAV_ITEMS.map(({ icon: Icon, label, href }) => {
          const activo = pathname === href;

          return (
            <Link
              key={href}
              href={href}
              className={`flex items-center gap-3 rounded-lg px-3 py-2.5 text-sm transition-colors ${
                activo
                  ? "bg-gold-500/20 text-gold-400"
                  : "text-zinc-400 hover:bg-zinc-800 hover:text-zinc-100"
              }`}
            >
              <Icon size={18} />
              {label}
            </Link>
          );
        })}
      </nav>

      <div className="border-t border-zinc-800 px-4 py-4">
        <div className="flex items-center gap-3">
          <div className="flex h-8 w-8 items-center justify-center rounded-full bg-gold-500/30 text-sm font-bold text-gold-400">
            A
          </div>
          <div>
            <p className="text-sm font-medium text-zinc-100">Alex</p>
            <p className="text-xs text-zinc-500">Cliente</p>
          </div>
        </div>
      </div>
    </aside>
  );
}
