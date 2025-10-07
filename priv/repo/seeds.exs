# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     AbaeteFestApi.Repo.insert!(%AbaeteFestApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias AbaeteFestApi.{Account, Repo}

# Criar usuário admin
admin_attrs = %{
  email: "admin@mail.com",
  name: "Administrador",
  password: "123456",
  birth_date: "1990-01-01",
  phone: "+5511999999999",
  is_admin: true
}

case Account.create_user(admin_attrs) do
  {:ok, user} ->
    IO.puts("✅ Usuário admin criado com sucesso: #{user.email}")
  {:error, changeset} ->
    IO.puts("❌ Erro ao criar usuário admin:")
    IO.inspect(changeset.errors)
end

# Criar alguns usuários de exemplo
users_data = [
  %{
    email: "joao.silva@example.com",
    name: "João Silva",
    password: "123456",
    birth_date: "1995-05-15",
    phone: "+5511987654321",
    is_admin: false
  },
  %{
    email: "maria.santos@example.com",
    name: "Maria Santos",
    password: "123456",
    birth_date: "1992-08-22",
    phone: "+5511976543210",
    is_admin: false
  },
  %{
    email: "pedro.oliveira@example.com",
    name: "Pedro Oliveira",
    password: "123456",
    birth_date: "1988-12-10",
    phone: "+5511965432109",
    is_admin: false
  },
  %{
    email: "ana.costa@example.com",
    name: "Ana Costa",
    password: "123456",
    birth_date: "1993-03-18",
    phone: "+5511954321098",
    is_admin: false
  }
]

Enum.each(users_data, fn user_attrs ->
  case Account.create_user(user_attrs) do
    {:ok, user} ->
      IO.puts("✅ Usuário criado: #{user.name} (#{user.email})")
    {:error, changeset} ->
      IO.puts("❌ Erro ao criar usuário #{user_attrs.name}:")
      IO.inspect(changeset.errors)
  end
end)

IO.puts("\n🎉 Seeds executados com sucesso!")
IO.puts("📧 Admin: admin@mail.com")
IO.puts("🔑 Senha padrão para todos os usuários: 123456")
