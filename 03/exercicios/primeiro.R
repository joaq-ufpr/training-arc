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
# (#): representa o número de ingredientes no chocolate
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
# R >>> FALSE
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
# Existem 81 chocolates que incluem o ingrediente
# Adoçante em sua composição
# R >>> FALSE

# Verificação dos ingredientes
ingredientes <- chocolate %>%
    separate_rows(ingredientes, sep = ",") %>%
    select(ingredientes) %>%
    distinct(ingredientes) %>%
    arrange(ingredientes)

View(ingredientes)

chocolate %>%
    filter(str_count(ingredientes, "S\\*") > 0) %>%
    summarise(n = n()) # 76

#----------------------------------
# Questão 3
#----------------------------------

# Para esse exercício você deverá utilizar os banco de dados Art.csv.gz e
# Art_Moma.csv.gz. Desconsidere artistas sem nacionalidade e/ou sem nome.
# O dicionário das variáveis encontra-se disponível abaixo.

# | variável                   | descrição                                                                      |
# |----------------------------|--------------------------------------------------------------------------------|
# | artist_name                | O nome de cada artista                                                         |
# | edition_number             | O número da edição do livro.                                                   |
# | year                       | O ano de publicação de uma determinada edição do livro                         |
# | artist_nationality         | A nacionalidade de um artista.                                                 |
# | artist_nationality_other   | A nacionalidade do artista                                                     |
# | artist_gender              | O gênero do artista                                                            |
# | artist_race                | A raça do artista                                                              |
# | artist_ethnicity           | A etnia do artista                                                             |
# | book                       | Qual livro, “Janson” ou “Gardner”                                              |
# | space_ratio_per_page_total | A área em centímetros quadrados do texto e da figura de um determinado artista |
# | artist_unique_id           | O número de identificação exclusivo atribuído aos artistas                     |
# | moma_count_to_year         | O número total de exposições já realizadas pelo Museu de Arte Moderna (MoMA)   |
# | whitney_count_to_year      | O número de exposições realizadas pelo The Whitney                             |
# | artist_race_nwi            | O indicador de raça não branca para a raça do artista                          |

# Assinale todas as alternativas correta(s).

art      <- fread("datasets/Art.csv.gz")
art_moma <- fread("datasets/Art_Moma.csv.gz")

View(head(art))
View(head(art_moma))

teste_art <- art %>%
    inner_join(art, art_moma, by = c("artist_unique_id" = "artist_unique_id"))

View(teste_art)

# (a) Os 3 artista(s) com mais exposições no The Whitney
# classificados em ordem decrescente de exposições são:
# Edward Hopper, Georgia O’Keeffe e Stuart Davis.
# R >>> TRUE
top_artist_whitney <- art %>%
    inner_join(art_moma, by = "artist_unique_id") %>%
    select(artist_name, whitney_count_to_year, year) %>%
    group_by(artist_name) %>%
    summarise(soma_expo_whitney = sum(whitney_count_to_year)) %>%
    arrange(desc(soma_expo_whitney))

View(top_artist_whitney) # : Edward Hopper, Georgia O’Keeffe e Stuart Davis

# (b) Do total de artistas, 152 são Swiss, Mexican ou Japanese.
# R >>> FALSE
View(unique(art$artist_nationality))

# Rascunho
## art %>%
##     ## filter(artist_nationality == "Swiss") %>%
##     filter(grepl("Swiss|Mexican|Japanese", artist_nationality)) %>%
##     select(artist_name, artist_nationality) %>%
##     summarise(freq = n())

countries <- c("Swiss", "Mexican", "Japanese")

num_artist_nationality <- art %>%
    filter(artist_nationality %in% countries) %>%
    ## filter(grepl("(^-$)+ Swiss|Mexican|Japanese", artist_nationality)) %>% precisa ser refinado
    select(artist_nationality) %>%
    group_by(artist_nationality) %>%
    summarise(num_artists_by_nationality = n()) %>%
    arrange(desc(num_artists_by_nationality))
View(num_artist_nationality)

sum(num_artist_nationality$num_artists_by_nationality) # :26

# (c) Apenas 6 artista(s) com a nacionalidade Swiss tiveram entre 0 e 1
# exposições no The Whitney.
# R >>> FALSE
suicos_vencedores <- art %>%
    inner_join(., art_moma, by = "artist_unique_id") %>%
    filter(artist_nationality == "Swiss") %>%
    select(artist_name, whitney_count_to_year) %>%
    group_by(artist_name) %>%
    summarise(freq_ganho = sum(whitney_count_to_year)) %>%
    arrange(desc(freq_ganho))

suicos_vencedores %>%
    filter(freq_ganho < 2) %>%
    summarise(n = n()) # :5

# (d) A diferença entre a média de páginas para artistas
# Brancos e Não Brancos no ano de 2007 é -0,24.
# R >>> TRUE
View(art$artist_race_nwi)
class(art_moma$year)

art_moma_2007 <- art_moma %>%
    filter(year == 2007)

media_white <- art %>%
    inner_join(., art_moma_2007, by = "artist_unique_id") %>%
    filter(artist_race_nwi == "White") %>%
    summarise(media_white = mean(space_ratio_per_page_total, na.rm = TRUE))

media_non_white <- art %>%
    inner_join(., art_moma_2007, by = "artist_unique_id") %>%
    filter(artist_race_nwi != "White") %>%
    summarise(media_non_white = mean(space_ratio_per_page_total, na.rm = TRUE))

diferenca_medias <- media_non_white - media_white
diferenca_medias # :-0.242579

# (e) Dos artista(s) que expuseram no The Whitney,
# apenas 164 aparecem nos livros ‘Gardner’ e ‘Janson’.
# R >>> FALSE
unique(art_moma$book)
View(art_moma)

artist_gard_jan <- art %>%
    inner_join(., art_moma, by = "artist_unique_id") %>%
    filter(whitney_count_to_year > 0) %>%
    ## select() %>%
    group_by(artist_name) %>%
    summarise(n = n()) %>%
    nrow()

artist_gard_jan # :101

#----------------------------------
# Questão 4
#----------------------------------

# Para esse exercício você deverá utilizar os banco de dados
# refugiados_pais.csv.gz  e refugiados.csv.gz.
# Considere apenas observações completas.

# Assinale todas as alternativas correta(s).

refugiados      <- fread("datasets/refugiados.csv.gz")
refugiados_pais <- fread("datasets/refugiados_pais.csv.gz")

View(head(refugiados))
View(head(refugiados_pais))

## (a) A matriz de migração [origem, destino] intercontinental do ano 2006 é dada por:

# | Região   | Africa   | Americas | Asia     | Europe   | Oceania |
# |----------|----------|----------|----------|----------|---------|
# | Africa   | 2507581  | 262745   | 98175    | 250070   | 37124   |
# | Americas | 0        | 150149   | 0        | 14850    | 174     |
# | Asia     | 76780    | 308706   | 4411284  | 664075   | 42704   |
# | Europe   | 94       | 306672   | 7816     | 454237   | 3423    |
# | Oceania  | 0        | 1679     | 0        | 92       | 59      |


# (b) A partir de 1972 houveram 172075 refugiados partindo do país:
# Afghanistan para o país: Canada, e 219920 refugiados partindo do país:
# Pakistan para o país: Canada.

# (c) Os 5 países que mais enviaram refugiados no ano de 1965 pertencem
# às subregiões Sub-Saharan Africa e Southern Europe.

# (d) Os 6 países que mais receberam refugiados a partir de 1982
# receberam juntos 19523 refugiados.

# (e) Existem 27 países que receberam pelo menos 5382652 refugiados
