'use client'

import Link from 'next/link'
import { usePathname } from 'next/navigation'

const menuItems = [
  { href: '/dashboard', label: 'Inicio', icon: '🏠' },
  { href: '/comunicaciones', label: 'Comunicaciones', icon: '📨' },
  { href: '/asistencias', label: 'Asistencias', icon: '📋' },
  { href: '/rite', label: 'RITE', icon: '📚' },
  { href: '/reportes', label: 'Reportes', icon: '📊' },
]

export default function Sidebar() {
  const pathname = usePathname()

  return (
    <aside className="w-64 bg-gray-800 text-white flex flex-col h-full">
      <div className="p-4 border-b border-gray-700">
        <h1 className="text-xl font-bold">AULA</h1>
        <p className="text-xs text-gray-400">Sistema de gestión</p>
      </div>
      <nav className="flex-1 p-4">
        <ul className="space-y-2">
          {menuItems.map((item) => (
            <li key={item.href}>
              <Link
                href={item.href}
                className={`flex items-center gap-3 px-4 py-2 rounded-lg transition ${
                  pathname === item.href
                    ? 'bg-gray-700 text-white'
                    : 'text-gray-300 hover:bg-gray-700 hover:text-white'
                }`}
              >
                <span>{item.icon}</span>
                <span>{item.label}</span>
              </Link>
            </li>
          ))}
        </ul>
      </nav>
      <div className="p-4 border-t border-gray-700 text-sm text-gray-400">
        © 2025 AULA
      </div>
    </aside>
  )
}