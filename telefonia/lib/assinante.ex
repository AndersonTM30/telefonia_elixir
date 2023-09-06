# criando um struct
defmodule Assinante do
  defstruct nome: nil, numero: nil, cpf: nil, plano: nil

  # criando uma variável de módulo
  @assinantes %{:prepago => "pre.txt", :pospago => "pos.txt"}

  def cadastrar(nome, numero, cpf, plano \\ :prepago) do
    read(plano) ++ [%__MODULE__{nome: nome, numero: numero, cpf: cpf, plano: plano}]
    |> :erlang.term_to_binary()
    |> write(plano)

  end

  # função privada
  defp write(lista_assinantes, plano) do
    File.write!(@assinantes[plano], lista_assinantes)
  end

  def read(plano) do
    {:ok, assinantes} = File.read(@assinantes[plano])
    assinantes
    |> :erlang.binary_to_term()
  end
end
