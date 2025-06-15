library(tidyverse)
require(dplyr)
require(magrittr)
library(data.table)
## install.packages("tidyverse")

# hj iremos usar o dplyr para brincar
dados <- readr::read_csv("datasets/archive/Brazil Total highway crashes 2010 - 2023.csv")
glimpse(dados)
car_crash <- dados

### Seleção de variáveis
# seleção pode nome de coluna
car_crash %>%
    select(data, tipo_de_acidente) %>%
    head()


# seleção por nome do coluna que inicie com alguma palavra
car_crash %>%
    select(starts_with("tipo")) %>%
    head()

# Mesmo exemplo acima, mas com outra função
car_crash %>%
    select(ends_with("feridos")) %>%
    head()
# Seleção de coluna que contenha alguma palavra ou caractere
car_crash %>%
    select(contains("mente")) %>%
    head()

# Podemos selecionar coluna por tipo
car_crash %>%
    select(where(is.numeric)) %>%
    glimpse()

car_crash %>%
    select(where(is.character)) %>%
    glimpse()

car_crash %>%
    select(where(is.logical)) %>%
    glimpse()

## Seleção por critérios
# temos as funções all_of() e any_of()

# all_of() todas as condições tem de ser atendidas
vars_interesse <- c("automovel", "bicicleta", "onibus")
car_crash %>%
    select(all_of(vars_interesse)) %>%
    glimpse()

# any_of() basta uma condição ser atendida
vars_interesse2 <- c("automovel", "bicicleta", "onibus", "trator")
car_crash %>%
    select(any_of(vars_interesse2)) %>%
    glimpse()

## Seleção de Observações
# vamos filtras obs com pelo menos 3 carros em acidentes
dados_filtrados <- car_crash %>%
    filter(automovel >= 3)
glimpse(dados_filtrados)

# Agora com 3 carros e 2 caminhoes
dados_filtrados <- car_crash %>%
    filter(automovel >= 3 & caminhao > 2)

# podemos omitir o operador &
dados_filtrados <- car_crash %>%
    filter(automovel >= 3, caminhao > 2)

dados_filtrados %>%
    glimpse()

# Agora com 3 carros OU 2 caminhoes
dados_filtrados <- car_crash %>%
    filter(automovel >= 3 | caminhao > 2)

dados_filtrados %>%
    glimpse()

## Filtro por intervalos
# podemos usar duas funções %in% e between()

# between()
dados_filtrados <- car_crash %>%
    filter(between(moto, lower = 4, upper = 8, incbounds = TRUE))

dados_filtrados %>%
    glimpse()

# %in%
autopistas <- c("Autopista Regis Bittencourt", "Autopista Litoral Sul", "Via Sul")
dados_filtrados <- car_crash %>%
    filter(lugar_acidente %in% autopistas)

dados_filtrados %>%
    glimpse()

# Podemos fazer a negação do exemplo acima
`%ni%` <- Negate(`%in%`)

dados_filtrados <- car_crash %>%
    filter(lugar_acidente %ni% autopistas)

dados_filtrados %>%
    glimpse()

# mesmo exemplo acima, mas de uma outra forma
dados_filtrados <- car_crash %>%
    filter(!(lugar_acidente %in% autopistas))

dados_filtrados %>%
    glimpse()

# podemos usar o operador %like% para buscar padrões de char
car_crash %>% 
  filter(tipo_de_ocorrencia %like% "com vítima") %>%
  glimpse()

# as vezes temos mais de uma opc de pesquisa, então
# podemos utilizar a função grepl()
car_crash %>%
    filter(grepl("ilesa|fatal", tipo_de_ocorrencia)) %>%
    glimpse()


### Exercicios
## Utilizando o banco de dados car_crash, faça o que se pede:
## Selecione as variáveis data, tipo_de_ocorrencia, automovel, bicicleta, onibus, caminhao, moto, trator, outros e total.
## Selecione todas as variáveis que contenham a palavra feridos.
## Selecione todas as variáveis numéricas.
## Selecione todas as variáveis lógicas.
## Selecione todas as variáveis que terminem com a letra o.
## Selecione todas as variáveis que iniciem com a letra t.
## Filtre as observações com pelo menos 5 carros E 3 motos envolvidos no acidente.
## Filtre as observações com pelo menos 5 carros OU 3 motos envolvidos no acidente.
## Filtre as observações com vítimas.
## Filtre as observações com pelo menos 5 carros OU 3 motos envolvidos no acidente E que ocorreram em alguma das seguintes operadoras: “Autopista Regis Bittencourt”, “Autopista Litoral Sul”, “Via Sul”.
