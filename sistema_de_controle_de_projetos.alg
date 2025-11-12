algoritmo "Sistema de Controle de Projetos Aprimorado"

// --- Constantes de Limite ---
const
   LIMITE_PROJETOS = 50
   LIMITE_PESSOAS = 50
   LIMITE_TAREFAS = 100 // Por projeto

// --- Definição dos Tipos (Registros) ---
tipo Pessoa
   nome: caractere
   cargo: caractere
fimTipo

// --- OTIMIZAÇÃO: A Tarefa armazena o ÍNDICE do responsável ---
tipo Tarefa
   descricao: caractere
   indiceResponsavel: inteiro // O índice (posição) da pessoa no vetor 'pessoas'
   prazoDias: inteiro
   status: caractere // "Não Iniciada", "Em Progresso", "Concluída"
fimTipo

tipo Projeto
   nome: caractere
   descricao: caractere
   prazoTotalDias: inteiro
   tarefas: vetor[1..LIMITE_TAREFAS] de Tarefa
   totalTarefas: inteiro
fimTipo

// --- Variáveis Globais ---
var
   projetos: vetor[1..LIMITE_PROJETOS] de Projeto
   pessoas: vetor[1..LIMITE_PESSOAS] de Pessoa
   totalProjetos, totalPessoas: inteiro
   opcao: inteiro

// --- Procedimento: Pausa a execução ---
procedimento Pausar()
var
   tecla: caractere
inicio
   escreva("\n(Pressione [ENTER] para voltar ao menu...)")
   leia(tecla)
fimprocedimento

// --- Funções Auxiliares de Busca (para validação) ---
funcao buscarProjetoPorNome(nome: caractere) : inteiro
   var i: inteiro
   para i de 1 até totalProjetos faca
      se (projetos[i].nome = nome) entao
         retorne i
      fimse
   fimpara
   retorne 0
fimfuncao

funcao buscarPessoaPorNome(nome: caractere) : inteiro
   var i: inteiro
   para i de 1 até totalPessoas faca
      se (pessoas[i].nome = nome) entao
         retorne i
      fimse
   fimpara
   retorne 0
fimfuncao

// --- Função Helper: Seleciona um Status ---
funcao SelecionarStatus() : caractere
var
   opStatus: inteiro
inicio
   opStatus <- 0
   enquanto (opStatus < 1) ou (opStatus > 3) faca
      escreva("Selecione o novo status:\n")
      escreva("1. Não Iniciada\n")
      escreva("2. Em Progresso\n")
      escreva("3. Concluída\n")
      escreva("Opção: ")
      leia(opStatus)
   fimenquanto
   
   escolha opStatus
      caso 1: retorne "Não Iniciada"
      caso 2: retorne "Em Progresso"
      caso 3: retorne "Concluída"
   fimescolha
fimfuncao


// --- Procedimento: Cadastrar Projeto ---
procedimento cadastrarProjeto()
var
   nomeProjeto, descProjeto: caractere
   prazo: inteiro
inicio
   limpatela
   escreva("--- Cadastro de Novo Projeto ---\n")
   
   
   se (totalProjetos >= LIMITE_PROJETOS) entao
      escreva("[ERRO] Limite de (", LIMITE_PROJETOS, ") projetos atingido!\n")
      retorne
   fimse
   
   escreva("Nome do Projeto: ")
   leia(nomeProjeto)
   
   // Validação de Duplicidade
   se (buscarProjetoPorNome(nomeProjeto) > 0) entao
      escreva("\n[ERRO] Já existe um projeto com este nome!\n")
   senao
      escreva("Descrição do Projeto: ")
      leia(descProjeto)
      
      prazo <- 0
      enquanto (prazo <= 0) faca
         escreva("Prazo total (em dias): ")
         leia(prazo)
         se (prazo <= 0) entao
            escreva("[ERRO] O prazo deve ser positivo.\n")
         fimse
      fimenquanto
      
      totalProjetos <- totalProjetos + 1
      projetos[totalProjetos].nome <- nomeProjeto
      projetos[totalProjetos].descricao <- descProjeto
      projetos[totalProjetos].prazoTotalDias <- prazo
      projetos[totalProjetos].totalTarefas <- 0
      
      escreva("\nProjeto '", nomeProjeto, "' cadastrado com sucesso!\n")
   fimse
fimprocedimento

// --- Procedimento: Cadastrar Pessoa (Equipe) ---
procedimento cadastrarPessoa()
var
   nomePessoa, cargoPessoa: caractere
inicio
   limpatela
   escreva("--- Cadastro de Pessoa (Equipe) ---\n")
   
   se (totalPessoas >= LIMITE_PESSOAS) entao
      escreva("[ERRO] Limite de (", LIMITE_PESSOAS, ") pessoas atingido!\n")
      retorne
   fimse
   
   escreva("Nome da Pessoa: ")
   leia(nomePessoa)
   
   // Validação de Duplicidade
   se (buscarPessoaPorNome(nomePessoa) > 0) entao
      escreva("\n[ERRO] Já existe uma pessoa com este nome!\n")
   senao
      escreva("Cargo (ex: Desenvolvedor, Designer): ")
      leia(cargoPessoa)
      
      totalPessoas <- totalPessoas + 1
      pessoas[totalPessoas].nome <- nomePessoa
      pessoas[totalPessoas].cargo <- cargoPessoa
      
      escreva("\nPessoa '", nomePessoa, "' cadastrada com sucesso!\n")
   fimse
fimprocedimento

// --- Procedimento: Listar e Selecionar (Projetos ou Pessoas) ---
// (Helper de UX para evitar que o usuário digite IDs)
funcao SelecionarProjeto() : inteiro
   var i, idProjeto: inteiro
   
   se (totalProjetos = 0) entao
      escreva("\n[ERRO] Nenhum projeto cadastrado. Cadastre um projeto primeiro.\n")
      retorne 0
   fimse
   
   escreva("\n--- Projetos Disponíveis ---\n")
   para i de 1 ate totalProjetos faca
      escreva(i, " - ", projetos[i].nome, "\n")
   fimpara
   
   idProjeto <- 0
   enquanto (idProjeto < 1) ou (idProjeto > totalProjetos) faca
      escreva("Selecione o ID do Projeto: ")
      leia(idProjeto)
   fimenquanto
   retorne idProjeto
fimfuncao

funcao SelecionarPessoa() : inteiro
   var i, idPessoa: inteiro
   
   se (totalPessoas = 0) entao
      escreva("\n[ERRO] Nenhuma pessoa cadastrada. Cadastre uma pessoa primeiro.\n")
      retorne 0
   fimse
   
   escreva("\n--- Pessoas Disponíveis ---\n")
   para i de 1 ate totalPessoas faca
      escreva(i, " - ", pessoas[i].nome, " (", pessoas[i].cargo, ")\n")
   fimpara
   
   idPessoa <- 0
   enquanto (idPessoa < 1) ou (idPessoa > totalPessoas) faca
      escreva("Selecione o ID do Responsável: ")
      leia(idPessoa)
   fimenquanto
   retorne idPessoa
fimfuncao

// --- Procedimento: Cadastrar Tarefa ---
procedimento cadastrarTarefa()
var
   idProjeto, idTarefa, prazoTarefa, idResponsavel: inteiro
   descTarefa: caractere
inicio
   limpatela
   escreva("--- Cadastrar Nova Tarefa ---\n")
   
   // 1. Seleciona o Projeto
   idProjeto <- SelecionarProjeto()
   se (idProjeto = 0) entao
      retorne // Erro já foi mostrado
   fimse
   
   // 2. Verifica Limite de Tarefas
   se (projetos[idProjeto].totalTarefas >= LIMITE_TAREFAS) entao
      escreva("\n[ERRO] O Projeto '", projetos[idProjeto].nome, "' atingiu o limite de tarefas.\n")
      retorne
   fimse
   
   // 3. Seleciona o Responsável
   idResponsavel <- SelecionarPessoa()
   se (idResponsavel = 0) entao
      retorne // Erro já foi mostrado
   fimse
   
   // 4. Coleta dados da tarefa
   escreva("Descrição da Tarefa: ")
   leia(descTarefa)
   
   prazoTarefa <- 0
   enquanto (prazoTarefa <= 0) faca
      escreva("Prazo da Tarefa (em dias): ")
      leia(prazoTarefa)
      se (prazoTarefa <= 0) ou (prazoTarefa > projetos[idProjeto].prazoTotalDias) entao
         escreva("[AVISO] O prazo deve ser positivo e (idealmente) menor que o prazo do projeto (", projetos[idProjeto].prazoTotalDias, " dias).\n")
         se (prazoTarefa <= 0) entao
            prazoTarefa <- 0 // Força o loop
         fimse
      fimse
   fimenquanto

   // 5. Adiciona a tarefa
   projetos[idProjeto].totalTarefas <- projetos[idProjeto].totalTarefas + 1
   idTarefa <- projetos[idProjeto].totalTarefas // Pega o próximo índice
   
   projetos[idProjeto].tarefas[idTarefa].descricao <- descTarefa
   projetos[idProjeto].tarefas[idTarefa].prazoDias <- prazoTarefa
   projetos[idProjeto].tarefas[idTarefa].indiceResponsavel <- idResponsavel // Armazena o ÍNDICE
   projetos[idProjeto].tarefas[idTarefa].status <- "Não Iniciada"

   escreva("\nTarefa cadastrada com sucesso no Projeto '", projetos[idProjeto].nome, "'!\n")
fimprocedimento

// --- Procedimento: Atualizar Status de Tarefa ---
procedimento atualizarStatusTarefa()
var
   idProjeto, idTarefa, i: inteiro
   novoStatus: caractere
inicio
   limpatela
   escreva("--- Atualizar Status de Tarefa ---\n")
   
   idProjeto <- SelecionarProjeto()
   se (idProjeto = 0) entao
      retorne
   fimse
   
   se (projetos[idProjeto].totalTarefas = 0) entao
      escreva("\n[ERRO] O projeto '", projetos[idProjeto].nome, "' não possui tarefas.\n")
      retorne
   fimse

   // Lista as tarefas do projeto selecionado
   escreva("\n--- Tarefas do Projeto '", projetos[idProjeto].nome, "' ---\n")
   para i de 1 ate projetos[idProjeto].totalTarefas faca
      escreva(i, " - ", projetos[idProjeto].tarefas[i].descricao, " [", projetos[idProjeto].tarefas[i].status, "]\n")
   fimpara
   
   idTarefa <- 0
   enquanto (idTarefa < 1) ou (idTarefa > projetos[idProjeto].totalTarefas) faca
      escreva("Selecione o ID da Tarefa para atualizar: ")
      leia(idTarefa)
   fimenquanto
   
   // Seleciona o novo status
   novoStatus <- SelecionarStatus()
   
   projetos[idProjeto].tarefas[idTarefa].status <- novoStatus
   
   escreva("\nStatus da tarefa '", projetos[idProjeto].tarefas[idTarefa].descricao, "' atualizado para [", novoStatus, "]!\n")
fimprocedimento

// --- Procedimento: Exibir Dashboard de Progresso (Relatório Alto Nível) ---
procedimento exibirDashboardProgresso()
var
   i, j, concluidas, totalTarefas, percentual, barras: inteiro
   barraProgresso: caractere
inicio
   limpatela
   escreva("=========================================\n")
   escreva("=       DASHBOARD DE PROGRESSO        =\n")
   escreva("=========================================\n")
   
   
   se (totalProjetos = 0) entao
      escreva("  (Nenhum projeto cadastrado)\n")
   fimse
   
   para i de 1 até totalProjetos faca
      concluidas <- 0
      totalTarefas <- projetos[i].totalTarefas
      
      // 1. Calcula o progresso
      se (totalTarefas > 0) entao
         para j de 1 até totalTarefas faca
            se (projetos[i].tarefas[j].status = "Concluída") entao
               concluidas <- concluidas + 1
            fimse
         fimpara
         percentual <- (concluidas * 100) / totalTarefas
      senao
         percentual <- 0
      fimse
      
      // 2. Desenha a barra de progresso (de 20 caracteres)
      barraProgresso <- ""
      barras <- (percentual * 20) / 100
      para j de 1 ate 20 faca
         se (j <= barras) entao
            barraProgresso <- barraProgresso + "#"
         senao
            barraProgresso <- barraProgresso + "-"
         fimse
      fimpara
      
      // 3. Exibe o resultado
      escreva("Projeto: ", projetos[i].nome, "\n")
      escreva("[", barraProgresso, "] ", percentual, "%")
      escreva(" (", concluidas, "/", totalTarefas, " tarefas concluídas)\n")
      escreva("Prazo Total: ", projetos[i].prazoTotalDias, " dias\n")
      escreva("-----------------------------------------\n")
   fimpara
fimprocedimento

// --- Procedimento: Exibir Detalhes dos Projetos (Relatório Detalhado) ---
procedimento exibirDetalhesProjetos()
var
   i, j, idResp: inteiro
   nomeResp: caractere
   t: Tarefa // Variável auxiliar
inicio
   limpatela
   escreva("=========================================\n")
   escreva("=      RELATÓRIO DETALHADO DE TAREFAS     =\n")
   escreva("=========================================\n")
   
   se (totalProjetos = 0) entao
      escreva("  (Nenhum projeto cadastrado)\n")
   fimse
   
   para i de 1 até totalProjetos faca
      escreva("\nProjeto: ", projetos[i].nome, " (", projetos[i].totalTarefas, " tarefas)\n")
      escreva("--------------------------------------------------\n")
      
      se (projetos[i].totalTarefas = 0) entao
         escreva("  (Nenhuma tarefa cadastrada para este projeto)\n")
      senao
         para j de 1 até projetos[i].totalTarefas faca
            t <- projetos[i].tarefas[j] // Pega a tarefa
            
            // Busca o nome do responsável
            idResp <- t.indiceResponsavel
            se (idResp > 0) e (idResp <= totalPessoas) entao
               nomeResp <- pessoas[idResp].nome
            senao
               nomeResp <- "N/D"
            fimse
            
            escreva("  Tarefa: ", t.descricao, "\n")
            escreva("    Status: ", t.status, "\n")
            escreva("    Prazo: ", t.prazoDias, " dias\n")
            escreva("    Responsável: ", nomeResp, "\n")
            escreva("  ................................................\n")
         fimpara
      fimse
   fimpara
fimprocedimento

// --- Bloco Principal (Início da Execução) ---
inicio
   totalProjetos <- 0
   totalPessoas <- 0
   opcao <- -1
   
   // Menu principal
   repita
      limpatela
      escreva("=========================================\n")
      escreva("=     Sistema de Controle de Projetos     =\n")
      escreva("=========================================\n")
      escreva(" Projetos: ", totalProjetos, "/", LIMITE_PROJETOS, " | Pessoas: ", totalPessoas, "/", LIMITE_PESSOAS, "\n")
      escreva("=========================================\n")
      escreva("1. Cadastrar Projeto\n")
      escreva("2. Cadastrar Pessoa (Equipe)\n") // Nova opção
      escreva("3. Cadastrar Tarefa em Projeto\n")
      escreva("4. Atualizar Status de Tarefa\n")
      escreva("5. Exibir Dashboard de Progresso\n") // Melhorado
      escreva("6. Exibir Detalhes dos Projetos\n") // Melhorado
      escreva("0. Sair\n")
      escreva("-----------------------------------------\n")
      escreva("Escolha uma opção: ")
      leia(opcao)

      escolha opcao
         caso 1
            cadastrarProjeto()
            Pausar()
         caso 2
            cadastrarPessoa()
            Pausar()
         caso 3
            cadastrarTarefa()
            Pausar()
         caso 4
            atualizarStatusTarefa()
            Pausar()
         caso 5
            exibirDashboardProgresso()
            Pausar()
         caso 6
            exibirDetalhesProjetos()
            Pausar()
         caso 0
            escreva("\nSaindo do Sistema de Controle de Projetos...\n")
         padrão
            escreva("\n[ERRO] Opção inválida.\n")
            Pausar()
      fimescolha
      
   até (opcao = 0)
fimalgoritmo
