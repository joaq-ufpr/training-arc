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

### Trabalhando com datas em R
# O R tem funções próprias para lidar com isso
# mas atualmente é mais conveniente trabalhar com
# uma biblioteca chamada lubridate
require(lubridate)
data_ym <- ymd("2023-08-21")
data_mdy <- mdy("08-21-2023")
data_dmy <- dmy("21-08-2023")

message("anos-mes-dia: ", data_dmy, "\n",
      "mes-dia-ano: ", data_md, "\n",
      "dia-mes-ano: ", data_dmy, "\n")

sprintf("anos-mes-dia: %s", data_dmy)
sprintf("mes-dia-ano: %s", data_md)
sprintf("dia-mes-ano: %s", data_dmy)


## Operações com datas
data <- ymd("2023-08-21")
data_nova <- data + days(7) # adiciona 7 dias a esta data
data_anterior <- data - months(2) # subtrai 2 meses

print(data)
print(data_nova)
print(data_anterior)

## há mais funçoes desta lib para extrair infos de datas
# saca só...
data <- ymd_hms("2023-08-21 15:30:45")
ano <- year(data)
mes <- month(data)
dia <- day(data)
hora <- hour(data)
minuto <- minute(data)
segundo <- second(data)

data_infos <- c(ano, mes, dia, hora, minuto, segundo)
names(data_infos) <- c("ano", "mes", "dia", "hora", "minuto", "segundo")
data_infos

## Funções de resumos de datas no lubridate
# o lubridate vem munido de funcionalidades para
# realizar operações entre datas, não somente para somar,
# subtrair etc, mas tambem para realizar a conversão do formato
# para outros, ou seja, transformar mês em dias ou semanas, etc.

data1 <- ymd("2023-08-21")
data2 <- ymd("2023-08-14")
diferenca_em_dias <- as.numeric(data2 - data1)
diferenca_em_semanas <- as.numeric(weeks(data2 - data1))

print(diferenca_em_dias)
print(diferenca_em_semanas)

### Lidar com fuso horario

# data original no fuso de ny
data_ny <- ymd_hms("2023-08-21 12:00:00", tz = "America/New_York")
print(data_ny)

# converte para o fuso de Londres
data_london <- with_tz(data_ny, tz = "Europe/London")
print(data_london)

## Exemplo de calcular a diferenca de tempo entre diferentes fusos

data_ny <- ymd_hms("2023-08-21 12:00:00", tz = "America/New_York")
data_london <- ymd_hms("2023-08-21 17:00:00", tz = "Europe/London")

diferenca_horas <- as.numeric(data_london - data_ny)
print(diferenca_horas)

## Exemplo do lubridate com dataframes

dados <- tibble(
    nome = c("Evento 1", "Evento 2"),
    data = c(
        ymd_hms("2023-08-21 12:00:00", tz = "America/New_York"),
        ymd_hms("2023-08-21 17:00:00", tz = "Europe/London")
    )
)

# Aqui convertemos todas as datas para um fuso comum como o UTC
dados$data_utc <- with_tz(dados$data, tz = "UTC")
print(dados)

# perceba como o lubridate é uma baita de uma mão na roda
# para esse tipo situ.

## ### Exercicios

car_crash <- readr::read_csv("datasets/archive/Brazil Total highway crashes 2010 - 2023.csv")
glimpse(car_crash)
View(tail(car_crash))

## Utilizando o banco de dados car_crash formate a coluna
## data em uma data (dd-mm-yyyy);

car_crash$data <- as.Date(car_crash$data)
car_crash$data <- format(car_crash$data, "%d-%m-%y")

## Utilizando o banco de dados car_crash formate a coluna
## horario para o horário do acidente (hh:mm:ss)

car_crash$horario <- format(car_crash$horario, "%hh:%mm:%ss")

## Qual o mês com maior quantidade de acidentes?

car_crash %>%
    group_by(month(data)) %>%
    summarise(num_acidentes_por_mes = n()) %>%
    arrange(desc(num_acidentes_por_mes))

## Qual ano ocorreram mais acidentes?

car_crash %>%
    group_by(year(dmy(data))) %>%
    summarise(num_acidentes_por_ano = n()) %>%
    arrange(desc(num_acidentes_por_ano))


## Qual horário acontecem menos acidentes?

## car_crash %>%
##     group_by(hour(as.Date(horario))) %>%
##     summarise(num_acidentes_por_hora = n()) %>%
##     arrange(num_acidentes_por_hora)

## Qual a média, desvio padrão, mediana, Q1 e Q3 para
## a quantidade de indivíduos classificados como
## levemente feridos por mês/ano?

## Quantos acidentes com vítimas fatais aconteceram,
## por mês/ano, em mediana entre as 6:00am e 11:59am.
