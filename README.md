# 📊 Sistema de Controle de Projetos (Portugol)

Este é um algoritmo de console robusto que simula um sistema de gerenciamento de projetos (como Trello ou Asana), implementado em Portugol. O projeto foca na **separação de entidades** (Projetos, Tarefas, Pessoas) e na **visualização de dados** por meio de relatórios de progresso.



## ✨ Funcionalidades Principais

* **1. Cadastrar Projeto:**
    * Permite o cadastro de novos projetos (Nome, Descrição, Prazo em dias).
    * **Validação:** Impede o cadastro de projetos com **nomes duplicados**.

* **2. Cadastrar Pessoa (Equipe):**
    * Permite o cadastro de membros da equipe (Nome, Cargo).
    * **Validação:** Impede o cadastro de pessoas com **nomes duplicados**.

* **3. Cadastrar Tarefa em Projeto:**
    * O sistema exibe uma lista de projetos e uma lista de pessoas para o usuário **selecionar por ID**, em vez de digitar nomes (evitando erros).
    * Vincula uma tarefa (com prazo) a um projeto e a um responsável.
    * **Validação:** Impede que o prazo da tarefa seja negativo e verifica os limites de tarefas por projeto.

* **4. Atualizar Status de Tarefa:**
    * Permite ao usuário selecionar um projeto e, em seguida, uma tarefa.
    * **Validação:** Exibe um menu numérico (1. Não Iniciada, 2. Em Progresso, 3. Concluída) para atualizar o status, garantindo que a entrada seja sempre válida.

* **5. Exibir Dashboard de Progresso (Alto Nível):**
    * Um relatório visual que mostra o status geral de todos os projetos.
    * Exibe uma **barra de progresso** (ex: `[#######---] 70%`) baseada na porcentagem de tarefas concluídas.

* **6. Exibir Detalhes dos Projetos (Baixo Nível):**
    * Um relatório detalhado (anteriormente chamado de "Gantt") que lista *todas* as tarefas de *todos* os projetos, mostrando a descrição, status, prazo e o nome do responsável.

## 🏛️ Estrutura e Lógica Aprimorada (Normalização)

A melhoria mais significativa deste algoritmo é a **separação de entidades** (normalização de dados), um conceito fundamental em bancos de dados e sistemas de software.

* **Estrutura Antiga (Ineficiente):**
    * `tipo Tarefa` continha um `tipo Pessoa` (`responsavel: Pessoa`).
    * **Problema:** Se "Ricardo" fosse responsável por 20 tarefas, seu nome e cargo seriam armazenados 20 vezes (redundância de dados).

* **Estrutura Aprimorada (Eficiente):**
    1.  Foi criado um vetor global `pessoas: vetor[...] de Pessoa`.
    2.  O `tipo Tarefa` foi modificado para armazenar apenas o `indiceResponsavel: inteiro`.
    3.  **Benefício:** Agora, se "Ricardo" (ID 1) está em 20 tarefas, o sistema armazena apenas o número `1` vinte vezes. O nome e o cargo são armazenados apenas *uma vez* no vetor `pessoas`. Isso é dramaticamente mais eficiente e fácil de manter.

## 🚀 Como Executar

Para executar este algoritmo, você precisará de um interpretador de Portugol.

1.  **VisualG (Recomendado):**
    * Baixe e instale o [VisualG](http://visualg.com.br/cli/).
    * Copie o código-fonte (`.alg`) do arquivo.
    * Abra o VisualG e cole o código.
    * Pressione **F9** (ou clique em "Rodar") para executar o programa.
