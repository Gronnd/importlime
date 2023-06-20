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
iSurveyIDs <- str_split(datos[1], pattern = ",")[[1]] # Separa las encuestas por comas
sheet_names <- str_split(datos[2], pattern = ",")[[1]] # Separa los nombres de las hojas por comas
url_gsheets <- str_split(datos[3], pattern = ",")[[1]] # Separa las URLs de Google Sheets por comas

# Asegurar que tenemos el mismo número de encuestas, nombres de hojas y URLs de Google Sheets
if (length(iSurveyIDs) != length(sheet_names) | length(iSurveyIDs) != length(url_gsheets)) {
  stop("El número de IDs de encuestas, nombres de hojas y URLs de Google Sheets debe ser el mismo.")
}

# Eliminar los espacios en blanco antes y después de cada elemento
iSurveyIDs <- trimws(iSurveyIDs)
sheet_names <- trimws(sheet_names)
url_gsheets <- trimws(url_gsheets)

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
# usando purrr::map2() para hacer un bucle a través de cada conjunto de encuesta/hoja/URL
purrr::pmap(list(iSurveyIDs, sheet_names, url_gsheets), write_responses_to_sheet)

# Cerrar sesión en la API de limesurvey
release_session_key()

# Limpiar el entorno de trabajo
rm(list = ls())

