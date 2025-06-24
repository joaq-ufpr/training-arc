## ---
## Nome: "Joaquim Almeida"
## GRR:
## Data:
## Disciplina: 
## ---

rm(list = ls())

#----------------------------------
# Questão 1
#----------------------------------

# Considere as matrizes abaixo

A <- matrix(c(28, 32, 8, 9, 49,
              7, 21, 35, 28, 10,
              47, 43, 15, 34, 2,
              48, 42, 19, 32, 26,
              45, 44, 39, 50, 26),
              ncol = 5,
              byrow = TRUE)

B <- matrix(c(0,26, 3, 8, 30,
              35, 12, 19, 27, 27,
              27, 24, 12, 17, 29,
              31, 36, 40, 35, 8,
              24, 43, 31, 21, 39),
              ncol = 5,
              byrow = TRUE)

# E considere: C = (A*B^T)^-1 & P = B*(B^T * B)*B^T

C <- solve(A %*% t(B))
P <- B %*% (t(B) %*% B) %*% t(B)

# Assinale todas as alternativas correta(s).

# (a)
# Considere a matriz de projeção P.
# A soma de seus autovetores é dada por: -1,1193
# R >>> FALSE
eigen_P <- eigen(P)$vectors
soma_eigen_P <- colSums(eigen_P) # soma dos autovetores

soma_eigen_P
soma_autovetores_P_arredondada <- round(sum(soma_eigen_P), 4)
soma_autovetores_P_arredondada # -2.806

# (b)
# A soma dos valores absolutos da diagonal da matriz C é 0,0722.
# R >>> TRUE
soma_diag_principal_A <- sum(abs(diag(C)))
soma_diag_principal_A # 0.07224898

# (c)
# A soma de uma matriz triangular inferior para a matriz A é 233
# R >>> FALSE
diag_inferior_A <- A[lower.tri(A)]
diag_inferior_A

soma_diag_inferior_A <- sum(diag_inferior_A)
soma_diag_inferior_A # 384

# (d)
# O log10 do valor absoluto do determinante de A é 6,335. >>> TRUE
# O log10 do valor absoluto  do determinante de B é 6,7168. >>> TRUE
# O log10 do valor absoluto do determinante da matriz
# resultante do produto matricial entre A e B é 13,0518. >>> TRUE
log10(abs(det(A))) # 6.335031
log10(abs(det(B))) # 6.716753
log10(abs(det(A %*% B))) # 13.05178

# (e)
# O maior elemento da diagonal do inverso da matriz resultante
# do produto matricial entre A e o transposto de B é 0,026.
# R >>> FALSE
max(diag(solve(A %*% t(B)))) # 0.01596027

#----------------------------------
# Questão 2
#----------------------------------

# Para esse exercício você deverá utilizar o banco de dados
# chocolate.csv.gz. O dicionário das variáveis
# encontra-se disponível abaixo.

# | Variável        | Descrição                                         |
# |-----------------|---------------------------------------------------|
# | local_compania  | Região do Fabricante                              |
# | ano             | Ano da Revisão                                    |
# | origem_cacau    | País de Origem dos Grãos de Cacau                 |
# | cocoa_percent   | Percentagem de Cacau (% chocolate)                |
# | ingredientes    | Ingredientes                                      |
# | caracteristicas | Características mais memoráveis daquele chocolate |

# Lista de ingredientes:
# (#): representa o número de ingredientes no chocolat
# B: Grãos,
# S: Açúcar,
# S*: Adoçante diferente de açúcar de cana branco ou beterraba,
# C: Manteiga de Cacau,
# V: Baunilha,
# L: Lecitina,
# Sa: Sal

# Assinale todas as alternativas incorreta(s).
require(data.table)
require(dplyr)
require(magrittr)
require(tidyverse)

chocolate <- fread("./datasets/chocolate.csv.gz")

# (a)
# Existem 2443 países que produzem chocolate.
# R >>> FALSE
chocolate %>%
    distinct(origem_cacau) %>%
    summarise(n = n()) # 62


# (b)
# Existem 104 chocolates com 4 ingredientes que são descritos
# por 2 características.
# R >>> FALSE
chocolate %>%
    filter(grepl("4-", ingredientes) &
           lengths(str_split(caracteristicas, ",")) == 2) %>%
    summarise(n = n()) # 104

# Este abaixo está errado
## val1 <- str_count(chocolate$caracteristicas, ",") == 2

# Abaixo é um rascunho 
## val3 <- chocolate$caracteristicas[8] : "carac1, carac2"
## class(val3) : Char
## lengths(strsplit(val3, ",")) : 2
## View(chocolate$caracteristicas)

# (c)
# A frequência absoluta para chocolates que contenham 5 ingredientes é 750.
# R >>> FALSO
chocolate %>%
    filter(grepl("5-", ingredientes)) %>%
    summarise(n = n()) # 191

# (d)
# As 8 caracterististicas mais marcantes dos chocolates são
# sweet, nutty, cocoa, roasty, creamy, earthy, sandy e fatty
# e juntas correspondem a 1663 descrições dos chocolates.
# R >>> FALSO
carac_marcantes <- c("sweet", "nutty", "cocoa", "roasty",
                     "creamy", "earthy", "sandy", "fatty")

df_carac <- chocolate %>%
    separate_rows(caracteristicas, sep = ",") %>%
    filter(caracteristicas %in% carac_marcantes) %>%
    group_by(caracteristicas) %>%
    summarise(n = n()) %>%
    arrange(desc(n))

sum(df_carac$n) # 674

reg_pattern <- paste0("\\b(", paste(carac_marcantes, collapse = "|"), ")\\b")

df_regex <- df_carac %>%
    filter(grepl(reg_pattern, caracteristicas, ignore.case = TRUE)) %>%
    group_by(caracteristicas)

sum(df_regex$n) # 674
# (e)
# Existem 81 chocolates que incluem o ingrediente Adoçante em sua composição
