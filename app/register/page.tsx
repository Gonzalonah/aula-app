'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'

export default function RegistroPage() {
  const router = useRouter()
  const [form, setForm] = useState({
    nombre: '',
    apellido: '',
    email: '',
    telefono: '',
    alumnoDni: '',
    parentesco: '',
  })
  const [error, setError] = useState('')
  const [success, setSuccess] = useState('')

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
    setForm({ ...form, [e.target.name]: e.target.value })
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setError('')
    setSuccess('')

    const res = await fetch('/api/registro-familia', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(form),
    })

    const data = await res.json()

    if (!res.ok) {
      setError(data.error || 'Error al registrar')
    } else {
      setSuccess('Registro exitoso. Se envió una contraseña a tu correo.')
    }
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-100">
      <form onSubmit={handleSubmit} className="bg-white p-8 rounded-lg shadow-md w-full max-w-md">
        <h1 className="text-2xl font-bold mb-6 text-center">Registro de Familia</h1>
        {error && <p className="text-red-500 mb-4">{error}</p>}
        {success && <p className="text-green-500 mb-4">{success}</p>}
        <div className="mb-4">
          <label className="block text-sm font-medium mb-1">Nombre</label>
          <input name="nombre" value={form.nombre} onChange={handleChange} className="w-full border rounded px-3 py-2" required />
        </div>
        <div className="mb-4">
          <label className="block text-sm font-medium mb-1">Apellido</label>
          <input name="apellido" value={form.apellido} onChange={handleChange} className="w-full border rounded px-3 py-2" required />
        </div>
        <div className="mb-4">
          <label className="block text-sm font-medium mb-1">Email</label>
          <input name="email" type="email" value={form.email} onChange={handleChange} className="w-full border rounded px-3 py-2" required />
        </div>
        <div className="mb-4">
          <label className="block text-sm font-medium mb-1">Teléfono</label>
          <input name="telefono" value={form.telefono} onChange={handleChange} className="w-full border rounded px-3 py-2" />
        </div>
        <div className="mb-4">
          <label className="block text-sm font-medium mb-1">DNI del alumno</label>
          <input name="alumnoDni" value={form.alumnoDni} onChange={handleChange} className="w-full border rounded px-3 py-2" required />
        </div>
        <div className="mb-6">
          <label className="block text-sm font-medium mb-1">Parentesco</label>
          <select name="parentesco" value={form.parentesco} onChange={handleChange} className="w-full border rounded px-3 py-2" required>
            <option value="">Seleccionar...</option>
            <option value="madre">Madre</option>
            <option value="padre">Padre</option>
            <option value="tutor">Tutor</option>
          </select>
        </div>
        <button type="submit" className="w-full bg-green-600 text-white py-2 rounded hover:bg-green-700">
          Registrar
        </button>
      </form>
    </div>
  )
}