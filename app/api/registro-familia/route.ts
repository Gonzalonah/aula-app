import { NextResponse } from 'next/server'
import { prisma } from '@/lib/prisma'
import bcrypt from 'bcryptjs'

export async function POST(request: Request) {
  try {
    const { nombre, apellido, email, telefono, alumnoDni, parentesco } = await request.json()

    // Buscar alumno por DNI
    const alumno = await prisma.alumno.findFirst({
      where: { dni: alumnoDni },
    })

    if (!alumno) {
      return NextResponse.json({ error: 'No se encontró alumno con ese DNI' }, { status: 404 })
    }

    // Verificar si el email ya está registrado
    const existingUser = await prisma.user.findUnique({ where: { email } })
    if (existingUser) {
      return NextResponse.json({ error: 'El email ya está registrado' }, { status: 400 })
    }

    // Generar contraseña aleatoria
    const tempPassword = Math.random().toString(36).slice(-8)
    const hashedPassword = await bcrypt.hash(tempPassword, 10)

    // Crear usuario familia
    const user = await prisma.user.create({
      data: {
        email,
        passwordHash: hashedPassword,
        nombre,
        apellido,
        telefono,
      },
    })

    // Obtener rol familia
    const rolFamilia = await prisma.role.findUnique({ where: { nombre: 'familia' } })
    if (!rolFamilia) throw new Error('Rol familia no existe')

    // Asignar rol en el tenant del alumno
    await prisma.userRole.create({
      data: {
        userId: user.id,
        tenantId: alumno.tenantId,
        roleId: rolFamilia.id,
      },
    })

    // Crear relación familiar
    await prisma.familiar.create({
      data: {
        userId: user.id,
        alumnoId: alumno.id,
        parentesco,
      },
    })

    // TODO: Enviar email con la contraseña temporal (usar nodemailer, sendgrid, etc.)
    console.log(`Contraseña temporal para ${email}: ${tempPassword}`)

    return NextResponse.json({ message: 'Registro exitoso' })
  } catch (error) {
    console.error(error)
    return NextResponse.json({ error: 'Error interno del servidor' }, { status: 500 })
  }
}