# eng_soft_tp1
# Sistema de gerenciamento de estoque e vendas

| Equipe: |  |
|----|---|
| Gabriel Henrique Souto Pires | 2014106384 |
| Marcus Vinicius de Oliveira | 2018076498 |
| Matheus Filipe Sieiro Vargas | 2014144812 |
| Raydan Elias Gaspar | 2014124846 |

## Planilha de Apuração de Horas Trabalhadas
https://docs.google.com/spreadsheets/d/1EARTbkncoRhgOU64I4kdMqKkPbGQnHQ68JIbxHT7km4/edit?usp=sharing

----
Objetivo e breve descrição do sistema:

O sistema em questão tem como objetivo:

- Cadastrar e correlacionar as mercadorias de uma loja em geral.
- Capacitar a venda e controle de estoque
- Gerenciar o cadastro de clientes e suas respectivas compras dentro do sistema

Tecnologia a ser utilizada:

- Aplicação mobile
- Cross-plataform em Flutter
- Google Firebase

# User stories

**Como um** usuário do tipo administrador do sistema\
**Eu quero** poder cadastrar mercadorias\
**para que** o sistema tenha produtos disponíveis para os clientes

### Acceptance Criteria

1. Consigo cadastrar um produto.
2. Usuário consegue pesquisar por esse produto cadastrado.

----
**Como um** usuário do tipo administrador do sistema\
**Eu quero** poder editar as mercadorias existentes\
**para que** as informações e preços dos produtos fiquem sempre atualizadas

### Acceptance Criteria

1. Consigo mudar as informações de um produto cadastrado
2. Usuário vê a mudança em tempo real após pesquisar pelo produto.

----
**Como um** usuário do tipo administrador do sistema\
**Eu quero** poder excluir mercadorias do sistema\
**para que** produtos indisponíveis não fiquem no sistema

### Acceptance Criteria

1. Consigo excluir qualquer mercadoria
2. Usuário não consegue mais achar mercadoria que foi excluída

----
**Como um** usuário do tipo comum\
**Eu quero** poder adicionar uma mercadoria ao carrinho de compras\
**para que** eu possa comprar mais de um produto por vez

### Acceptance Criteria

1. Usuário consegue adicionar um ou mais produtos no carrinho
2. Produto adicionado aparece no carrinho

----
**Como um** usuário do tipo comum\
**Eu quero** poder excluir uma mercadoria do carrinho de compras\
**para que** eu possa concluir minha compra sem esse produto

### Acceptance Criteria

1. Usuário consegue excluir um ou mais produtos no carrinho
2. Produto excluído some do carrinho

----
**Como um** usuário do tipo comum\
**Eu quero** finalizar minha compra\
**para que** eu receba meus produtos

### Acceptance Criteria

1. Usuário finaliza a compra e faz o pagamento

----
**Como um** usuário do tipo comum\
**Eu quero** me cadastrar no sistema\
**para que** eu tenha uma conta no sistema

### Acceptance Criteria

1. Usuário cadastra login e senha no sistema

----
**Como um** usuário do tipo comum\
**Eu quero** realizar login no sistema\
**para que** eu possa fazer compras

### Acceptance Criteria

1. Usuário consegue realizar login com seu usuário e senha

