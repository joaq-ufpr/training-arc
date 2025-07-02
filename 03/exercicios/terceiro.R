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
library(readr)
library(lubridate)
## library(geosphere)

#----------------------------------
# Questão 1
#----------------------------------

numero_base <- function(data) {
  passo1 <- str_split(data, "/", simplify = TRUE)
  passo2 <- str_c(passo1, collapse = "")
  passo3 <- str_split(passo2, "", simplify = TRUE)
  passo4 <- as.integer(passo3)
  passo5 <- sum(passo4)
  passo6 <- str_split(as.character(passo5), "", simplify = TRUE)
  passo7 <- as.integer(passo6)
  passo8 <- sum(passo7)
  num_base <- passo8
  return(num_base)
}

# Funções de numerologia
tipo_individual <- function(x) ((x^4) + 7 * x + 2)
tipo_casal <- function(x, y) (x^2 + y^7)

# Carregamento dos dados
astro_individuo <- fread("datasets/Astrologia_Individuo.txt") %>% 
  as_tibble() %>% 
  rename(data_nascimento = 1)

astro_casal <- fread("datasets/Astrologia_Casal.txt") %>% 
  as_tibble() %>% 
  rename(data_nascimento_x = 1, data_nascimento_y = 2)

# Número base para casais
astro_casal <- astro_casal %>%
  mutate(
    base_x = sapply(data_nascimento_x, numero_base),
    base_y = sapply(data_nascimento_y, numero_base),
    base_casal = tipo_casal(base_x, base_y)
  )

# Número base para indivíduos
astro_individuo <- astro_individuo %>%
  mutate(
    base = sapply(data_nascimento, numero_base),
    num_individual = tipo_individual(base)
  )

# (a) Existem 97 casais com Número Base 6, e 233 com numerologia para casal igual a 6
sum(astro_casal$base_x == 6 | astro_casal$base_y == 6)  # Número base = 6 em algum
sum(astro_casal$base_casal == 6)                        # Numerologia de casal = 6

# (b) Numerologia do indivíduo em 13/10/2008
numero_base("13/10/2008")                  # deve ser 6
numero_indiv_13102008 <- tipo_individual(6)

# (c) Nascido em 01/09/1993
numero_base("1/9/1993")                     # deve ser 5

# (d) Quantidade com base = 7 e numerologia individual = 89
sum(astro_individuo$base == 7)
sum(astro_individuo$num_individual == 89)

# (e) Casal: 31/07/2010 e 23/12/1998
b1 <- numero_base("31/7/2010")
b2 <- numero_base("23/12/1998")
tipo_casal(b1, b2)  # resultado final

#----------------------------------
# Questão 2
#----------------------------------

# Função: simular_lago
simular_lago <- function(dias, peixes_iniciais, estacao, ph) {
  capacidade_maxima <- 5e5
  taxa_basal <- 0.06

  # Fator de reprodução por estação
  fator_reproducao <- switch(estacao,
    "Primavera" = 0.00,
    "Verão" = 0.03,
    "Outono" = -0.03,
    "Inverno" = -0.02
  )
  taxa_ajustada <- taxa_basal + fator_reproducao

  # Porcentagem de pesca por faixa de pH
  percentual_pescado <- case_when(
    ph >= 6.0 & ph <= 6.5 ~ 0.12,
    ph > 6.5 & ph <= 7.0 ~ 0.20,
    ph > 7.0 & ph <= 7.5 ~ 0.16,
    ph > 7.5 & ph <= 8.0 ~ 0.08,
    TRUE ~ 0.10 # valor default seguro
  )

  # Inicializa vetor
  peixes <- numeric(dias + 1)
  peixes[1] <- peixes_iniciais

  for (dia in 1:dias) {
    pescados <- ceiling(peixes[dia] * percentual_pescado)
    proximo <- ceiling(peixes[dia] * (1 + taxa_ajustada) - pescados)
    peixes[dia + 1] <- min(proximo, capacidade_maxima)
    if (peixes[dia + 1] >= capacidade_maxima) {
      return(data.frame(dia = 0:dia, peixes = peixes[1:(dia + 1)]))
    }
  }

  data.frame(dia = 0:dias, peixes = peixes)
}

# Testes para responder as 4 perguntas:

# 1. Verão, pH 6.6–7.0, após 16 dias
res1 <- simular_lago(dias = 16, peixes_iniciais = 80, estacao = "Verão", ph = 6.7)
res1_final <- tail(res1, 1)$peixes

# 2. Verão, pH 6.6–7.0, até atingir capacidade máxima
res2 <- simular_lago(dias = 1000, peixes_iniciais = 80, estacao = "Verão", ph = 6.7)
res2_dias <- tail(res2$dia, 1)

# 3. Outono, pH 6.0–6.5, após 87 dias
res3 <- simular_lago(dias = 87, peixes_iniciais = 80, estacao = "Outono", ph = 6.3)
res3_final <- tail(res3, 1)$peixes

# 4. Outono, pH 6.0–6.5, até atingir capacidade máxima
res4 <- simular_lago(dias = 1000, peixes_iniciais = 80, estacao = "Outono", ph = 6.3)
res4_dias <- tail(res4$dia, 1)

# Resultados
res1_final  # resposta 1
res2_dias   # resposta 2
res3_final  # resposta 3
res4_dias   # resposta 4


#----------------------------------
# Questão 3
#----------------------------------

# Leitura dos dados
feriados <- read_csv("global_holidays.csv")
passageiros <- read_csv("monthly_passengers.csv")

# Conversão da coluna Date
feriados <- feriados %>%
  mutate(Date = ymd(Date),
         Year = year(Date),
         Month = month(Date, label = TRUE))

# 1. Feriados em 2015 na Hungary
feriados_2015_hungary <- feriados %>%
  filter(ADM_name == "Hungary", Year == 2015) %>%
  count()

# 2. Mês com mais feriados em 2016 na Finland
mes_mais_feriados_finland_2016 <- feriados %>%
  filter(ADM_name == "Finland", Year == 2016) %>%
  count(Month) %>%
  slice_max(n, n = 1)

# 3. Passageiros (total) na Ireland no mês com mais feriados em 2011
mes_top_feriados_irlanda_2011 <- feriados %>%
  filter(ADM_name == "Ireland", Year == 2011) %>%
  count(Month) %>%
  slice_max(n, n = 1) %>%
  pull(Month)

passageiros_irlanda_2011 <- passageiros %>%
  filter(ISO3 == "IRL", Year == 2011, Month == as.integer(mes_top_feriados_irlanda_2011))

# 4. Ano com maior média de passageiros International na Finland
ano_media_passageiros_int_finland <- passageiros %>%
  filter(ISO3 == "FIN") %>%
  group_by(Year) %>%
  summarise(media_internacional = mean(International, na.rm = TRUE)) %>%
  slice_max(media_internacional, n = 1)

# 5. País com maior quantidade de feriados em 2016
pais_mais_feriados_2016 <- feriados %>%
  filter(Year == 2016) %>%
  count(ADM_name) %>%
  slice_max(n, n = 1)

# 6. Ano com maior quantidade de passageiros na Australia
ano_mais_passageiros_aus <- passageiros %>%
  filter(ISO3 == "AUS") %>%
  group_by(Year) %>%
  summarise(total = sum(Total, na.rm = TRUE)) %>%
  slice_max(total, n = 1)

# Resultados finais
feriados_2015_hungary
mes_mais_feriados_finland_2016
passageiros_irlanda_2011$Total
ano_media_passageiros_int_finland
pais_mais_feriados_2016
ano_mais_passageiros_aus

#----------------------------------
# Questão 4
#----------------------------------


# Função de distância de Haversine
haversine_distance <- function(lat1, lon1, lat2, lon2, r = 6371) {
  # converte para radianos
  to_rad <- function(x) x * pi / 180
  
  dlat <- to_rad(lat2 - lat1)
  dlon <- to_rad(lon2 - lon1)
  
  lat1 <- to_rad(lat1)
  lat2 <- to_rad(lat2)

  a <- sin(dlat/2)^2 + cos(lat1) * cos(lat2) * sin(dlon/2)^2
  c <- 2 * asin(sqrt(a))
  
  d <- r * c
  return(d)
}

# 2. Carregar CSV
michelin <- read.csv("michelin_my_maps.csv")

# 3. Restaurante de origem: "Per Se" (em New York)
rest_origem <- michelin %>% filter(grepl("Per Se", Name, ignore.case = TRUE))

# 4. Calcular distância de todos os outros restaurantes
michelin_dist <- michelin %>%
  mutate(
    dist_km = haversine_distance(
      lat1 = rest_origem$Latitude,
      lon1 = rest_origem$Longitude,
      lat2 = Latitude,
      lon2 = Longitude
    )
  ) %>%
  arrange(dist_km)

# PERGUNTA 1: Distância até o próximo restaurante com "1 Star"
proximo_1star <- michelin_dist %>%
  filter(Award == "1 Star", Name != rest_origem$Name) %>%
  slice_min(dist_km, n = 1)

# PERGUNTA 2: Quantos restaurantes com 1/2/3 estrelas estão em um raio de 1000km?
num_ate_1000km <- michelin_dist %>%
  filter(dist_km <= 1000, Award %in% c("1 Star", "2 Stars", "3 Stars")) %>%
  count()

# PERGUNTA 3: Ele pode visitar até 4 restaurantes com 1 estrela, em até 3000km
ate_4_restaurantes <- michelin_dist %>%
  filter(Award == "1 Star", Name != rest_origem$Name, dist_km <= 3000) %>%
  slice_min(dist_km, n = 4)

distancia_entre_max_min <- range(ate_4_restaurantes$dist_km)

# PERGUNTA 4: Qual a menor distância para culinária "American"
american_min <- michelin_dist %>%
  filter(grepl("American", Cuisine, ignore.case = TRUE)) %>%
  slice_min(dist_km, n = 1)

# Visualiza respostas principais
proximo_1star$dist_km
num_ate_1000km
distancia_entre_max_min
american_min$dist_km
