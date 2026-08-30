-- CreateTable
CREATE TABLE "tenants" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "logo_url" TEXT,
    "color_primario" TEXT,
    "color_secundario" TEXT,
    "config" JSONB NOT NULL DEFAULT '{}',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tenants_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "password_hash" TEXT NOT NULL,
    "nombre" TEXT NOT NULL,
    "apellido" TEXT NOT NULL,
    "telefono" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "roles" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "descripcion" TEXT,

    CONSTRAINT "roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_roles" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "role_id" INTEGER NOT NULL,
    "activo" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "user_roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cursos" (
    "id" SERIAL NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "nombre" TEXT NOT NULL,
    "anio" INTEGER,
    "turno" TEXT,
    "activo" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "cursos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "alumnos" (
    "id" SERIAL NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "nombre" TEXT NOT NULL,
    "apellido" TEXT NOT NULL,
    "dni" TEXT,
    "fecha_nacimiento" TIMESTAMP(3),
    "curso_id" INTEGER,
    "activo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "alumnos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "familiares" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "alumno_id" INTEGER NOT NULL,
    "parentesco" TEXT,
    "activo" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "familiares_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "materias" (
    "id" SERIAL NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "nombre" TEXT NOT NULL,
    "es_laboratorio" BOOLEAN NOT NULL DEFAULT false,
    "activo" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "materias_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cuatrimestres" (
    "id" SERIAL NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "nombre" TEXT NOT NULL,
    "fecha_inicio" TIMESTAMP(3) NOT NULL,
    "fecha_fin" TIMESTAMP(3) NOT NULL,
    "activo" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "cuatrimestres_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "curso_materia" (
    "id" SERIAL NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "curso_id" INTEGER NOT NULL,
    "materia_id" INTEGER NOT NULL,
    "profesor_id" INTEGER,
    "cuatrimestre_id" INTEGER NOT NULL,
    "activo" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "curso_materia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contenidos" (
    "id" SERIAL NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "materia_id" INTEGER NOT NULL,
    "cuatrimestre_id" INTEGER NOT NULL,
    "descripcion" TEXT NOT NULL,
    "orden" INTEGER,
    "activo" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "contenidos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "evaluaciones" (
    "id" SERIAL NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "alumno_id" INTEGER NOT NULL,
    "contenido_id" INTEGER NOT NULL,
    "curso_materia_id" INTEGER NOT NULL,
    "fecha" TIMESTAMP(3) NOT NULL,
    "tipo" TEXT,
    "nota" DECIMAL(4,2),
    "observaciones" TEXT,
    "created_by" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "evaluaciones_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "estados_trayectoria" (
    "id" SERIAL NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "alumno_id" INTEGER NOT NULL,
    "curso_materia_id" INTEGER NOT NULL,
    "cuatrimestre_id" INTEGER NOT NULL,
    "estado" TEXT NOT NULL,
    "calculado_el" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_por" INTEGER,
    "actualizado_el" TIMESTAMP(3),
    "notas_manuales" TEXT,
    "constancia_foto_url" TEXT,

    CONSTRAINT "estados_trayectoria_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "intensificaciones" (
    "id" SERIAL NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "alumno_id" INTEGER NOT NULL,
    "contenido_id" INTEGER NOT NULL,
    "curso_materia_id" INTEGER NOT NULL,
    "fecha" TIMESTAMP(3) NOT NULL,
    "nota" DECIMAL(4,2),
    "aprobado" BOOLEAN NOT NULL DEFAULT false,
    "observaciones" TEXT,
    "registrado_por" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "intensificaciones_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "asistencias" (
    "id" SERIAL NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "alumno_id" INTEGER NOT NULL,
    "fecha" TIMESTAMP(3) NOT NULL,
    "tipo" TEXT NOT NULL,
    "minutos_tarde" INTEGER,
    "horas_ausente" DECIMAL(4,2),
    "justificado" BOOLEAN NOT NULL DEFAULT false,
    "justificacion_id" INTEGER,
    "registrado_por" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "asistencias_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "justificaciones" (
    "id" SERIAL NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "alumno_id" INTEGER NOT NULL,
    "fecha_falta" TIMESTAMP(3) NOT NULL,
    "motivo" TEXT,
    "archivo_url" TEXT,
    "estado" TEXT NOT NULL,
    "aprobado_por" INTEGER,
    "fecha_solicitud" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "fecha_resolucion" TIMESTAMP(3),

    CONSTRAINT "justificaciones_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "comunicados" (
    "id" SERIAL NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "emisor_id" INTEGER NOT NULL,
    "tipo" TEXT NOT NULL,
    "asunto" TEXT NOT NULL,
    "cuerpo" TEXT NOT NULL,
    "adjuntos" JSONB NOT NULL DEFAULT '[]',
    "estado" TEXT NOT NULL,
    "fecha_envio" TIMESTAMP(3),
    "creado_el" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "programado_para" TIMESTAMP(3),

    CONSTRAINT "comunicados_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "comunicado_destinatarios" (
    "id" SERIAL NOT NULL,
    "comunicado_id" INTEGER NOT NULL,
    "tipo_destinatario" TEXT NOT NULL,
    "referencia_id" INTEGER,
    "user_id" INTEGER,
    "leido" BOOLEAN NOT NULL DEFAULT false,
    "fecha_lectura" TIMESTAMP(3),
    "respuesta" TEXT,
    "fecha_respuesta" TIMESTAMP(3),

    CONSTRAINT "comunicado_destinatarios_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notificaciones" (
    "id" SERIAL NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "tipo" TEXT,
    "titulo" TEXT,
    "mensaje" TEXT,
    "leida" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "notificaciones_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "configuracion_tenant" (
    "id" SERIAL NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "clave" TEXT NOT NULL,
    "valor" JSONB NOT NULL,
    "descripcion" TEXT,

    CONSTRAINT "configuracion_tenant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auditoria" (
    "id" SERIAL NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "user_id" INTEGER,
    "accion" TEXT NOT NULL,
    "entidad" TEXT,
    "entidad_id" INTEGER,
    "fecha" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "datos_anteriores" JSONB,
    "datos_nuevos" JSONB,

    CONSTRAINT "auditoria_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "roles_nombre_key" ON "roles"("nombre");

-- CreateIndex
CREATE UNIQUE INDEX "user_roles_user_id_tenant_id_role_id_key" ON "user_roles"("user_id", "tenant_id", "role_id");

-- CreateIndex
CREATE UNIQUE INDEX "curso_materia_curso_id_materia_id_cuatrimestre_id_key" ON "curso_materia"("curso_id", "materia_id", "cuatrimestre_id");

-- CreateIndex
CREATE UNIQUE INDEX "estados_trayectoria_alumno_id_curso_materia_id_cuatrimestre_key" ON "estados_trayectoria"("alumno_id", "curso_materia_id", "cuatrimestre_id");

-- CreateIndex
CREATE INDEX "asistencias_alumno_id_fecha_idx" ON "asistencias"("alumno_id", "fecha");

-- CreateIndex
CREATE INDEX "asistencias_tenant_id_fecha_idx" ON "asistencias"("tenant_id", "fecha");

-- CreateIndex
CREATE INDEX "comunicados_tenant_id_fecha_envio_idx" ON "comunicados"("tenant_id", "fecha_envio");

-- CreateIndex
CREATE INDEX "comunicado_destinatarios_comunicado_id_user_id_idx" ON "comunicado_destinatarios"("comunicado_id", "user_id");

-- CreateIndex
CREATE INDEX "notificaciones_user_id_leida_idx" ON "notificaciones"("user_id", "leida");

-- CreateIndex
CREATE UNIQUE INDEX "configuracion_tenant_tenant_id_clave_key" ON "configuracion_tenant"("tenant_id", "clave");

-- AddForeignKey
ALTER TABLE "user_roles" ADD CONSTRAINT "user_roles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_roles" ADD CONSTRAINT "user_roles_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_roles" ADD CONSTRAINT "user_roles_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "roles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cursos" ADD CONSTRAINT "cursos_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "alumnos" ADD CONSTRAINT "alumnos_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "alumnos" ADD CONSTRAINT "alumnos_curso_id_fkey" FOREIGN KEY ("curso_id") REFERENCES "cursos"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "familiares" ADD CONSTRAINT "familiares_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "familiares" ADD CONSTRAINT "familiares_alumno_id_fkey" FOREIGN KEY ("alumno_id") REFERENCES "alumnos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "materias" ADD CONSTRAINT "materias_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cuatrimestres" ADD CONSTRAINT "cuatrimestres_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "curso_materia" ADD CONSTRAINT "curso_materia_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "curso_materia" ADD CONSTRAINT "curso_materia_curso_id_fkey" FOREIGN KEY ("curso_id") REFERENCES "cursos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "curso_materia" ADD CONSTRAINT "curso_materia_materia_id_fkey" FOREIGN KEY ("materia_id") REFERENCES "materias"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "curso_materia" ADD CONSTRAINT "curso_materia_profesor_id_fkey" FOREIGN KEY ("profesor_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "curso_materia" ADD CONSTRAINT "curso_materia_cuatrimestre_id_fkey" FOREIGN KEY ("cuatrimestre_id") REFERENCES "cuatrimestres"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contenidos" ADD CONSTRAINT "contenidos_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contenidos" ADD CONSTRAINT "contenidos_materia_id_fkey" FOREIGN KEY ("materia_id") REFERENCES "materias"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contenidos" ADD CONSTRAINT "contenidos_cuatrimestre_id_fkey" FOREIGN KEY ("cuatrimestre_id") REFERENCES "cuatrimestres"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "evaluaciones" ADD CONSTRAINT "evaluaciones_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "evaluaciones" ADD CONSTRAINT "evaluaciones_alumno_id_fkey" FOREIGN KEY ("alumno_id") REFERENCES "alumnos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "evaluaciones" ADD CONSTRAINT "evaluaciones_contenido_id_fkey" FOREIGN KEY ("contenido_id") REFERENCES "contenidos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "evaluaciones" ADD CONSTRAINT "evaluaciones_curso_materia_id_fkey" FOREIGN KEY ("curso_materia_id") REFERENCES "curso_materia"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "evaluaciones" ADD CONSTRAINT "evaluaciones_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "estados_trayectoria" ADD CONSTRAINT "estados_trayectoria_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "estados_trayectoria" ADD CONSTRAINT "estados_trayectoria_alumno_id_fkey" FOREIGN KEY ("alumno_id") REFERENCES "alumnos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "estados_trayectoria" ADD CONSTRAINT "estados_trayectoria_curso_materia_id_fkey" FOREIGN KEY ("curso_materia_id") REFERENCES "curso_materia"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "estados_trayectoria" ADD CONSTRAINT "estados_trayectoria_cuatrimestre_id_fkey" FOREIGN KEY ("cuatrimestre_id") REFERENCES "cuatrimestres"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "estados_trayectoria" ADD CONSTRAINT "estados_trayectoria_actualizado_por_fkey" FOREIGN KEY ("actualizado_por") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "intensificaciones" ADD CONSTRAINT "intensificaciones_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "intensificaciones" ADD CONSTRAINT "intensificaciones_alumno_id_fkey" FOREIGN KEY ("alumno_id") REFERENCES "alumnos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "intensificaciones" ADD CONSTRAINT "intensificaciones_contenido_id_fkey" FOREIGN KEY ("contenido_id") REFERENCES "contenidos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "intensificaciones" ADD CONSTRAINT "intensificaciones_curso_materia_id_fkey" FOREIGN KEY ("curso_materia_id") REFERENCES "curso_materia"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "intensificaciones" ADD CONSTRAINT "intensificaciones_registrado_por_fkey" FOREIGN KEY ("registrado_por") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "asistencias" ADD CONSTRAINT "asistencias_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "asistencias" ADD CONSTRAINT "asistencias_alumno_id_fkey" FOREIGN KEY ("alumno_id") REFERENCES "alumnos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "asistencias" ADD CONSTRAINT "asistencias_justificacion_id_fkey" FOREIGN KEY ("justificacion_id") REFERENCES "justificaciones"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "asistencias" ADD CONSTRAINT "asistencias_registrado_por_fkey" FOREIGN KEY ("registrado_por") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "justificaciones" ADD CONSTRAINT "justificaciones_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "justificaciones" ADD CONSTRAINT "justificaciones_alumno_id_fkey" FOREIGN KEY ("alumno_id") REFERENCES "alumnos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "justificaciones" ADD CONSTRAINT "justificaciones_aprobado_por_fkey" FOREIGN KEY ("aprobado_por") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "comunicados" ADD CONSTRAINT "comunicados_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "comunicados" ADD CONSTRAINT "comunicados_emisor_id_fkey" FOREIGN KEY ("emisor_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "comunicado_destinatarios" ADD CONSTRAINT "comunicado_destinatarios_comunicado_id_fkey" FOREIGN KEY ("comunicado_id") REFERENCES "comunicados"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "comunicado_destinatarios" ADD CONSTRAINT "comunicado_destinatarios_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notificaciones" ADD CONSTRAINT "notificaciones_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notificaciones" ADD CONSTRAINT "notificaciones_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "configuracion_tenant" ADD CONSTRAINT "configuracion_tenant_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "auditoria" ADD CONSTRAINT "auditoria_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "auditoria" ADD CONSTRAINT "auditoria_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;
