'use client'

import { useSession, signOut } from 'next-auth/react'
import { useRouter } from 'next/navigation'

export default function Header({ tenants }: { tenants: any[] }) {
  const { data: session } = useSession()
  const router = useRouter()

  const handleTenantChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
    const tenantId = e.target.value
    document.cookie = `tenantId=${tenantId}; path=/; max-age=86400`
    router.refresh()
  }

  return (
    <header className="bg-white shadow-md px-6 py-4 flex justify-between items-center">
      <div>
        <h2 className="text-lg font-semibold text-gray-800">Panel de control</h2>
      </div>
      <div className="flex items-center gap-4">
        {tenants.length > 1 && (
          <select
            onChange={handleTenantChange}
            className="border rounded px-3 py-1 text-sm"
            defaultValue={tenants[0]?.id}
          >
            {tenants.map((t: any) => (
              <option key={t.id} value={t.id}>
                {t.nombre}
              </option>
            ))}
          </select>
        )}
        <span className="text-sm text-gray-600">{session?.user?.name}</span>
        <button
          onClick={() => signOut({ callbackUrl: '/login' })}
          className="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600 text-sm"
        >
          Salir
        </button>
      </div>
    </header>
  )
}