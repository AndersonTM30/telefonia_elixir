defmodule Telefonia do

  def cadastrar_assinante(nome, numero, cpf) do
    # importando o módulo de assinante
    %Assinante{nome: nome, numero: numero, cpf: cpf}
  end
end
