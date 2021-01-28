
library(rvest)
library(xml2)

URL <- "https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm"

file <- read_html(URL)
tables <- html_nodes(file, "table") 

#Nodo #1
table1 <- html_table(tables[1], fill = TRUE)

table <- na.omit(as.data.frame(table1))
str(table)

#Gsub para limpiar caracteres 
#Quitar los caracteres no necesarios de la columna sueldos 
#(todo lo que no sea número), para dejar solamente la cantidad mensual 
#(Hint: la función gsub podría ser de utilidad)

table_limpia <- gsub("MXN","",table$Sueldo)
a <- gsub("mes", "", table_limpia)
a <- gsub ("/","", a)
a <- gsub("\\$", "", a)
a<- gsub( ",","",a)

#NUmerico
a <- as.numeric(a)
table$Sueldo <- a
fila<- which.max(table$Sueldo)
table[fila,]

