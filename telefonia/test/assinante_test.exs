defmodule AssinanteTest do
  use ExUnit.Case
  doctest Assinante

  # cria os arquivos e quando o teste finaliza ele remove-os
  setup do
    File.write("pre.txt", :erlang.term_to_binary([]))
    File.write("pos.txt", :erlang.term_to_binary([]))

    on_exit(fn ->
      File.rm("pre.txt")
      File.rm("pos.txt")
    end)
  end

  # agrupar os testes
  describe "testes responsáveis para cadastro de assinantes" do
    test "deve retornar estrutura de assinante" do
      assert %Assinante{nome: "teste", numero: "teste", cpf: "teste", plano: "plano"}.nome == "teste"
    end

    test "criar uma conta prepago" do
      assert Assinante.cadastrar("Anderson", "123", "123") ==
        {:ok, "Assinante Anderson cadastrado com sucesso!"}
    end

    test "deve retornar erro dizendo que assinante já está cadastrado" do
      Assinante.cadastrar("Anderson", "123", "123")
      assert Assinante.cadastrar("Anderson", "123", "123") ==
      {:error, "Assinante com este número cadastrado!"}
    end
  end

  describe "testes responsáveis por busca de assinantes" do
    test "busca pospago" do
      Assinante.cadastrar("Anderson", "123", "123", :pospago)

      assert Assinante.buscar_assinante("123", :pospago).nome == "Anderson"
    end

    test "busca prepago" do
      Assinante.cadastrar("Anderson", "123", "123")
      assert Assinante.buscar_assinante("123", :prepago).nome == "Anderson"
    end
  end

end
