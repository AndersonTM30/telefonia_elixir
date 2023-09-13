# criando um struct
defmodule Assinante do
  defstruct nome: nil, numero: nil, cpf: nil, plano: nil

  # criando uma variável de módulo
  @assinantes %{:prepago => "pre.txt", :pospago => "pos.txt"}

  def buscar_assinante(numero, key \\ :all), do: buscar(numero, key)
  # conceito de call by pattern
  defp buscar(numero, :prepago), do: filtro(assinantes_prepago(), numero)

  defp buscar(numero, :pospago), do: filtro(assinantes_pospago(), numero)

  defp buscar(numero, :all), do: filtro(assinantes(), numero)

  defp filtro(lista, numero), do: Enum.find(lista, &(&1.numero == numero))

  # conceito de simple function
  def assinantes_prepago(), do: read(:prepago)
  def assinantes_pospago(), do: read(:pospago)
  def assinantes(), do: read(:prepago) ++ read(:pospago)

  def cadastrar(nome, numero, cpf, plano \\ :prepago) do
    # valida se o assinante já está cadastrado
    case buscar_assinante(numero) do
      nil ->
        read(plano) ++ [%__MODULE__{nome: nome, numero: numero, cpf: cpf, plano: plano}]
        |> :erlang.term_to_binary()
        |> write(plano)

        {:ok, "Assinante #{nome} cadastrado com sucesso!"}
      _assinante -> {:error, "Assinante com este número cadastrado!"}
    end


  end

  # função privada
  defp write(lista_assinantes, plano) do
    File.write!(@assinantes[plano], lista_assinantes)
  end

  def read(plano) do
    # case statment para instruções condicionais
    case File.read(@assinantes[plano]) do
      {:ok, assinantes} ->
        assinantes
        |> :erlang.binary_to_term()
      {:error, :ennoent} ->
        {:error, "Arquivo inválido!"}
    end
  end
end
