import { getServerSession } from 'next-auth'
import { prisma } from '@/lib/prisma'
import { redirect } from 'next/navigation'

export default async function DashboardPage() {
  const session = await getServerSession()
  if (!session?.user) redirect('/login')

  // Obtener roles del usuario
  const userRoles = await prisma.userRole.findMany({
    where: { user: { email: session.user.email }, activo: true },
    include: {
      role: true,
      tenant: true,
    },
  })

  return (
    <div className="p-6">
      <h1 className="text-2xl font-bold mb-4">Bienvenido, {session.user.name}</h1>
      <h2 className="text-lg mb-6">Tus instituciones y roles:</h2>
      <div className="grid gap-4">
        {userRoles.map((ur) => (
          <div key={ur.id} className="border p-4 rounded-lg">
            <p><strong>Institución:</strong> {ur.tenant.nombre}</p>
            <p><strong>Rol:</strong> {ur.role.nombre}</p>
          </div>
        ))}
      </div>
    </div>
  )
}