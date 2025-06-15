## library(tidyverse)
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
View(head(car_crash))

ex1 <- car_crash %>%
    select(data, tipo_de_ocorrencia, automovel,
           bicicleta, onibus, caminhao,
           moto, trator_maquinas, outros) %>%
    glimpse()

## Selecione todas as variáveis que contenham a palavra feridos.

ex2 <- car_crash %>%
    select(contains("feridos")) %>%
    glimpse()

## Selecione todas as variáveis numéricas.

ex3 <- car_crash %>%
    select(where(is.numeric)) %>%
    glimpse()

## Selecione todas as variáveis lógicas.

ex4 <- car_crash %>%
    select(where(is.logical)) %>%
    glimpse()

## Selecione todas as variáveis que terminem com a letra o.

ex4 <- car_crash %>%
    select(ends_with("o")) %>%
    glimpse()

## Selecione todas as variáveis que iniciem com a letra t.

ex5 <- car_crash %>%
    select(starts_with("t")) %>%
    glimpse()

## Filtre as observações com pelo menos 5 carros E 3 motos envolvidos no acidente.

ex6 <- car_crash %>%
    filter(automovel >= 5 & moto >= 3) %>%
    glimpse()

## Filtre as observações com pelo menos 5 carros OU 3 motos envolvidos no acidente.

ex7 <- car_crash %>%
    filter(automovel >= 5 | moto >= 3) %>%
    glimpse()

## Filtre as observações com vítimas.

ex8 <- car_crash %>%
    filter(levemente_feridos > 0 &
           moderadamente_feridos > 0 &
           mortos > 0) %>%
    glimpse()

## Filtre as observações com pelo menos 5 carros OU 3 motos envolvidos
## no acidente E que ocorreram em alguma das seguintes
## operadoras: “Autopista Regis Bittencourt”,
## “Autopista Litoral Sul”, “Via Sul”.

autopistas <- c("Autopista Regis Bittencourt",
                "Autopista Litoral Sul", "Via Sul")
ex8 <- car_crash %>%
    filter((automovel >= 5 | moto >= 3) &
           (lugar_acidente %in% autopistas)) %>%
    glimpse()

### Agrupamento de dados
# podemos usar a função summarise() e group_by()

# summarise() é super utíl para calcular estatísticas
# resumidas para uma coluna ou um conjunto de colunas

# tabela descritiva para a var "levemente_feridos"
tabela <- car_crash %>%
    summarise(n = n(),
              freq_rel = n() / nrow(car_crash),
              freq_per = (n() / nrow(car_crash)) * 100,
              media = mean(levemente_feridos, na.rm = TRUE),
              Q1 = quantile(levemente_feridos, 0.25, type = 5, na.rm = TRUE),
              Q2 = quantile(levemente_feridos, 0.5, type = 5, na.rm = TRUE),
              Q3 = quantile(levemente_feridos, 0.75, type = 5, na.rm = TRUE),
              var = var(levemente_feridos, na.rm = TRUE),
              sd = sd(levemente_feridos, na.rm = TRUE),
              min = min(levemente_feridos, na.rm = TRUE),
              max = max(levemente_feridos, na.rm = TRUE))

# uso do group_by()
# A função group_by() é usada para agrupar o conjunto de dados por uma ou mais colunas.
# Isso cria um contexto em que a função summarise() pode calcular estatísticas específicas para cada grupo.

# Estamos interessados em uma tabela descritiva para a variável levemente_feridos por tipo_de_ocorrencia.
tabela <- car_crash %>%
    filter(tipo_de_ocorrencia %in% c("sem vítima", "com vítima")) %>%
    group_by(tipo_de_ocorrencia) %>%
    summarise(n = n(),
              freq_rel = n() / nrow(car_crash),
              freq_per = (n() / nrow(car_crash)) * 100,
              media = mean(levemente_feridos, na.rm = TRUE),
              Q1 = quantile(levemente_feridos, 0.25, type = 5, na.rm = TRUE),
              Q2 = quantile(levemente_feridos, 0.5, type = 5, na.rm = TRUE),
              Q3 = quantile(levemente_feridos, 0.75, type = 5, na.rm = TRUE),
              var = var(levemente_feridos, na.rm = TRUE),
              sd = sd(levemente_feridos, na.rm = TRUE),
              min = min(levemente_feridos, na.rm = TRUE),
              max = max(levemente_feridos, na.rm = TRUE))
tabela

### Exercicios

## Utilizando o banco de dados starwars faça o que se pede:

## Qual é o número total de espécies únicas presentes? Qual a frequência de indivíduos por espécie?

num_especies <- starwars %>%
    distinct(species) %>%
    select(species) %>%
    ## na.omit() %>%
    summarise(n_especies = n())
num_especies

tabela1 <- starwars %>%
    ## filter(!is.na(species)) %>%
    group_by(species) %>%
    summarise(frequencia_relativa = (n() / nrow(starwars)))

View(tabela1)
## Calcule a altura média de personagens masculinos e femininos.

unique(starwars$gender)

tabela_altura_media_genero <- starwars %>%
    ## filter(!is.na(gender)) %>%
    group_by(gender) %>%
    summarise(frequencia_relativa = (n() / nrow(starwars)))

View(tabela_altura_media)

## Qual é a média de idade dos personagens de cada espécie para personagens masculinos?

tab_idade_media_por_especie_masc <- starwars  %>%
    filter(gender == "masculine") %>%
    group_by(species) %>%
    summarise(frequencia_relativa = (n() / nrow(starwars)),
              media_idade = mean(starwars$birth_year, na.rm = TRUE))
View(tab_idade_media_por_especie_masc)


## Para cada espécie presente na base de dados, identifique o personagem mais velho e sua idade correspondente.
# não tem como fazer isso.

require(lubridate)
