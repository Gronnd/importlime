library(limer)
library(googlesheets4)
library(tidyverse)

# Leer las credenciales y URL de pass.txt
credentials <- readLines("pass.txt")
username <- credentials[1]
password <- credentials[2]
url <- credentials[3]
mail <- credentials[4]

# Leer los datos para importaciones
datos <- readLines("importaciones.txt")
iSurveyID <- datos[1]
sheet_name <- datos[2]
url_gsheet <- datos[3]

# Iniciar sesión en las APIs
options(lime_api = url)
options(lime_username = username)
options(lime_password = password)

# Obtener clave de sesión de la API de limesurvey
get_session_key()

# Iniciar sesión en Google Sheets
gs4_auth(email = mail)

# Función para obtener respuestas y escribir en Google Sheets
write_responses_to_sheet <- function(iSurveyID, sheet_name, url_gsheet) {
  responses <- get_responses(iSurveyID = iSurveyID)
  range_write(responses, ss = url_gsheet, sheet = sheet_name, range = "A2", col_names = FALSE)
}

# Llamar a la función con los datos leídos de importaciones.txt
write_responses_to_sheet(iSurveyID, sheet_name, url_gsheet)

# Cerrar sesión en la API de limesurvey
release_session_key()

# Limpiar el entorno de trabajo
rm(list = ls())

