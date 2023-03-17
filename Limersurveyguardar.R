if(!require("googlesheets4")) install.packages("googlesheets4")
if(!require("tidyverse")) install.packages("tidyverse")
if (!require("devtools")) {
        install.packages("devtools")
        library("devtools")
}
install_github("Jan-E/limer", force = TRUE)

#loguear en las apis
options(lime_api = 'http://url/admin/remotecontrol')
options(lime_username = 'username')
options(lime_password = 'password')

#############################################################


# first get a session access key
get_session_key()
#log en google sheets
gs4_auth()


# list all surveys. A dataframe is returned
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

