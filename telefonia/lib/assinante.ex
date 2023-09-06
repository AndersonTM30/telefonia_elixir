# criando um struct
defmodule Assinante do
  defstruct nome: nil, numero: nil, cpf: nil

  def cadastrar(nome, numero, cpf) do
    assinante = %__MODULE__{nome: nome, numero: numero, cpf: cpf}
    |> :erlang.term_to_binary()

    File.write('assinantes.txt', assinante)
  end
end
