# - Crear un método que reciba dos strings, este método creará un archivo index.html y
#   pondrá como párrafo cada uno de los strings recibidos.
#
# - Crear un método similar al anterior, que además pueda recibir un arreglo. Si el
#   arreglo no está vacío, agregar debajo de los párrafos una lista ordenada con cada
#   uno de los elementos.
#
# - Crear un tercer método que además pueda recibir un color. Agregar color de fondo
#   a los párrafos.
#
# - El retorno de los métodos debe devolver nil.

# 1
def two_strings(string1, string2) 
    file = File.open('index.html', 'w')
    file.puts "<p> #{string1} </p> \n <p> #{string2} </p>"
    file.close
    return nil
end 

two_strings('Primera linea', 'Segunda linea')

# 2
def two_strings_arr(string1, string2, array1) 
    file = File.open('index.html', 'w')
    file.puts "<p> #{string1} </p> \n<p> #{string2} </p> \n<ul>"
    array1.each { |element| file.puts "<li> #{element} </li>"}
    file.puts '</ul>'
    file.close
    return nil
end 

two_strings_arr('Primera linea', 'Segunda linea', ['Primer elemento', 'Segundo elemento'])

# 2
def two_strings_color(string1, string2, array1, color) 
    file = File.open('index.html', 'w')
    file.puts "<p style='background-color: #{color}'> #{string1} </p> \n<p style='background-color: #{color}'> #{string2} </p> \n<ul>"
    array1.each { |element| file.puts "<li> #{element} </li>"}
    file.puts '</ul>'
    file.close
    return nil
end 

two_strings_color('Primera linea', 'Segunda linea', ['Primer elemento', 'Segundo elemento'], 'red')





