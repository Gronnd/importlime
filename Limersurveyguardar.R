library(limer)
library(googlesheets4)
library(tidyverse)


#get username from the first lineof pass.txt
username <- readLines("pass.txt")[1]
password <- readLines("pass.txt")[2]
url <- readLines("pass.txt")[3]
url_gsheet <- readLines("pass.txt")[4]
mail <- readLines("pass.txt")[5]

#loguear en las apis
options(lime_api = url)
options(lime_username = username)
options(lime_password = password)



#key de la API de limesurvey
get_session_key()

#log en google sheets
gs4_auth(email = mail)


# dataframe con la lista de encuestas
survey_df<-call_limer(method='list_surveys')
print(survey_df)

#replicar survey_title <- get_responses(iSurveyID= "sid") para cada encuesta
corunha <- get_responses(iSurveyID= "375797")
lancara <- get_responses(iSurveyID= "246285")
lugo <- get_responses(iSurveyID= "953215")
pastoriza <- get_responses(iSurveyID= "949626")
guitiriz <- get_responses(iSurveyID= "851874")


#importar a google sheets
range_write(lancara, ss=url_gsheet, sheet = "lancara", range = "A2", col_names = FALSE)
range_write(lugo, ss=url_gsheet, sheet = "lugo", range = "A2", col_names = FALSE)
range_write(pastoriza, ss=url_gsheet, sheet = "pastoriza", range = "A2", col_names = FALSE)
range_write(guitiriz, ss=url_gsheet, sheet = "guitiriz", range = "A2", col_names = FALSE)
range_write(corunha, ss=url_gsheet, sheet = "corunha", range = "A2", col_names = FALSE)

#cerrar sesion
release_session_key()