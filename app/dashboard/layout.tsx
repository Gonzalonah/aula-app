import { getServerSession } from 'next-auth'
import { prisma } from '@/lib/prisma'
import { redirect } from 'next/navigation'
import Sidebar from '@/components/Sidebar'
import Header from '@/components/Header'

export default async function DashboardLayout({
  children,
}: {
  children: React.ReactNode
}) {
  const session = await getServerSession()
  if (!session?.user) redirect('/login')

  const userRoles = await prisma.userRole.findMany({
    where: { user: { email: session.user.email }, activo: true },
    include: { tenant: true },
  })

  const tenants = userRoles.map((ur) => ur.tenant)
  if (tenants.length === 0) redirect('/login')

  return (
    <div className="flex h-screen bg-gray-100">
      <Sidebar />
      <div className="flex-1 flex flex-col overflow-hidden">
        <Header tenants={tenants} />
        <main className="flex-1 p-6 overflow-y-auto">{children}</main>
      </div>
    </div>
  )
}