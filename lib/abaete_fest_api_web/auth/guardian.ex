defmodule AbaeteFestApiWeb.Auth.Guardian do
  use Guardian, otp_app: :abaete_fest_api

  alias AbaeteFestApi.Account

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = Account.get_user!(id)
    {:ok,  resource}
  end

  def authenticate(email, password) do
    with {:ok, user} <- Account.get_by_email(email) do
      case validate_password(password, user.password_hash) do
        true ->
          create_token(user)
        false ->
          {:error, :unauthorized}
      end
    end
  end

  defp validate_password(password, password_hash) do
    Comeonin.Bcrypt.checkpw(password, password_hash)
  end

  defp create_token(user) do
    {:ok, token, _claims} = encode_and_sign(user)
    {:ok, user, token}
  end
end
