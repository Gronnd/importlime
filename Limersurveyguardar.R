library(limer)
library(googlesheets4)
library(tidyverse)
library(rlang)
library(summarytools)
library(ggblanket)

#get username from the first lineof pass.txt
username <- readLines("pass.txt")[1]
password <- readLines("pass.txt")[2]
url <- readLines("pass.txt")[3]
url_gsheet <- readLines("pass.txt")[4]

#loguear en las apis
options(lime_api = url)
options(lime_username = username)
options(lime_password = password)

#############################################################


#key de la API de limesurvey
get_session_key()

#log en google sheets
gs4_auth()


# dataframe con la lista de encuestas
survey_df<-call_limer(method='list_surveys')
print(survey_df)

#replicar survey_title <- get_responses(iSurveyID= "sid") para cada encuesta
corunha <- get_responses(iSurveyID= "375797")
lancara <- get_responses(iSurveyID= "246285")
lugo <- get_responses(iSurveyID= "953215")
pastoriza <- get_responses(iSurveyID= "949626")
guitiriz <- get_responses(iSurveyID= "851874")



#pegar encuestas en un dataframe
xxxx1 <- get_responses(iSurveyID= "id de la encuesta")
xxxx2 <- get_responses(iSurveyID= "id de la encuesta")


#importar a google sheets
range_write(lancara, ss=url_gsheet, sheet = "lancara", range = "A2", col_names = FALSE)
range_write(lugo, ss=url_gsheet, sheet = "lugo", range = "A2", col_names = FALSE)
range_write(pastoriza, ss=url_gsheet, sheet = "pastoriza", range = "A2", col_names = FALSE)
range_write(guitiriz, ss=url_gsheet, sheet = "guitiriz", range = "A2", col_names = FALSE)
range_write(corunha, ss=url_gsheet, sheet = "corunha", range = "A2", col_names = FALSE)




#crear un csv en el directorio de trabajo
write_excel_csv2(xxxx1, "xxxx1.csv")
write_excel_csv2(xxxx2, "xxxx2.csv")



#comprobación padrón
table(lancara$Padron)
table(lugo$Padron)
table(pastoriza$Padron)
table(guitiriz$Padron)
table(corunha$Padron)
 
#soltar sesión de la api de limesurvey
release_session_key()

