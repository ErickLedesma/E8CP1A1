# Crear un método que reciba el archivo peliculas.txt, lo abra y cuente la cantidad total
# de palabras. El método debe devolver este valor.
#
# Crear un método similar para que además reciba -como argumento- un string. En
# este caso el método debe contar únicamente las apariciones de ese string en el
# archivo.

# 1
def count_words(file_name)
    file = File.open(file_name, 'r')
    data = file.readlines
    file.close
    words = []
    data.each { |line| words << line.chomp.gsub('.','').gsub(':','').split(' ') }
    words.flatten!
    puts words.length
end 

count_words('peliculas.txt')

# 2
def count_word(file_name, word)
    file = File.open(file_name, 'r')
    data = file.readlines
    file.close
    words = []
    data.each { |line| words << line.chomp.gsub('.','').gsub(':','').split(' ') }
    words.flatten!
    
    t_word = words.select { |item| item == word}.size
    # end 
    puts t_word
end 

count_word('peliculas.txt','Galaxias')


