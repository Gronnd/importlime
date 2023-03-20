if(!require("googlesheets4")) install.packages("googlesheets4")
if(!require("tidyverse")) install.packages("tidyverse")
if (!require("devtools")) {
        install.packages("devtools")
        library("devtools")
}
install_github("Jan-E/limer")
library(limer)

#get username from the first lineof pass.txt
username <- readLines("pass.txt")[1]
password <- readLines("pass.txt")[2]
url <- readLines("pass.txt")[3]

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




#pegar encuestas en
xxxx1 <- get_responses(iSurveyID= "id de la encuesta", )
xxxx2 <- get_responses(iSurveyID= "id de la encuesta")


#importar a google sheets
range_write(xxxx1, ss="url", sheet = "xxxx1")
range_write(xxxx2, ss="url", sheet = "xxxx2")



#crear un csv en el directorio de trabajo
write_excel_csv2(xxxx1, "xxxx1.csv")
write_excel_csv2(xxxx2, "xxxx2.csv")


#comprobación padrón
table(xxxx1$Padron)
table(xxxx2$Padron)

#soltar sesión de la api de limesurvey
release_session_key()

