# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Creando permisos por defecto..."

# Permisos de usuarios
ver_usuarios = Permission.find_or_create_by!(name: "ver usuarios")
crear_usuarios = Permission.find_or_create_by!(name: "crear usuarios")
editar_usuarios = Permission.find_or_create_by!(name: "editar usuarios")
eliminar_usuarios = Permission.find_or_create_by!(name: "eliminar usuarios")
desactivar_usuarios = Permission.find_or_create_by!(name: "desactivar usuarios")

# Permisos de roles
ver_roles = Permission.find_or_create_by!(name: "ver roles")
crear_roles = Permission.find_or_create_by!(name: "crear roles")
editar_roles = Permission.find_or_create_by!(name: "editar roles")
eliminar_roles = Permission.find_or_create_by!(name: "eliminar roles")

# Permisos de buques
ver_buques = Permission.find_or_create_by!(name: "ver buques")
crear_buques = Permission.find_or_create_by!(name: "crear buques")
editar_buques = Permission.find_or_create_by!(name: "editar buques")
eliminar_buques = Permission.find_or_create_by!(name: "eliminar buques")

# Permisos de puertos
ver_puertos = Permission.find_or_create_by!(name: "ver puertos")
crear_puertos = Permission.find_or_create_by!(name: "crear puertos")
editar_puertos = Permission.find_or_create_by!(name: "editar puertos")
eliminar_puertos = Permission.find_or_create_by!(name: "eliminar puertos")

# Permisos de líneas navieras
ver_lineas_navieras = Permission.find_or_create_by!(name: "ver líneas navieras")
crear_lineas_navieras = Permission.find_or_create_by!(name: "crear líneas navieras")
editar_lineas_navieras = Permission.find_or_create_by!(name: "editar líneas navieras")
eliminar_lineas_navieras = Permission.find_or_create_by!(name: "eliminar líneas navieras")

puts "Permisos creados exitosamente!"

# Crear roles por defecto
puts "Creando roles por defecto..."

admin_role = Role.find_or_create_by!(name: Role::ADMINISTRADOR)
agente_role = Role.find_or_create_by!(name: Role::AGENTE_ADUANAL)
consolidador_role = Role.find_or_create_by!(name: Role::CONSOLIDADOR)
almacen_role = Role.find_or_create_by!(name: Role::ALMACEN)
inactivo_role = Role.find_or_create_by!(name: Role::INACTIVO)

puts "Roles creados exitosamente!"

# Asignar permisos a roles
puts "Asignando permisos a roles..."

# Administrador - tiene todos los permisos automáticamente (no necesita asignación manual)

# Agente Aduanal - permisos limitados
agente_permissions = [
  ver_buques, ver_puertos, ver_lineas_navieras
]

agente_permissions.each do |permission|
  RolePermission.find_or_create_by!(role: agente_role, permission: permission)
end

# Consolidador - permisos de creación y edición para algunos recursos
consolidador_permissions = [
  ver_buques, crear_buques, editar_buques,
  ver_puertos, crear_puertos, editar_puertos,
  ver_lineas_navieras, crear_lineas_navieras, editar_lineas_navieras,
  ver_usuarios, ver_roles
]

consolidador_permissions.each do |permission|
  RolePermission.find_or_create_by!(role: consolidador_role, permission: permission)
end

# Almacén - permisos básicos de visualización
almacen_permissions = [
  ver_buques, ver_puertos, ver_lineas_navieras, ver_usuarios, ver_roles
]

almacen_permissions.each do |permission|
  RolePermission.find_or_create_by!(role: almacen_role, permission: permission)
end

# Inactivo - sin permisos (ya está vacío por defecto)

puts "Permisos asignados a roles exitosamente!"
puts "Seeds completados!"
