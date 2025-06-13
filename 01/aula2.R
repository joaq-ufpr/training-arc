#### Já vimos muitas coisas básicas relacionadas a vetores no R
# agora, está na hora de engrossarmos o caldo desse feijão
# com funções de manipulação mais avançadas.
# e também começarmos a trabalhar com matrizes


## Criação de vetores e manipulação

# Criando um vetor de inteiros
vetor_inteiro <- c(2,4,6,8,10)

# vetor de reais
vetor_real <- c(3.14, 1.618, 2.718, 3.48, 1.9)

# Vetor de caracteres
vetor_caracteres <- c("maça", "banana", "laranja")

# vetor misto
vetor_misto <- c(1,2,"maça", "banana", "laranja")
vetor_misto # note que os valores 1 e 2 sofreram um cast de tipagem para char.


## Operações sobre vetores
# soma de vetores
soma_vetores <- vetor_inteiro + vetor_real
soma_vetores

# substração de vetores
subtracao_vetores <- vetor_real - vetor_inteiro
subtracao_vetores

# Multiplicação de vetor por um escalar
multiplicacao_vetores <- vetor_inteiro * 2
multiplicacao_vetores

# Divisão por um escalar
divisao_vetores <- vetor_real / 3
divisao_vetores

## Regra da reciclagem
# essa regra aparece quando estamos realizando operações
# entre vetores de tamanho diferentes, a reciclagem seria
# nada mais que a reutilização de valores do menor vetor
# várias vezes até chegar ao mesmo tamanho de outros vetor
# que será operado.

# exemplo
vetor_a <- c(1, 2)
vetor_b <- c(10,20,30)
resultado <- vetor_a + vetor_b
resultado # note como o R reutilizou o primeiro valor do vetor_a para pode chegar ao mesmo tamanho do vetor_b


## vetores lógico e operações
# Um vetor lógico contém valores booleanos (TRUE ou FALSE), onde cada elemento indica se uma determinada condição é verdadeira ou falsa para o elemento correspondente no vetor original.

# exemplo de condição em vetores lógicos
idades <- c(16, 21, 14, 30, 25)
condicao <- idades > 18
condicao # Retorna o vetor de valores lógicos

# Retornando o valores a partir da condição
idades_maiores <- idades[condicao]
idades_maiores

# Mesmo exemplo acima, porem explicitando a condição
idades_maiores <- idades[idades > 18]
idades_maiores

# Podemos usar também operações lógicas
idades <- c(16,21,14,30,25,45)
condicao1 <- idades > 18
condicao2 <- idades < 30
condicao_final <- condicao1 & condicao2
idades_selecionadas <- idades[condicao_final]
idades_selecionadas

# Mesmo exemplo anterior mas feito de outra maneira
idades[idades > 18 & idades < 30]


## Tratamento de informações faltantes
# Podemos verificar valores NA em vetores
dados <- c(1, NA, 3, 4, NA)
valores_faltante <- is.na(dados)
valores_faltante

# Remoção valores NA
# podemos usar as funções na.omit() e na.exclude
dados_sem_na <- na.omit(dados)
dados_sem_na

dados_sem_na_exclude <- na.exclude(dados)
dados_sem_na_exclude

# em ambas as funções os prompts mostram os indices
# que foram removidos/omitidos

# Podemos substuir esses valores NA por outro valor
dados[is.na(dados)] <- 0
dados

## Valores NaN
resultado <- 0/0
resultado

valor_nao_e_numero <- is.nan(resultado)
valor_nao_e_numero

## Vetores nomeados
idades <- c(20, 28, 35)
names(idades)
names(idades) <- c("João", "Aline", "Márcio")
names(idades)
idades
idades["Aline"]
idades[c("Aline", "João")]

### Matrizes
# Para criar matrizes, podemo usar as funções cbind() e rbind()
vetor_a <- c(1,2,3,4)
vetor_b <- c(5,6,7,8)

matriz_linha <- rbind(vetor_a, vetor_b)
matriz_linha
class(matriz_linha)
is.matrix(matriz_linha)

matrix_coluna <- cbind(vetor_a, vetor_b)
matrix_coluna
class(matrix_coluna)
is.matrix(matriz_linha)

# Podemos criar matrizes com a função matrix()
A <- matrix(c(1:9), ncol = 3, byrow = TRUE)
A

B <- matrix(c(1:9), ncol = 3, byrow = FALSE)
B

## Seleção de elementos em uma matriz

# Seleção específica
A <- matrix(c(2,-1,3,
              1, 4, 1,
              5, -2, 7),
            ncol = 3,
            byrow = TRUE)
# Seleciona um elem na primeira linha e segunda coluna.
# Ou seja: -1
elemento_1_2 <- A[1,2]
elemento_1_2

# Seleciona um elem na primeira linha e segunda coluna.
# Ou seja: 7
elemento_3_3 <- A[3,3]
elemento_3_3

# Podemos selecionar linhas ou colunas inteira
# Seleção de colunas
coluna_2 <- A[, 2]
# Note que o display vai ser na horizontal
# então, não se engane
coluna_2

linha_1 <- A[1, ]
linha_1

# Seleção condicional
# Podemos usar a função which() para selec itens
# com base em condições
elementos_maior_que_3 <- B[which(B > 3)]
elementos_maior_que_3

# Seleção de elem ímpares
elementos_impares <- B[which((B %% 2) != 0)]
elementos_impares

# Seleção de elem negativos da segunda coluna
elementos_negativos_coluna_2 <- A[, 2][which(A[, 2] < 0)]

## Remoção de linhas/colunas A[-lin, -col]
# Remove a terceira coluna da matriz
A_sem_terceira_coluna <- A[, -3]
A_sem_terceira_coluna

A_sem_primeiras_duas_linhas <- A[-(1:2), ]
A_sem_primeiras_duas_linhas

# Remove a primeira linha e a segunda coluna
A_sem_linha_coluna <- A[-1, -2]
A_sem_linha_coluna

### Operações matriciais
# Para realizar adição e e subtração de matrizes as
# dimensões das matrizes devem ser compatíveis.
A <- matrix(c(4, -3, 7,
              10, 1, 1,
              -5, 2, 3),
            ncol = 3,
            byrow = TRUE)
dim(A) # Retorna as dimensões da matriz

B <- matrix(c(2, -1, 3,
              1, 4, 1,
              5, -2, 7),
            ncol = 3,
            byrow = TRUE)
dim(B)

# Soma de matrizes
soma <- A + B
soma
dim(soma)

# Subtração de matrizes
subtracao <- A - B
subtracao
dim(subtracao)

## Soma de linhas e coluna colSums(A)/rowSums(A)
# Soma das colunas de A
soma_colunas_A <- colSums(A)
soma_colunas_A

# Soma das linhas de A
soma_linhas_A <- rowSums(A)
soma_linhas_A

## Médias das coluna/linhas colMeans()/rowMeans()
media_colunas_A <- colMeans(A)
media_colunas_A

media_linhas_B <- rowMeans(B)
media_linhas_B

## Multiplicação por escalar k(A)
k <- 2
multiplicacao_escalar <- k * A
multiplicacao_escalar

## Produto elemento a elemento (A * B)
# para realizar esta operação as dim das
# matrizes devem ser identicas
produto_elemento_a_elemento <- A * B
produto_elemento_a_elemento

## Produto matricial (A %*% B)
# novamente, as matrizes devem ter dim
# compatíveis para realizar a operação
produto_matricial <- A %*% B
produto_matricial

## Transposta t(A)
transposta_A <- t(A)
transposta_A

## Determinante det(A)
determinante_A <- det(A)
determinante_A

## Inversa solve(A)
inversa_A <- solve(A)
inversa_A

## Diagonal de uma matriz diag(A)
A
diag(A)

# Podemos alterar os elementos da diagonal principal de uma matriz
# usando a função diag()
A
valor_diag <- diag(A) <- 0
valor_diag
A
diag(A)

## Autovalores e autovetores eigen(A)
A
autovalores_autovetores_A <- eigen(A)
autovalores_autovetores_A

## Produto matricial transposto crossprod(A, B)
# Esse também é chamado de produto matricial interno
# é denotado também por A^t * B
produto_transposto <- crossprod(A, B)
produto_transposto

# Produto matricicial externo A * B^t
produto_transposto_t <- tcrossprod(A, B)
produto_transposto_t

# Nomes de linhas e colunas
# rownames(A) colnames(a)
# as funções acima permite atribuir nomes a linhas e colunas
# de uma matriz
rownames(A) <- c("Linha1", "Linha2", "Linha3")
colnames(A) <- c("Coluna1", "Coluna2", "Coluna3")
A

## Matrizes triangulares no R
# upper.tri() e lower.tri()
# as funções acima são bem fáceis de interpretar
# ambas retornam uma matriz de valores booleanos
# referentes a qual região triangular da matriz é
# verdadeira
upper_elements <- upper.tri(A)
upper_elements

lower_elements <- lower.tri(A)
lower_elements

# Caso queira retornar os elementos
A[upper.tri(A)]
B[lower.tri(B)]


# Identificando elementos abaixo/acima da diagonal principal
lower_elements <- lower.tri(A, diag = TRUE)
lower_elements

A[lower.tri(A, diag = TRUE)]

## Arrays
# são estruturas multidimensionais para armazenar
# e manipular dados em várias dimensões.

# Para criar um array usamos array()
# criando um array 2X3X4
arr <- array(1:24, dim = c(2, 3, 4))
arr

# acessando elementos de um array
# Para acessar o elemento na segunda linha,
# terceira coluna e quarta "dimensão" de um array
elemento <- arr[2,3,4]
elemento

# para acessar todos os elementos da primeira dimensão
arr[, , 1]

## Podemos realizar operações entre arrays
# soma - subtracao
# Multiplicação por escalar
# Produto elemento a elemento
# Operações estatísticas sum(), mean(), max() e min()
# podem ser aplicador aos elementos do array,
# opcionalmente especificando a dimensão.
arr1 <- array(1:12, dim = c(3, 2, 2))
arr2 <- array(13:24, dim = c(3, 2, 2))

# soma de array
soma <- arr1 + arr2
soma

# produto elem a elem
produto <- arr1 * arr2
produto

# média ao longo da dimensão 3
media <- mean(arr1, dim = 3)
media

### Dataframes
# estruturas bidimensionais que podem armazenar diferentes tipos de dados
# exemplo
# Exemplo de criação de Data Frame
meu_data_frame <- data.frame(
    nome = c("Alice", "Bob", "Carol",
             "Ana", "João", "Carlos", "Patrícia", "Leonardo"),
    idade = c(25, 30, 28, 20, 27, 50, 60, 45),
    salario = c(5000, 6000, 5500, 8000, 2000, 3500, 10000, 3800 ), 
    meio_de_transporte = c("onibus", "bicicleta", "onibus",
                         "carro", "carro", "onibus",
                         "onibus", "bicicleta"))

## Nomes de colunas do nosso data.frame não possuem espaço, podem ser separadas por "." ou "_".

meu_data_frame

## para termos uma visão geral do dataframe podemos usar str()
str(meu_data_frame)

# para termos as dimensões do df
dim(meu_data_frame)

# acessando colunas usando operador $
meu_data_frame$nome

# acessando colunas usando colchetes
meu_data_frame[, "idade"]

## Adicionando variáveis (colunas)
# podemos fazer isso da seguinte forma
meu_data_frame$genero <- c("F", "M", "F", "F", "M", "M", "F", "M")
meu_data_frame[, "genero"]
meu_data_frame$genero

## subconjunto de dataframes
# Podemos fazer isso de duas formas
# usando subset() ou []

# Exemplo com []
subconjunto_df <- meu_data_frame[meu_data_frame$idade > 28, ]
subconjunto_df

# usando subset
subconjunto_df <- subset(meu_data_frame, idade > 28)
subconjunto_df

# outros exemplos mais compostos
subconjunto_combinado <-
    meu_data_frame[meu_data_frame$idade > 25 & meu_data_frame$idade < 30, ]
subconjunto_combinado

## Função summary()
# essa função retorna alguns resumos estatísticos das variáveis
# do nosso dataframe
summary(meu_data_frame)

## Função by()
# função by() é usada para aplicar uma função a subconjuntos de um
# df, com base em uma ou mais variáveis. É util paara relizar operações
# em grupos de dados

# Exemplo
resultado <- by(meu_data_frame$salario, meu_data_frame$idade, mean)
resultado

# Exemplo
resultado <- by(meu_data_frame$salario, meu_data_frame$genero, mean)
resultado

## Fatores
# é uma estrutura de dados especial de dados para representar
# variáveis categóricas
# Criando fatores
genero <- factor(c("Masculino", "Feminino", "Masculino", "Feminino"))
genero

# Exemplo com diferentes níveis
estadiamento_doenca <- factor(c("Estágio I", "Estágio II", "Estágio I", "Estágio III", "Estágio IV"), 
                              levels = c("Estágio I", "Estágio II", "Estágio III", "Estágio IV"))

estadiamento_doenca

## Transformação em fatores
# podemos transformar as variáveis em nosso dataframe em fatores
meu_data_frame$genero
meu_data_frame$genero <- as.factor(meu_data_frame$genero)
meu_data_frame$genero # convertido em factor


## Níveis de fatores
# Definindo fator com níveis específicos
cores <- factor(c("Vermelho", "Verde", "Azul"),
                levels = c("Vermelho", "Verde", "Azul", "Amarelo"))
cores


## Acessando níveis e valores de fatores
# temos as seguintes funções levels() e nlevels()
# levels() irá retornar o vetor de valores dos fatores
niveis_cores <- levels(cores)
niveis_cores

# nlevels() serve para acessar o numeros de níveis do fator
n_niveis_cores <- nlevels(cores)
n_niveis_cores

# Acessar valores do fator
valores_cores <- cores
valores_cores

## Tabelas de dupla entrada
# Conhecido como tabelas de contingência
# mt util para analisar a relação entre variáveis categóricas

# Exemplo
sexo <- c("Masculino", "Feminino", "Masculino", "Masculino", "Feminino")
cidade <- c("A", "B", "A", "B", "A")
tabela_contingencia <- table(sexo, cidade)
tabela_contingencia

tabela_contingencia2 <- table(meu_data_frame$meio_de_transporte,
                              meu_data_frame$genero)
tabela_contingencia2

# exibição formatada da tabela
# print(tabela_contingencia)
tabela_formatada <- ftable(tabela_contingencia)
tabela_formatada

## Analisando tabelas de dupla entrada
# obter as marginais
marginais_linhas <- margin.table(tabela_contingencia, 1) # soma da linhas
marginais_linhas
marginais_colunas <- margin.table(tabela_contingencia, 2) # soma das colunas
marginais_colunas

# Teste do Qui-Quadrado
qui_quadrado <- chisq.test(tabela_contingencia)
qui_quadrado

## Proporções relativas
# prop.table() calcula proporções relativas dentro das categorias
proporcoes_relativas_linha <- prop.table(tabela_contingencia, margin = 1)
proporcoes_relativas_linha

proporcoes_relativas_coluna <- prop.table(tabela_contingencia, margin = 2)
proporcoes_relativas_coluna


## Exercicios
queimadas_Q1 <- read.csv("./datasets/firewatch/Dataset_FireWatch_Brazil_Q1_2024.csv")
queimadas_Q2 <- read.csv("./datasets/firewatch/Dataset_FireWatch_Brazil_Q2_2024.csv")
queimadas_Q3 <- read.csv("./datasets/firewatch/Dataset_FireWatch_Brazil_Q3_2024.csv")
queimadas_Q4 <- read.csv("./datasets/firewatch/Dataset_FireWatch_Brazil_Q4_2024.csv")

queimadas <- rbind(queimadas_Q1, queimadas_Q2, queimadas_Q3, queimadas_Q4)
dim(queimadas)

## Para os dados de Queimadas faça o que se pede.

## Imprima na tela as 9 primeiras observações.
print(queimadas[1:9, ])

## Imprima as últimas 3 observações.
# O rev() tem um comportamento de inveter a ordem das colunas
# ridiculo hahahaha
print(tail(queimadas, n = 3)) 

## Quantas observações temos?
n_observacoes <- nrow(queimadas)
print(n_observacoes)

## Quantas variáveis temos?
n_colunas <- ncol(queimadas)
print(n_colunas)

## Apresente o sumário dos dados.
sumario_queimadas <- summary(queimadas)
print(sumario_queimadas)

## Apresente a estrutura dos dados.
str(queimadas)

## Quantos biomas estão sendo afetados?

print(unique(queimadas$bioma))
class(queimadas$bioma)

# convertendo biomas para factor
queimadas$bioma <- as.factor(queimadas$bioma)
levels(queimadas$bioma)

## Qual a média de avg_numero_dias_sem_chuva para os estados da região sul e da região norte?
## estados <- unique(queimadas$estado)
## length(estados)
## sort(estados)

#---------------------------
# Essa é uma solução elegante
media_dias_sem_chuva <- by(queimadas$avg_numero_dias_sem_chuva, queimadas$estado, mean)
media_dias_sem_chuva

# Outra forma de fazer a questão
# Obs: essa é a forma FEIA
#---------------------------

# Região Norte
media_acre <- mean(subset(queimadas$avg_numero_dias_sem_chuva, queimadas$estado == "ACRE"))
media_acre
media_amapa <- mean(subset(queimadas$avg_numero_dias_sem_chuva, queimadas$estado == "AMAPÁ"))
media_amapa
media_amazonas <- mean(subset(queimadas$avg_numero_dias_sem_chuva, queimadas$estado == "AMAZONAS"))
media_amazonas
media_para <- mean(subset(queimadas$avg_numero_dias_sem_chuva, queimadas$estado == "PARÁ"))
media_para
media_rondonia <- mean(subset(queimadas$avg_numero_dias_sem_chuva, queimadas$estado == "RONDÔNIA"))
media_rondonia
media_roraima <- mean(subset(queimadas$avg_numero_dias_sem_chuva, queimadas$estado == "RORAIMA"))
media_roraima
media_tocantins <- mean(subset(queimadas$avg_numero_dias_sem_chuva, queimadas$estado == "TOCANTINS"))
media_tocantins

# Região Sul
media_parana <- mean(subset(queimadas$avg_numero_dias_sem_chuva, queimadas$estado == "PARANÁ"))
media_parana
media_rgs <- mean(subset(queimadas$avg_numero_dias_sem_chuva, queimadas$estado == "RIO GRANDE DO SUL"))
media_rgs
media_sc <- mean(subset(queimadas$avg_numero_dias_sem_chuva, queimadas$estado == "SANTA CATARINA"))
media_sc

media_norte <- mean(c(media_acre, media_amapa, media_amazonas, media_para, media_rondonia, media_roraima, media_tocantins))
media_sul <- mean(c(media_parana, media_rgs, media_sc))

media_regioes <- data.frame(
    regioes = c("NORTE", "SUL"),
    medias = c(media_norte, media_sul))
print(media_regioes)
#---------------------------

## Essa é uma boa solução
#---------------------------
reg_norte <- c("ACRE", "AMAPÁ", "AMAZONAS", "PARÁ", "RONDÔNIA", "RORAIMA", "TOCANTINS")
reg_sul <- c("PARANÁ", "RIO GRANDE DO SUL", "SANTA CATARINA")
medias_reg_norte <- queimadas[queimadas$estado %in% reg_norte, ]
medias_reg_sul <- queimadas[queimadas$estado %in% reg_sul, ]

media_regioes2 <- data.frame(
    regioes = c("NORTE", "SUL"),
    medias = c(mean(medias_reg_norte$avg_numero_dias_sem_chuva), mean(medias_reg_sul$avg_numero_dias_sem_chuva)))
print(media_regioes2)

## Essa é uma pouco mais refinada
# usando a funcao subset
#---------------------------
reg_norte <- c("ACRE", "AMAPÁ", "AMAZONAS", "PARÁ", "RONDÔNIA", "RORAIMA", "TOCANTINS")
reg_sul <- c("PARANÁ", "RIO GRANDE DO SUL", "SANTA CATARINA")
medias_reg_norte <- subset(queimadas, estado %in% reg_norte, select = avg_numero_dias_sem_chuva)
medias_reg_sul <- subset(queimadas, estado %in% reg_sul, select = avg_numero_dias_sem_chuva)

media_regioes3 <- data.frame(
    regioes = c("NORTE", "SUL"),
    medias = c(mean(medias_reg_norte$avg_numero_dias_sem_chuva), mean(medias_reg_sul$avg_numero_dias_sem_chuva)))
print(media_regioes3)


##
require(tibble)
require(magrittr)
require(dplyr)

## Tibble
# é tipo um data(frame/table) só que melhor.

meu_tibble <- tibble(
    nome = c("Alice", "Bob", "Carol", "Ana", "João", "Carlos", "Patrícia", "Leonardo"),
    idade = c(25, 30, 28, 20, 27, 50, 60, 45),
    salario = c(5000, 6000, 5500, 8000, 2000, 3500, 10000, 3800 ), 
    meio_de_transporte = c('onibus', 'bicicleta', 'onibus', 'carro', 'carro', 'onibus', 'onibus', 'bicicleta'))
glimpse(meu_tibble)

# Criando nova coluna
meu_tibble$nova_coluna <- c(1, 2, 3, 4, 5, 6, 7, 8)
meu_tibble$nova_coluna

# é possível criar uma coluna com espaços
meu_tibble <- mutate(meu_tibble, `minha coluna`  = 1:8) 
# um rename de coluna para idade >>> idade_anos
meu_tibble <- rename(meu_tibble, idade_anos = idade)
meu_tibble

## seleção omitindo certa colunas
meu_tibble_sem_salario <- select(meu_tibble, -salario)

# podemos filtrar e ordenar
resultado <- filter(meu_tibble, idade_anos > 25)
resultado

# agrupamento de dados
agregado_por_idade <- group_by(meu_tibble, idade_anos)
summarize(agregado_por_idade, media_salario = mean(salario))

### Listas
# pense numa estrutra de dados versatil.
# Exemplo de criação de lista

minha_lista <- list(
  vetor = c(1, 2, 3, 4, 5),
  matriz = matrix(1:9, nrow = 3),
  data_frame = data.frame(
    nome = c("Alice", "Bob", "Carol"),
    idade = c(25, 30, 28)
  ),
  lista_aninhada = list(
    vetor_aninhado = c(10, 20, 30),
    matriz_aninhada = matrix(1:4, nrow = 2)
  )
)
minha_lista

## assim como nas outra estruturas de dados
# podemos acessar os dados atraves de colchetes
# ou usando $
elemento1 <- minha_lista[[1]]
elemento1

elemento2 <- minha_lista$data_frame
elemento2

elemento3 <- minha_lista$lista_aninhada$vetor_aninhado
elemento3

## um exemplo de adição de elementos feita de forma complexa
minha_lista$nova_lista <- list(novo_vetor = c(1,2,3), nova_matriz = matrix(1:4, nrow = 2))
minha_lista
