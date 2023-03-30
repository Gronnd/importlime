library(limer)
library(googlesheets4)
library(tidyverse)

# Leer las credenciales y URL de pass.txt
credentials <- readLines("pass.txt")
username <- credentials[1]
password <- credentials[2]
url <- credentials[3]
url_gsheet <- credentials[4]
mail <- credentials[5]


# Iniciar sesión en las APIs
options(lime_api = url)
options(lime_username = username)
options(lime_password = password)

# Obtener clave de sesión de la API de limesurvey
get_session_key()


# Iniciar sesión en Google Sheets
gs4_auth(email = mail)

# Dataframe con la lista de encuestas
survey_df <- call_limer(method = 'list_surveys')
print(survey_df)


# Función para obtener respuestas y escribir en Google Sheets
write_responses_to_sheet <- function(iSurveyID, sheet_name) {
  responses <- get_responses(iSurveyID = iSurveyID)
  range_write(responses, ss = url_gsheet, sheet = sheet_name, range = "A2", col_names = FALSE)
}

# Diccionario con IDs de encuesta y nombres de hojas
survey_ids <- c("375797", "246285", "953215", "949626", "851874")
sheet_names <- c("corunha", "lancara", "lugo", "pastoriza", "guitiriz")

# Iterar sobre los IDs de encuesta y nombres de hojas, y escribir respuestas en Google Sheets
for (i in seq_along(survey_ids)) {
  write_responses_to_sheet(survey_ids[i], sheet_names[i])
}

# Cerrar sesión
release_session_key()
rm(list = ls())