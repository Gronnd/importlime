library(limer)
library(googlesheets4)
library(tidyverse)




# Leer las credenciales y URL de pass.txt
credentials <- readLines("pass.txt")
username <- credentials[1]
password <- credentials[2]
url <- credentials[3]
mail <- credentials[4]

# Datos para importaciones
datos <- readLines("importaciones.txt")
hoja <- datos[1]



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
write_responses_to_sheet <- function(iSurveyID, sheet_name, url_gsheet) {
  responses <- get_responses(iSurveyID = iSurveyID)
  range_write(responses, ss = url_gsheet, sheet = sheet_name, range = "A2", col_names = FALSE)
}

# Diccionario con IDs de encuesta y nombres de hojas

write_responses_to_sheet("791131", "Agronovo_2023", hoja)

# Cerrar sesión en la API de limesurvey
release_session_key()
rm(list = ls())
