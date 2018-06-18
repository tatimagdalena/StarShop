### 🚫 Este projeto não foi mais atualizado.

# StarShop
Simulação de uma loja virtual com artigos StarWars.

Para utilizar o aplicativo, é necessário fazer um login primeiro. O cadastro e o login são feitos através do framework Parse (www.parse.com). Cada usuário criado começa com um saldo de $10000,00.

A verificação dos dados do cartão se dá da seguinte maneira:

-Número do cartão: aceita apenas números com a quantidade exata de 16 dígitos.

-CVV do cartão: aceita apenas números com a quantidade exata de 3 dígitos.

-Data de validade do cartão: verifica se o mês é válido (de 1 a 12), e se a data já está expirada ou não.

-Não permite nenhum campo vazio.

Tendo os dados do cartão validados, é verificado se o usuário tem saldo suficiente para a compra (saldo este que está na base de dados do Parse). Havendo saldo, o valor é debidato e a transação aceita. Esta transação é salva internamente em uma plist.

Cada usuário pode verificar o histórico de suas próprias compras no "Perfil", disponível na tela com os artigos a serem comprados.

Para verificar todas as transações é possível utilizar o login de administrador:
LOGIN: adm, 
SENHA: adm

Este login de administrador não permite realizar compras.
