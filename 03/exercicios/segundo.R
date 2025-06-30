## ---
## Nome: "Joaquim Almeida"
## GRR:
## Data:
## Disciplina: 
## ---

rm(list = ls())

# Pacotes necessários
require(data.table)
require(dplyr)
require(magrittr)
require(tidyverse)

#----------------------------------
# Questão 1
#----------------------------------

variancia_amostral <- function(x, na.rm = FALSE) {
    variancia <- function(x) sum((x - mean(x))^2) / (length(x) - 1)    
    if(na.rm == TRUE && any(is.na(x)) == TRUE)
        return(variancia(na.omit(x)))   
    else 
        return(variancia(x))
}

desvio_medio_abs <- function(x, na.rm = FALSE) {
    dam <- function(x) (sum(abs(x - mean(x))) / (length(x) - 1))
    if(na.rm == TRUE && any(is.na(x)) == TRUE)
        return(dam(na.omit(x)))   
    else 
        return(dam(x))
}

segun_coef_assime_pearson <- function(x) 3 * ((mean(x) - median(x)) / sqrt(variancia_amostral(x)))

# Carregar o dataset
data(airquality)

# (a) A S^2 da variável Ozone é 823,31.
# R >>> FALSE
ozone <- na.omit(airquality$Ozone)
variancia_amostral(ozone) # :1088.201

# (b) Considerando apenas o nível 8 da variável Month,
# o DMA da variável Wind é 2,75.
# R >>> TRUE
month_wind <- airquality %>%
    filter(Month == 8) %>%
    select(Wind)

month_wind %<>% na.omit(month_wind)
desvio_medio_abs(month_wind$Wind) # :2.746452

# (c) Para todas as variáveis do banco airquality a variância
# amostral é maior do que o desvio médio absoluto.
# R >>> TRUE

var_df <- sapply(airquality, FUN = variancia_amostral, na.rm = TRUE)
dam_df <- sapply(airquality, FUN = desvio_medio_abs, na.rm = TRUE)

sum(var_df) >= sum(dam_df) # : TRUE

# (d) O DMA da variável Ozone é 812,62.
# R >>> FALSE
desvio_medio_abs(ozone) # : 26.57931

# (e) No nível 8 da variável Month, o AS2 da variável Wind é 0,18.
# R >>> TRUE
segun_coef_assime_pearson(month_wind$Wind) # :0.1799931

#----------------------------------
# Questão 2
#----------------------------------

A <- matrix(c(3,  -3,   6,  -8,
              1,   2, -10,  -7,
              8,  -2,  -9,  -4,
              10, -5,  -1,   7),
            nrow = 4,
            byrow = TRUE)

B <- matrix(c(-1,  8,   13, -16,
               0,  16,  18, -6,
              11, -12, -13,  3,
              -4,  5,  -19,  17),
            nrow = 4,
            byrow = TRUE)

C <- matrix(c(-22, 14, 21, 19,
              23, -20, -17, 17,
              24, -14, -5, 8),
            nrow = 4,
            byrow = TRUE)


# funções para se divertir
eh_primo <- function(x) {
  if (x == 2) {
    return(TRUE)
  }
  if (x <= 1) {
    return(FALSE)
  }
  for (i in 2:(x-1)) {
    if (x %% i == 0) {
      return(FALSE)
    }
  }
  return(TRUE)
}

eh_quadrado_perfeito <- function(x) {
    if(x <= 0) return(FALSE)
    raiz <- sqrt(x)
    return(raiz == floor(raiz))
}

cuberoot <- function(x) (x^(1/3))

## cuberoot(125)
## eh_primo(A[2,2])

varrer_matrix <- function(m) {
    n_primos <- 0
    resultado <- matrix(0, nrow = nrow(m), ncol = ncol(m))
    for(i in 1:nrow(m)) {
        for(j in 1:ncol(m)) {
            if(eh_primo(m[i,j])) {
                m[i,j] <- m[i,j] * 8
                n_primos <- n_primos + 1
                next
            }
            if(eh_quadrado_perfeito(m[i,j])) {
                m[i,j] <- m[i,j] - 19
                if(m[i,j] < 0) {
                    m[i,j] <- m[i,j] ^ 7
                    next
                }
                next
            }
            if(m[i,j] < 0) {
                m[i,j] <- cuberoot(abs(m[i,j]))
                next
            }
        }
    }
    
    return(list(resultado = m, contagem_primos = n_primos))
}

## varrer_matrix(A)
## varrer_matrix(B)
## varrer_matrix(C)

# (a) A matriz A tem 2 números primos.
# R >>> FALSE

mA <- varrer_matrix(A)
mA$contagem_primos # :3

# (b) A soma dos elementos da diagonal
# principal da matriz B transformada é -2162.
# R >>> FALSE

mB <- varrer_matrix(B)
sum(diag(mB$resultado)) # :-2047.649

# (c) A matriz C transformada é dada por:
# | 7,33  | 14,00| 21,00 | 152
# | 184,00| 6,67 | 5,67  | 136
# | 2,33  | 3,67 | 7,67  | 28
# | 24,00 | 4,67 | 1,67  | 8
# R >>> FALSE

# (d) O maior elemento, em módulo, da matriz C transformada é 184.
# R >>> TRUE

mC <- varrer_matrix(C)
max(abs(mC$resultado)) # :184

# (e) A soma dos elementos da coluna 2 da matriz B transformada é -2130.
# R >>> FALSE

mB <- varrer_matrix(B)
round(sum(mB$resultado[, 2], 0)) # :-2130

#----------------------------------
# Questão 3
#----------------------------------

numero_base <- function(data) {
    passo1 <- str_split(data, "/", simplify = TRUE)
    passo2 <- str_c(passo1, collapse = "")
    passo3 <- str_split(passo2, "", simplify = TRUE)
    passo4 <- as.integer(passo3)
    passo5 <- sum(passo4)
    passo6 <- str_split(passo5, "", simplify = TRUE)
    passo7 <- as.integer(passo6)
    passo8 <- sum(passo7)
    num_base <- passo8
    return(num_base)
}

numerol_individual <- function(x) ((x^2) + (7 * x) + 2)

numerol_casal <- function(x, y) (x^2 + y^7)

## data <- "12/10/2008"
## numero_base(data)

astro_individuo <- fread("datasets/Astrologia_Individuo.txt")
astro_casal     <- fread("datasets/Astrologia_Casal.txt")


astro_individuo <- as_tibble(astro_individuo)
astro_casal <- as_tibble(astro_casal)
names(astro_individuo) <- c("data_nascimento")
names(astro_casal)     <- c("data_nascimento_x", "data_nascimento_y")

# (a) Existem 97 casais com Número Base 6, e 233 casais com essa
# numerologia para Casal.



# (b) A Numerologia do Indivíduo, de um indivíduo nascido em 13/10/2008 é 5.
# R >>> FALSE

nasc_individuo <- astro_individuo[grepl("13/10/2008", astro_individuo$data_nascimento), 1]
numero_base_individuo <- numero_base(nasc_individuo)
numero_base_individuo # :6

# (c) Um indivíduo nascido em 1/9/1993 apresenta Número Base igual à 5.
# R >>> TRUE
nasc_individuo <- astro_individuo[grepl("1/9/1993", astro_individuo$data_nascimento), 1]
numero_base_individuo <- numero_base(nasc_individuo)
numero_base_individuo # :5

# (d) Existem 122 indivíduos com o Número Base 7, e 89
# indivíduos com essa numerologia individual.

# (e) O Número para Casal, com indivíduos nascidos em 31/7/2010
# e 23/12/1998 é 13
