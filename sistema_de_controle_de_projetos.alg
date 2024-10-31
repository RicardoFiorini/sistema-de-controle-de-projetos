algoritmo "Sistema de Controle de Projetos"

// Estruturas para Projetos, Tarefas e Pessoas

variáveis
    tipo Pessoa
        nome : caractere
        cargo : caractere
    fimTipo

    tipo Tarefa
        descricao : caractere
        responsavel : Pessoa
        prazoDias : inteiro
        status : caractere // "Não Iniciada", "Em Progresso", "Concluída"
    fimTipo

    tipo Projeto
        nome : caractere
        descricao : caractere
        prazoTotalDias : inteiro
        tarefas : vetor[1..100] de Tarefa
        totalTarefas : inteiro
    fimTipo

    projetos : vetor[1..50] de Projeto
    totalProjetos : inteiro
    opcao : inteiro
    nomeProjeto, descricaoProjeto, nomePessoa, cargoPessoa, descricaoTarefa, statusTarefa : caractere
    prazoProjeto, prazoTarefa : inteiro
    idProjeto, idTarefa : inteiro

início
    totalProjetos ← 0

    // Função para cadastrar novo projeto
    funcao cadastrarProjeto()
        totalProjetos ← totalProjetos + 1
        escreva("Nome do Projeto: ")
        leia(projetos[totalProjetos].nome)
        escreva("Descrição do Projeto: ")
        leia(projetos[totalProjetos].descricao)
        escreva("Prazo total (em dias): ")
        leia(projetos[totalProjetos].prazoTotalDias)
        projetos[totalProjetos].totalTarefas ← 0

        escreva("Projeto cadastrado com sucesso!\n")
    fimfuncao

    // Função para cadastrar uma nova tarefa em um projeto
    funcao cadastrarTarefa()
        escreva("Selecione o ID do Projeto para adicionar uma tarefa: ")
        leia(idProjeto)

        se idProjeto > 0 e idProjeto <= totalProjetos entao
            escreva("Descrição da Tarefa: ")
            leia(descricaoTarefa)
            escreva("Prazo da Tarefa (em dias): ")
            leia(prazoTarefa)
            escreva("Nome do Responsável: ")
            leia(nomePessoa)
            escreva("Cargo do Responsável: ")
            leia(cargoPessoa)

            projetos[idProjeto].totalTarefas ← projetos[idProjeto].totalTarefas + 1
            idTarefa ← projetos[idProjeto].totalTarefas

            projetos[idProjeto].tarefas[idTarefa].descricao ← descricaoTarefa
            projetos[idProjeto].tarefas[idTarefa].prazoDias ← prazoTarefa
            projetos[idProjeto].tarefas[idTarefa].responsavel.nome ← nomePessoa
            projetos[idProjeto].tarefas[idTarefa].responsavel.cargo ← cargoPessoa
            projetos[idProjeto].tarefas[idTarefa].status ← "Não Iniciada"

            escreva("Tarefa cadastrada com sucesso!\n")
        senao
            escreva("ID do projeto inválido.\n")
        fimse
    fimfuncao

    // Função para atualizar o status de uma tarefa
    funcao atualizarStatusTarefa()
        escreva("Selecione o ID do Projeto: ")
        leia(idProjeto)
        escreva("Selecione o ID da Tarefa: ")
        leia(idTarefa)

        se idProjeto > 0 e idProjeto <= totalProjetos e idTarefa > 0 e idTarefa <= projetos[idProjeto].totalTarefas entao
            escreva("Novo status da Tarefa (Não Iniciada, Em Progresso, Concluída): ")
            leia(statusTarefa)
            projetos[idProjeto].tarefas[idTarefa].status ← statusTarefa
            escreva("Status da tarefa atualizado com sucesso!\n")
        senao
            escreva("ID do projeto ou da tarefa inválido.\n")
        fimse
    fimfuncao

    // Função para gerar um gráfico de Gantt simplificado
    funcao gerarGraficoGantt()
        escreva("\n=== Gráfico de Gantt ===\n")
        para i de 1 até totalProjetos faça
            escreva("Projeto: ", projetos[i].nome, "\n")
            para j de 1 até projetos[i].totalTarefas faça
                escreva("Tarefa: ", projetos[i].tarefas[j].descricao, " - Status: ", projetos[i].tarefas[j].status, "\n")
                escreva("Dias: ", projetos[i].tarefas[j].prazoDias, " - Responsável: ", projetos[i].tarefas[j].responsavel.nome, "\n")
            fimpara
        fimpara
        escreva("Fim do Gráfico de Gantt.\n")
    fimfuncao

    // Função para gerar relatório de status do projeto
    funcao gerarRelatorioStatus()
        escreva("\n=== Relatório de Status dos Projetos ===\n")
        para i de 1 até totalProjetos faça
            escreva("Projeto: ", projetos[i].nome, "\n")
            escreva("Descrição: ", projetos[i].descricao, "\n")
            escreva("Prazo total: ", projetos[i].prazoTotalDias, " dias\n")
            escreva("Tarefas:\n")
            para j de 1 até projetos[i].totalTarefas faça
                escreva("Tarefa: ", projetos[i].tarefas[j].descricao, "\n")
                escreva("Status: ", projetos[i].tarefas[j].status, "\n")
                escreva("Responsável: ", projetos[i].tarefas[j].responsavel.nome, "\n")
            fimpara
            escreva("----------------------\n")
        fimpara
        escreva("Fim do Relatório de Status.\n")
    fimfuncao

    // Menu principal
    repita
        escreva("\n=== Sistema de Controle de Projetos ===\n")
        escreva("1. Cadastrar Projeto\n")
        escreva("2. Cadastrar Tarefa\n")
        escreva("3. Atualizar Status de Tarefa\n")
        escreva("4. Gerar Gráfico de Gantt\n")
        escreva("5. Gerar Relatório de Status dos Projetos\n")
        escreva("0. Sair\n")
        escreva("Escolha uma opção: ")
        leia(opcao)

        escolha opcao
            caso 1
                cadastrarProjeto()
            caso 2
                cadastrarTarefa()
            caso 3
                atualizarStatusTarefa()
            caso 4
                gerarGraficoGantt()
            caso 5
                gerarRelatorioStatus()
            caso 0
                escreva("Saindo do Sistema de Controle de Projetos...\n")
            caso contrário
                escreva("Opção inválida.\n")
        fimescolha
    até opcao = 0

fimalgoritmo
