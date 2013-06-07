
def crear_dns(valores):
    #telserver          IN     A    10.61.5.130
     
    if (valores[2]):
        dominio_obtenido = valores[2]
    else:
        dominio_obtenido = valores[1] + "." + dominio
        
    print valores[0] + ":" + dominio_obtenido
    
if __name__ == "__main__":
    
    path = "../zarate.dns"
    contenido = open(path).read();
    dominio = ""
    
    for item in contenido.split():
        if (item):
            if (item[0] == "#"):
                dominio = item[1:-1]                
            else:
                valores = item.split(",")
                result = crear_dns(valores)