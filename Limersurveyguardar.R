if(!require("googlesheets4")) install.packages("googlesheets4")
if(!require("tidyverse")) install.packages("tidyverse")
if (!require("devtools")) {
        install.packages("devtools")
        library("devtools")
}
install_github("Jan-E/limer", force = TRUE)



library(googlesheets4)
library(tidyverse)
library(limer)


options(lime_api = 'https://url.limesurvey.net/admin/remotecontrol')
options(lime_username = 'nombre')
options(lime_password = 'contraseña')


get_session_key() 
gs4_auth() 



lista <- call_limer(method = "list_surveys")
print(lista)


Prueba2 <- get_responses(462224, 
                           sCompletionStatus = "complete")
Prueba3 <- get_responses(189752, 
                           sCompletionStatus = "complete")


#gs4_create(name="PruebaR",  sheets = c("Prueba2", "Prueba3"))



range_write(Prueba2, ss="url", sheet = "Prueba2" )
range_write(Prueba3, ss="url", sheet = "Prueba3" )



