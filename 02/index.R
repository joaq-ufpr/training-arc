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
rm(list = ls())

require(dplyr)
require(magrittr)
library(data.table)
require(lubridate)
car_crash <- readr::read_csv("datasets/archive/Brazil Total highway crashes 2010 - 2023.csv")

## Utilizando o banco de dados car_crash formate a coluna
## data em uma data (dd-mm-yyyy);

car_crash$data <- dmy(car_crash$data)

## Utilizando o banco de dados car_crash formate a coluna
## horario para o horário do acidente (hh:mm:ss)

car_crash$horario <- hms(car_crash$horario)

## Qual o mês com maior quantidade de acidentes?

car_crash %>%
    mutate(mes = month(data, label = TRUE)) %>%
    group_by(mes) %>%
    summarise(num_acidentes_por_mes = n()) %>%
    arrange(desc(num_acidentes_por_mes))

## Qual ano ocorreram mais acidentes?

car_crash %>%
    group_by(data) %>%
    summarise(num_acidentes_por_ano = n()) %>%
    arrange(desc(num_acidentes_por_ano))


## Qual horário acontecem menos acidentes?

car_crash %>%
    mutate(hora = hour(horario)) %>%
    group_by(hora) %>%
    summarise(num_acidentes_por_hora = n()) %>%
    arrange(num_acidentes_por_hora)

## Qual a média, desvio padrão, mediana, Q1 e Q3 para
## a quantidade de indivíduos classificados como
## levemente feridos por mês/ano?

ex6 <- car_crash %>%
    mutate(mes = month(data, label = TRUE),
           ano = year(data)) %>%
    group_by(mes, ano) %>%
    summarise(media = mean(levemente_feridos, na.rm = TRUE),
              Q1 = quantile(levemente_feridos, 0.25, type = 5, na.rm = TRUE),
              Q3 = quantile(levemente_feridos, 0.75, type = 5, na.rm = TRUE),
              sd = sd(levemente_feridos, na.rm = TRUE),
              .groups = "drop")

## Quantos acidentes com vítimas fatais aconteceram,
## por mês/ano, em media entre as 6:00am e 11:59am.

car_crash %>%
    mutate(mes = month(data, label = TRUE),
           ano = year(data),
           hora = hour(horario)) %>%
    filter(between(hora, lower = 6, upper = 11, incbounds = TRUE)) %>%
    group_by(mes, ano) %>%
    summarise(numero_mortos = mean(mortos, na.rm = TRUE),
              .groups = "drop")


### JUNÇÃO DE DADOS(ESSE É COMPLICADO BICHO)
# para entender como funciona a junção de dados
# iremos utilizar o dataset nycflights13

library(tidyverse)
require(nycflights13)

# O conceito de chaves no R é semelhante ao do SQL
# porem, aqui não temos explicitado as PK's e FK's
# nas tabelas. Ou seja, para identificarmos isso
# devemos literalmente "fuçar" as tabelas e suas
# respectivas colunas para poder fazer as junções

#==========
# Identificação das PK
#==========

# A PK aqui é a coluna carrier
# que carrega o códigio da operadora. 
glimpse(airlines)

# A PK de airports é FAA
# pois carrega o código do aeroporto
glimpse(airports)

# Nesta tabela a PK é tailnum
# que identifica o avião.
glimpse(planes)

# nesta tabela temos um caso mais complicado
# aqui a PK vai ser composta de 2 colunas
# origin e time_hour
# ou seja, PK => origin & time_hour
glimpse(weather)

#==========
# Identificação das FK
#==========

# Na tabela flights temos que:
# flights$tailnum é FK da tabela plane$tailnum
# flights$carrier é FK da tabela airlines$carrier
# flights$flight é PK de flights

# Perceba as chaves compostas
# flights(year, month, day, hour, origin) é FK de weather(year, month, day, hour, origin)
# flights(origin, dest) é FK de airports(faa)
glimpse(flights)

# Após termos feito isso, podemos verificar
# se os campos possuem valores únicos.
# ou seja, contar n() > 1 nesses campos
planes %>%
    count(tailnum) %>%
    filter(n > 1) # produziu 0

weather %>%
    count(time_hour, origin) %>%
    filter(n > 1) # produziu 0

# Temos que nos certificar também que não haja valores faltantes
# caso um valor esteja ausente, não podemos identificar uma observação
planes %>%
    filter(is.na(tailnum)) # produziu 0

weather %>%
    filter(is.na(time_hour) | is.na(origin)) # produziu 0

## Combinando dados
# O dplyr fornece 6 funções para junção de dados.
# Sendo elas 4 que são mutacionais e 2 de filtragem

# Mutacionais
# inner_join, full_join, left_join, right_join

# Esse tipo de filtragem combina valores de dois
# conjunto e adiciona em uma nova coluna
# exatemente como na função mutate()

# vamos criar um df mais simples para trabalharmos essas ideias
flights2 <- flights |>
    filter(distance > 2000) |>
    select(year, time_hour, origin, dest, tailnum, carrier)
glimpse(flights2)

# vamos testar o left_join
# Aqui vamos pegar as linhas da primeira tabela(à esquerda)
# e encontrar correspondencia na segunda tabela(à direita)
# isso irá gerar uma nova coluna contendo o match das infos.
# caso não haja correspondencia, NA será empregado na obs

# exemplo
# queremos o nome completo da cia aerea no nosso df.
# Pra isso vamos combinar infos de flights2 com airlines
flights2_airlines <- flights2 %>%
    ## left_join(., airlines) # Aqui o interpretador identifica qual é a coluna chave
    left_join(., airlines, by = "carrier") # mas é prática deixar explicito como aqui.

# note que foi criado uma nova coluna contendo
# o nome da cia aerea
View(head(flights2_airlines))

# Já o right_join é a "mesma coisa" que o left.
# porem, vamos pegar as linhas da tabela a direita
# para encontrarmos correspondencia na esquerda.
# Ou seja, o caminho inverso.

# exemplo
# Suponha que queremos buscar informações acerca dos vôos realizados
# pelos aviões em flights2. Para isso, unimos as tabelas planes com flights2
planes_flights <- flights2 %>%
    right_join(planes, by = "tailnum")

# veja como foi retornado as infos refentes aos aviões
View(head(planes_flights))

# O inner_join, podemos interpretar como a operação de
# intersecção entre conjuntos, em outras palavras, retorna infos
# somente se houver correspondencia entre ambas as tabelas.

# exemplo
# Queremos informações acerca dos aeroportos de origem realizados
# pelos aviões. Mas, queremos infos que estão em ambas as tabelas
# Para isso, unimos flights2 airports
origin_flights <- flights2 %>%
    inner_join(airports, by = c("origin" = "faa"))

origin_flights <- flights2 %>%
    inner_join(airports, join_by(origin == faa))

View(head(origin_flights))

# Por ultimo, temos o full_join
# retorna todas as linhas de ambos os conjuntos de dados
# (tabelas à esquerda e à direita). Ele preenche com NA
# aqueles valores que não têm correspondência em uma das tabelas.

# Suponha que, temos interesse em buscar informações acerca dos aeroportos
# de destino realizados pelos aviões em flights2. Porém, apenas temos
# interesse em todas informações que aparecem em ambos bancos.
# Para isso, basta unirmos as tabelas flights2 com airports.
dest_flights <- flights2 %>% 
  full_join(airports, by = c("dest" = "faa"))

dest_flights <- flights2 %>% 
  full_join(airports, join_by(dest == faa))
View(head(origin_flights))

# Filtragem
# semi_join(), anti_join()

# Semi-junções mantêm todas as linhas em x que têm uma correspondência em y

# exemplo
# vamos usar um semi_join para filtrar os dados de aeroportos para
# mostrar somente os aeroportos de origem
airports %>%
    semi_join(flights2, join_by(faa == origin))

## glimpse(airports)

# Anti-junções são o oposto: elas retornam todas as linhas em x que
# não têm correspondência em y. É bem útil para encontrar valores
# ausentes que são implicitos nos dados. Esses valores ausentes não aparecem
# como NA, mas sim como valor ausente
# Por exemplo, podemos encontrar linhas ausentes em aeroportos
# procurando voos que não tenham um aeroporto de destino correspondente:
flights %>%
    anti_join(airports, join_by(dest == faa)) %>%
    distinct(dest)

### Exercicios
# Limpar o ambiente
rm(list = ls())

require(dplyr)
require(magrittr)
library(data.table)
require(lubridate)

# Leitura dos dados
flights_  <- readr::read_csv("datasets/nycflights13/nyc_flights.csv")
weather_  <- readr::read_csv("datasets/nycflights13/nyc_weather.csv")
airlines_ <- readr::read_csv("datasets/nycflights13/nyc_airlines.csv")
airports_ <- readr::read_csv("datasets/nycflights13/nyc_airports.csv")
planes_   <- readr::read_csv("datasets/nycflights13/nyc_planes.csv")

# Para vôos com atraso superior a 24 horas em flights, verifique as
# condições climáticas em weather. Há algum padrão? Quais os meses
# do ano em que você encontra os maiores atrasos?

### Pequeno rascunho
## dep_atraso_distinto <- flights_ %>%
##     filter(dep_delay >= 720) %>%
##     select(dep_delay, month) %>%
##     arrange(month)
## View(dep_atraso_distinto)

## arr_atraso_distinto <- flights %>%
##     filter(arr_delay >= 720) %>%
##     select(arr_delay, month) %>%
##     arrange(month)
## View(arr_atraso_distinto)

voos_clima <- flights_ %>%
    filter(dep_delay >= 120 | arr_delay >= 120) %>%
    inner_join(., weather_,
              by = join_by(year, month, day, origin, hour, time_hour)) %>%
    select(dep_delay, arr_delay, month, year, temp, humid, precip, visib, wind_speed) %>%
    mutate(mes = month(month, label = TRUE)) %>%
    group_by(mes) %>%
    summarise(media_atraso_saida = mean(dep_delay, na.rm = TRUE),
              media_atraso_chegada = mean(arr_delay, na.rm = TRUE),
              media_temperatura = mean(temp, na.rm = TRUE),
              media_humidade = mean(humid, na.rm = TRUE),
              media_precipitacao = mean(precip, na.rm = TRUE),
              media_visibilidade = mean(visib, na.rm = TRUE),
              media_veloc_vento = mean(wind_speed, na.rm = TRUE))
    
View(voos_clima)

# Encontre os 20 destinos mais comuns e identifique seu aeroporto.
# Qual a temperatura média (mensal) em Celsius desses lugares?
# E a precipiração média, em cm?

top_destinos <- flights_ %>%
  count(dest, sort = TRUE) %>%
  slice_max(n, n = 20)

top_destinos_info <- top_destinos %>%
  left_join(airports_, by = c("dest" = "faa"))

View(top_destinos_info)

fahrenheit_to_celcius <- function(temp) (temp -32) * 5/9
inches_to_cm <- function(value) value * 2.54

clima_destinos <- flights_ %>%
  filter(dest %in% top_destinos$dest) %>%
  inner_join(weather_, by = c("time_hour", "origin")) %>%
  mutate(mes = month(time_hour, label = TRUE),
         temp_c = fahrenheit_to_celcius(temp),
         precip_cm = inches_to_cm(precip)) %>%
  group_by(dest, mes) %>%
  summarise(temp_media = mean(temp_c, na.rm = TRUE),
            precip_media = mean(precip_cm, na.rm = TRUE),
            .groups = "drop")

View(clima_destinos)

# Inclua uma coluna com a cia aérea na tabela planes.
# Quantas companhias áreas voaram cada avião naquele ano?

# está errado essa query
companhias_por_aviao <- flights_ %>%
  select(tailnum, carrier) %>%
  filter(!is.na(tailnum)) %>%
  distinct() %>%
  left_join(airlines_, by = "carrier") %>%
  group_by(carrier) %>%
  summarise(num_companhias = n_distinct(name)) %>%
  arrange(desc(num_companhias))

View(tail(companhias_por_aviao))

# Inclua a latitude e longitude de cada origem destino na tabela flights
flights_geo <- flights_ %>%
  left_join(airports_ %>% select(faa, lat, lon), by = c("origin" = "faa")) %>%
  rename(lat_origin = lat, lon_origin = lon) %>%
  left_join(airports_ %>% select(faa, lat, lon), by = c("dest" = "faa")) %>%
  rename(lat_dest = lat, lon_dest = lon)

View(flights_geo)


#### Agora iremos ver parte de organização dos dataframes
# ou seja, pivotagem.

# Alguns mottos sobre dados tidy

# 1 - Cada variável é uma coluna; cada coluna é uma variável

# 2 - Cada observação é uma linha; cada linha é uma observação

# 3 - Cada valor é uma célula; cada célula é um único valor

## Tipos de organização

## WIDE
# Nesse formato, os dados são organizados de forma que cada variável é
# representada por uma coluna separada e cada observação (ou instância)
# ocupa uma única linha. Isso significa que as informações são distribuídas
# em várias colunas, tornando-o mais adequado para conjuntos de dados com
# poucas variáveis, onde as informações são bem condensadas.

## LONG
# Já no formato long (ou longo), os dados são organizados de maneira que as variáveis
# estão empilhadas em uma única coluna, enquanto uma coluna adicional é usada para
# indicar o nome da variável. Cada observação é representada por uma linha separada.
# Esse formato é ideal quando se trabalha com conjuntos de dados mais complexos,
# nos quais as informações estão espalhadas em várias categorias ou momentos de tempo, por exemplo.

## Pivotando em R
# o R é munido de funções para que possamos fazer a pivotagem
# ou seja, tranformar linha em coluna e vice e versa
# para termos exemplos de como fazer isso vamos utilizar
# os datasets de tuberculose da OMS
# Para lidar com os dados da OMS
# tem que carregar a biblioteca tidyr
require(tidyr)
data(who)
table1

# pivot_wider()
# usamos essa função para tranformar nossos para um formato largo
# a sua syntax é
# pivot_wider(data, names_from, values_from)
# data >>> o data frame
# name_from >>> a coluna que contem os nomes das variáveis que queremos "espalhar"
# values_from >>> a coluna que contem os valores correspondente destas variáveis.

# exemplo
# suponha que queremos o número de casos por ano
table1 %>%
    select(country, year, cases) %>%
    pivot_wider(names_from = year, values_from = cases)

# pivot_longer()
# faz o inverso da wider, de forma simples é isso.
# Geralmente, usamos pivot_longer quando temos
# variáveis empilhadas em diferentes colunas e queremos reunir essas informações em uma única coluna.
# A sua syntax é
# pivot_longer(data, cols, names_to, values_to)
# data >>> O conjunto de dados que você deseja transformar.
# cols >>> As colunas que você deseja empilhar no formato longo.
# names_to >>> O nome da nova coluna que irá conter os nomes das variáveis empilhadas.
# values_to >>> O nome da nova coluna que irá conter os valores das variáveis empilhadas.
# Suponha que queremos os casos e o tamanho da população como uma variável.
table1 %>%
    pivot_longer(cols = -c(country, year),
                 names_to = "variavel",
                 values_to = "tamanho")

## separando as observações
# a função separate() separa(dãa) uma única coluna em várias colunas,
# dividindo-a sempre que um caractere separador aparece.
# Exemplo
table3 # Note que "rate" é constituidade de casos/população

# separendo
separated <- table3 %>%
    separate(rate, into = c("cases", "population"))

separated

# Juntando novamente
separated %>%
    unite(rate, cases, population, sep = "/")
