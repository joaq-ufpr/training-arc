7### Programando em R

## Operadores Aritméticos

x <- 10
y <- 5

# + (Adição)
soma <- x + y
soma

# - (Subtracao)
subtracao <- x - y
subtracao

# * (Multiplicação)
multiplicacao <- x * y
multiplicacao

# / (Divisão)
divisao <- x / y
divisao

# ^ ou ** (Exponenciaçao)
exponenciacao <- x**2
exponenciacao_2 <- x^2
exponenciacao
exponenciacao_2

# %% (Modulo)
modulo <- x %% y
modulo

# %/% (Divisão Inteira)
divisao_inteira <- x %/% y
divisao_inteira

## Operadores Relacionais

a <- 10
b <- 20

# == (Igual a)
igual_a <- a == b
igual_a

# != (Diferente de)
diferente_de <- a != b
diferente_de

# > (Maior que)
maior_que <- a > b
maior_que

# < (Menor que)
menor_que <- a < b
menor_que

# >= (Maior que)
maior_ou_igual_a <- a >= b
maior_ou_igual_a

# <= (Menor igual)
menor_igual_a <- a <= b
menor_igual_a

## Resumo de Operadores

# Operações matemática
1 + 1   # Soma
2 - 1   # Substração
3 * 2   # Multiplicação
4 / 2   # Divisão
5 ^ 2   # Potenciação
5 %% 2  # Resto da divisão
5 %/% 2 # Divisão inteira

# logaritmo
log(10)            # Log natural
exp(10)            # Exponencial
log10(100)         # Logaritmo base 10
log2(10)           # Log base 2
log(100, base = 8) # Log. base 8

# Funções Trigonométricas
sin(0)  # Seno
cos(0)  # Cosseno
tan(0)  # Tangente
asin(0) # Arco seno
acos(0) # Arco cosseno
atan(0) # Arco tangente

# Funções de arredondamento 
round(pi, digits = 5) # Arredondamento
ceiling(pi) # Arredonda para "cima"
floor(pi) # Arredonda para "baixo"
trunc(pi) # "Trunca" o valor, ou seja tira a virgula

## Operações Lógicas
1 == 1 # Igual
1 != 2 # Diferente
1 > 2  # Maior
1 < 2  # Menor
1 >= 1 # Maior que
1 <= 1 # Menor que
a <- 1
b <- 2
a <= b

# Operadores lógicos
(1 == 1) & (2 == 2) # E / AND
(1 == 1) | (2 == 3) # OU / OR
!(1 == 2) # NEGAÇÃO / NOT

## Tipos Especiais
NA         # Valores Ausente: Not Available
NaN        # Not a Number
Inf & -Inf # Infinito
NULL # Valor nulo(vazio)

# Exemplos
NA + 5 # Retorna NA
is.na(NA + 5) # Verifica se é NA

10 + NULL # Retorna um objeto vazio
is.null(10 + NULL) # Verifica se é NULL

0/0 # Retorna NaN
is.nan(0/0) # Verifica se é NaN

1/0 # Retorna infinito
is.infinite(1/0) # Verifica se é infinito
is.finite(1/0)   # Verifica se é finito

## Strings
"R" == "r" # Comporação de strings
"a" < "b"  # Ordem Alfanumérica
"1" < "2"  # Idem

## Vetores em R
# Algumas infos sobre vetores
# Homogeneidade: Ou seja todos os elementos
# tem de ser do mesmo tipo

# Para criar um vetor podemos usar a função c() (combine)
# ou a função vector()

vetor_numerico <- c(1,2,3,4,5)
vetor_numerico

# Criar um sequencia
sequencia_1_a_5 <- seq(1:5)
sequencia_1_a_5

sequencia_10_a_100 <- seq(from = 10, to = 100, by = 5)
sequencia_10_a_100

# Para acessar elementos em um vetor no R usamos seu indice
vetor_numerico[5]

# Operações com vetores

# Podemos multiplicar o vetor por um escalar
vetor_resultado <- vetor_numerico * 2
vetor_resultado

# Ou mesmo aplicar funções sobre vetores
mean(vetor_numerico) # mean() função média do R

# Podemos "fatiar" os vetores também
vetor_numerico[2:4]

sequencia_10_a_100[3:8] # Note que estamos lidando com os indices do vetor

# Vetores não são exclusivos para números
# Podemos criar vetores de caracteres
vetor_caracteres <- c("maça", "banana", "laranja")
vetor_caracteres

# Mais alguns exemplos
numeros <- c(1,2,3,4,5)
numeros

letras <- c("a", "b", "c", "d", "e")
letras

logicos <- c(TRUE, FALSE, TRUE, FALSE)
logicos

# Coerção
vetor <- c(numeros, letras, logicos)
vetor # Note como os valores foram convertidos para string


# Acessando o primeiro elemento
numeros[1]

# acessa o terceiro elemento
letras[3]

# Acessa o segundo elemento
logicos[2]

# Acessa o quinto elemento
vetor[5]

# Acessa o segundo ao quarto elemento
vetor[2:4]

# Exemplos de uso de operadores aritméticos e relacionais
# sobre os vetores
vetor1 <- c(1, 2, 3)
vetor2 <- c(4, 5, 6)

# Soma de vetores
soma_vetores <- vetor1 + vetor2
soma_vetores

# Subtração de vetores
subtracao_vetores <- vetor1 - vetor2
subtracao_vetores

# Multiplicacao de vetores
multiplicacao_vetores <- vetor1 * vetor2
multiplicacao_vetores

# Divisão de vetores
divisao_vetores <- vetor1 / vetor2
divisao_vetores

# Exponenciacao de vetores
exponenciacao_numero <- vetor1 ^ 2
exponenciacao_numero

# Exponenciacao por outro vetor?
expo_expo <- vetor1 ^ vetor2
expo_expo


# Modulo de vetor
modulo_numero <- vetor1 %% 3
modulo_numero

# Modulo por outro vetor?
modu_modu <- vetor1 %% vetor2
modu_modu

## Tipos de vetores

# numeric
class(c(1.2, 2.5, 3.14))

# integer
class(c(1,2,3,4,5))

# logical
class(c(TRUE, FALSE, TRUE))

# complex
class(c(1 + 2i, 2 + 0i))

# character
class(c("a", "b", "c"))

# factor
class(factor("Tipo 1", "Tipo 2", "Tipo 3"))

# Alem da função class para descobrirmos os tipos de
# dados que estamos trabalhando, podemos utilizar as
# funções com inicio 'is.()' para retornar um valor
# booleano referente ao tipo do dado.

# verifica se é inteiro
is.integer(numeros) 

# verifica se é numerico
is.numeric(numeros)

# verifica se é caracter
is.character(letras)

# verifica se é lógico
is.logical(logicos)

# Verifica se é fator
fator <- factor(c("tipo 1", "tipo 2", "tipo 3"))
is.factor(fator)

# para ver todas a funções que começam com "is.()"
apropos("^is\\.")

## Conversão de tipo
# O R possui funções no qual é possível fazer
# um "recast" da variavel, ou seja, mudar o
# tipo do mesmo

# Converte o valores dos vetor em character
as.character(numeros)

# Converte factor para numeric
as.numeric(fator)

# Converte string para data
datas <- c("2021-01-01", "2021-01-02", "2021-01-03")
class(datas)
class(as.Date(datas))

# para ver todas a funções que começam com "as.()"
apropos("^as\\.")


## Métodos
# Esse comando retorna metodos referentes aos tipos dados especificados.
methods(class = "numeric")
methods(class = "character")

# Podemos criar um vetor numerico com nomes
altura <- c("João" = 1.82,
            "Bianca" = 1.68,
            "Eduarda" = 1.62)
class(altura)
attributes(altura)

## Mais sobre criação vetores
# Vetores podem ser criados de varias formas.
# Vimos a função c() e seq() e rep()

# Sendo c() o mais simples para combinar valores
cezinho <- c(1,2,3)
cezinho

# seq() serve para criarmos sequências de números
# no qual funciona da seguinte forma
# seq(from = x, to = y, by = z)

# sequencia de 1 a 10
seq1 <- seq(1,10)
seq1

# sequencia de 10 a 1 tomados 2 a 2
seq2 <- seq(from = 10, to = 1, by = -2)
seq2

# rep() serve para repetirmos valores
# ou gerar repetições
# essa função da seguinte forma
# rep(x, times = n)
# rep(x, each = n)

# repete 1, 2 e 3 tres vezes
rep1 <- rep(c(1,2,3), times = 3)
rep1

# repete cada item do vetor 3 vezes
rep2 <- rep(c(1,2,3), each = 3)
rep2

# Usando os time e each juntos?
# Não funciona, pois por default ele pega o each
rep3 <- rep(c(1,2,3), each = 3, times = 3)
rep3


## Números aleatorios
# Para gerar números aleatorios de um distro de prob
# podemos utilizar as seguintes funções
# runif(), rnorm() e sample()

# runif(x) gera números aleatorios de 0 a 1
# sendo x a qtd de numeros que sera gerado.
runif(5)

# rnorm(x) gera num aleatorios de uma normal com
# media 0 e desvio padrão 1
# o x aqui tem a mesma função do runif(x)
rnorm(5)

# sample() gera amostras aleatórias
sample(numeros, size = 3, replace = FALSE)
sample(letras, size = 5, replace = TRUE)

# Exemplos de uso operadores relacionais em vetores
vetor1 <- c(1,2,3,4)
vetor2 <- c(4,5,6,7)

# Igualdade
vetores_iguais <- vetor1 == vetor2
vetores_iguais

# Diferença
vetores_diferentes <- vetor1 != vetor2
vetores_diferentes

# Maior que
vetores_maior_que <- vetor1 > vetor2
vetores_maior_que

# Menor que
vetores_menor_que <- vetor1 < vetor2
vetores_menor_que

# Maior ou igual que
vetores_maior_ou_igual_que <- vetor1 >= vetor2
vetores_maior_ou_igual_que

# Menor ou igual que
vetores_menor_ou_igual_que <- vetor1 <= vetor2
vetores_menor_ou_igual_que

## Seleção posicional
alturas <- c("João" = 1.82,
             "Bianca" = 1.68,
             "Carlos" = 1.75,
             "Ana" = 1.70)
# Seleciona o primeiro elemento
alturas[1]

# Seleciona até o terceiro elemento
alturas[1:3]

# seleciona elementos 1, 3 e 4
alturas[c(1,3,4)]

# remove o segundo elemento
alturas[-2]


## Seleção condicional
# Alem de podermos acessar elemento do vetor a partir de seu índice
# também podemos realizar a seleção de forma condicional
# ou seja, podemos criar regras lógicas para acessar esses
# elementos

# Seleciona alturas maiores que 1.70
mascara_logica <- alturas > 1.70
alturas[mascara_logica]

# assim também funciona
alturas[altura > 1.70]

## Seleção por nome
# Se temos um vetor no qual possui nomes associados
# aos valores, podemos utilizar deste "nome" para
# acessar os elementos deste "nome"

# Seleciona a altura de João
alturas["João"]

# Seleciona as alturas do João e da Ana
alturas[c("João", "Ana")]

## Modificar ou adicionar elementos

# Modificar
# para fazer isso, podemos acessar o elemento
# pelo seu índice ou "nome" para realizar a mudança

# Modificar a altura do João
alturas["João"] <- 1.85
alturas[c("João")]

# Atribui altura desconhecida a Bianca
alturas["Bianca"] <- NA
alturas

# Remove a altura de carlos
alturas = alturas[-3]
alturas

# Adicionar
# Podemos adicionar elementos em um vetor
# utilizando a função append()
# ao usar append() o novo elemento é
# adicionado ao final do vetor
# é possível também adicionar em
# uma posição específica

# Adicionar a altura da Ivete
append(alturas, value = c("Ivete" = 1.60))
alturas


# Adiciona a altura de anderson no inicio
append(alturas, values = c("Anderson" = 1.75), after = 0)

# Concatena alturas
alturas2 <- c("Alana" = 1.70,
              "Rafael" = 1.80)
alturas <- c(alturas, alturas2)
alturas

# Alguns exemplos de atribuição
x <- 5
nome <- "João"
meus_animais <- c("gato", "cachorro", "cachorro")

nome
meus_animais
meus_animais[1] == meus_animais[3]

# Exemplos de funções matemáticas
dados <- c(10,15,20,25,30)
soma <- sum(dados)
media <- mean(dados)
mediana <- median(dados)
valor_maximo <- max(dados)
valor_minimo <- min(dados)
raiz_quadrada <- sqrt(dados)

# Funções de manipulação de dados
vetor3 <- c(4,7,2,4,1,5)
length(vetor3)
sort(vetor3) # Ordena do menor ao maior
rev(vetor3) # Reverte do o vetor.
unique(vetor3) # Retorna o vetor sem duplicatas


# Algumas operações estatísticas
y <- c(7, 5, 2, 2, 4, 8, 
       5, 2, 6, 4, 5, 10, 
       3, 2, 6, 10, 7, 8,
       6, 10, 3, 4, 5, 1)

# Número de elementos
length(y)
sum(y) # soma de elementos
mean(y) # média
median(y) # mediana
max(y) # maximo
min(y) # minimo
var(y) # variancia
sd(y) # desvio-padrão
mad(y, constant = 1) # desvio abs mediana
100 * sd(y) / mean(y) # coeficiente de variação
quantile(y) # Quartis
IQR(y) # Amplitude Interquantilica
table(y) # Tabela de frequencia

## Funções para criação de gráficos
vetor4 <- c(1:100)
vetor5 <- sqrt(vetor4)

# cria um gráfico de dispersao ou linhas
plot(x = vetor4, y = vetor5, las = 1, pch = 16)

# cria um histograma
hist(vetor4, las = 1)

# gráfico de linhas e pontos
x <- c(1,2,3,4,5)
y <- c(2,4,6,8,10)
plot(x, y, type = "b")

hist(x)

# Novamente as funções matemáticas
numero <- -5.8
valor_absoluto <- abs(numero)
arredondado <- round(pi)
teto <- ceiling(numero)
piso <- floor(numero)
cosseno <- cos(numero)
exponencial <- exp(numero)
soma_valores <- sum(c(1,2,3,4,5))
produto_valores <- prod(c(1,2,3,4,5)) # Multiplica todos os elementos

## Funções de manipulação de texto
# paste() concatena varias strings em uma única string
nomes <- c("Maria", "Ana", "Rafaela")

paste(nomes[1], "e", nomes[2], "são minhas amigas")
paste(nomes[1], nomes[2], nomes[3], sep = "|")
paste(nomes, collapse = " ")

# Deixa as strings com letras maiusculas
toupper(nomes)

# Deixa as string minusculas
tolower(nomes)

# substr()
# Extrai uma subcadeia de caracteres de uma string
# descarta os caracteres após a terceira letra
substr(x = nomes[1], start = 1, stop = 3)

# gsub()
# substitui padrões de string por outros valores
gsub(pattern = "G", replacement = "R", x = "Gato")

# Mais exemplos disso
nome1 <- "João"
nome2 <- "Maria"
# Concatenação de strings
frase <- paste("Olá ", nome1, "e", nome2)
frase
frase_upper <- toupper(frase)
frase_lower <- tolower(frase)

# Extrai a subcadeia "João e" e descarta o resto
subcadeia <- substr(frase, start = 6, stop = 11)
subcadeia

# Substitui "João" por "Pedro na frase"
frase_substituida <- gsub("João", "Pedro", frase)
frase_substituida

## Comando referentes a diretórios
# getwd() retorna o diretório atual
getwd()

# setwd() modifica a diretório de trabalho do R

# ls() lista todos os objetos do ambiente de trabalho atual
ls()

# list.files() lista os arquivos do diretório do wd
list.files()

## Funções para importação e exportação de dados e objetos

read.csv() #Importa dados de um arquivo CSV (Comma-Separated Values) e cria um dataframe. É um formato amplamente utilizado para armazenar dados tabulares.

read.table() # Importa dados de um arquivo de texto delimitado e cria um dataframe. Esse formato é útil quando os dados estão separados por caracteres específicos, como tabulações ou pontos e vírgulas.

read.xlsx() # (do pacote “readxl”): Importa dados de um arquivo Excel (.xlsx) e cria um dataframe. O formato Excel é amplamente utilizado para armazenar dados em planilhas.

write.csv() # Exporta um dataframe para um arquivo CSV, permitindo compartilhar os resultados em formato legível por outros softwares.

write.table() # Exporta um dataframe para um arquivo de texto delimitado, permitindo compartilhar os resultados de forma mais flexível.

## Funções para exploração de um conjunto de dados]

# Lista os datasets integrados disponíveis no R
data()

# Retorna as primeiras linhas de um dataframe
head()

# Retorna as ultimas linhas de um dataframe
tail()

# Retorna resumos estatísticos de um dataframe
summary()

# Exemplos
data(iris)
head(iris)
tail(iris)
summary(iris$Sepal.Width)
