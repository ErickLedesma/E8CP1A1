module InOut
    def self.solicita_opcion(alternativas)
        opcion = 0
        while (opcion <= 0 || opcion > alternativas.count)
            ingreso = gets.chomp
            entero = Ops.verifica_entero(ingreso)
            if !entero then
                puts "Su opción es: #{ingreso}, debes Ingresar un entero"
            elsif
                opcion = ingreso.to_i
                if opcion <= 0 || opcion > alternativas.count
                then puts "Opciones del 1 al #{alternativas.count}"
                end
            end          
        end 
        puts alternativas[opcion - 1]
        return opcion 
    end     
    
    def self.imprime_menu(alternativas)
        menu = ''
        alternativas.each_with_index { |opcion, indice |
            menu += "\n\t #{(indice + 1)} - " + opcion
        }   
        puts "\nIngrese una opción \n" + menu
    end     
    
    def self.ingresa_producto_existente(arr_productos)
        productos = Ops.solo_productos(arr_productos)

        okProducto = false
        while !okProducto 
            puts 'Ingrese un Producto'
            producto = gets.chomp
            okProducto = true
            okProducto = Ops.verifica_producto(producto, productos)   
        end
        return producto 
    end
    
    def self.ingresa_producto(arr_productos)
        productos = Ops.solo_productos(arr_productos)

        puts 'Ingrese un Producto'
        producto = gets.chomp
        exsteProducto = productos.include?(producto) 
        if exsteProducto
            puts 'Producto Existente'
        else  
            puts 'Producto Nuevo'   
        end
        return producto 
    end

    def self.ingresa_nivel
        entero = false
        while !entero
            puts 'Ingrese un nivel de inventario'
            ingreso = gets.chomp
            entero = Ops.verifica_entero(ingreso)
            if !entero 
                puts "Ingreso: #{ingreso}, debes Ingresar un entero positivo"
            end 
        end
        ingreso = ingreso.to_i
    end

    def self.ingresa_bodega
        okBodega = false
        while !okBodega
            puts 'Ingrese la bodega (1,2 o 3)'
            okBodega = true
            ingreso = gets.chomp
            if ingreso != '1' && ingreso != '2' && ingreso != '3' 
                puts "Ingreso: #{ingreso}, solo puede ser 1,2 0 3"
                okBodega = false
            end 
        end
        ingreso = ingreso.to_i
    end

    def self.ingresa_inventario
        entero = false
        while !entero
            puts 'Ingrese inventario'
            ingreso = gets.chomp
            entero = Ops.verifica_entero(ingreso)
            if !entero 
                puts "Ingreso: #{ingreso}, debes Ingresar un entero positivo"
            end 
        end
        ingreso = ingreso.to_i
    end

    def self.imprimir_inventario_producto(arr_productos) 
        puts "Producto       Tienda 1    Tienda 2    Tienda 3      Total"
        arr_productos.each do |productos|
            linea_rep = ''
            inventario_total = 0
            productos.each_with_index do |elemento, indice|
                spaces = ' ' * (12 - elemento.to_s.size) 
                if indice == 0
                    spaces = ' ' * (18 - elemento.to_s.size)
                end  
                linea_rep += elemento.to_s + spaces
                inventario_total += elemento.to_i
            end
            spaces = ' ' * (12 - inventario_total.to_s.size) 
            linea_rep += inventario_total.to_s + spaces                    
            puts linea_rep
        end
    end

    def self.imprimir_total_tienda(arr_productos) 
        inventario_total = [0,0,0]
        arr_productos.each do |productos|
            productos.each_with_index do |elemento, indice|
                inventario_total[indice - 1] += elemento.to_i
            end 
        end
        inventario_total.each_with_index do |inventario, indice|
            puts "La tienda #{indice + 1} tiene un inventario de #{inventario} unidades"
        end 
    end 
 
    def self.imprimir_total_inventario(arr_productos) 
        inventario_total = 0
        arr_productos.each do |productos|
            productos.each do |elemento|
                inventario_total += elemento.to_i
            end
        end
        puts "El inventario total es de: #{inventario_total}"
    end 
end 

module Ops
    def self.verifica_entero(texto)
        entero = true
        if  texto.to_i == 0 || (texto.to_i - texto.to_f) != 0  || texto.to_i < 0
        then  entero = false
        end   
        return entero
    end   
    
    def self.leer_archivo(archivo)
        file = File.open(archivo, 'r')
        data = file.readlines
        file.close
        arr_productos = []
        data.each { |linea| arr_productos << linea.chomp.split(', ') }
        arr_productos.each do |producto| 
            producto[1] = producto[1].to_i
            producto[2] = producto[2].to_i
            producto[3] = producto[3].to_i
        end 
        return arr_productos
    end

    def self.leer_archivo_texto(texto)
        file = File.open(texto, 'r')
        data = file.readlines
        file.close
        arr_productos = []
        data.each { |linea| arr_productos << linea.chomp.split(', ') }
        return arr_productos
    end
    
    def self.solo_productos(arr_productos)
        productos = []
        arr_productos.each do |producto|
            productos.push(producto[0])
        end    
        return productos 
    end     

    def self.verifica_producto(producto, productos)
        if !productos.include?(producto) 
            puts "No Existe #{producto} en catalogo" 
       end 
       return productos.include?(producto) 
    end 

    def self.stock_producto(producto, arr_productos)
        producto = arr_productos.select { |inventario| inventario[0] == producto } 
        producto.flatten!
        # stock = producto[1] + producto[2] + producto[3]
        stock = 0
        1.upto(3) { |i| stock += producto[i]}
        return stock
    end     

    def self.productos_nr(arr_productos)
        productos_nr = []
        arr_productos.each do |inventario|
            if inventario[1] == "NR"
                productos_nr << [inventario[0], "Bodega 1"]
            end 
            if inventario[2] == "NR"
                productos_nr << [inventario[0], "Bodega 2"]
            end 
            if inventario[3] == "NR"
                productos_nr << [inventario[0], "Bodega 3"]
            end 
        end 
        return productos_nr
    end 

    def self.busca_menor_nivel(nivel, arr_productos)
        productos_menor = []
        arr_productos.each do |inventario|
            if inventario[1] < nivel
                productos_menor << [inventario[0], inventario[1], "Bodega 1"]
            end 
            if inventario[2] < nivel
                productos_menor << [inventario[0], inventario[2], "Bodega 2"]
            end 
            if inventario[3] < nivel
                productos_menor << [inventario[0], inventario[3], "Bodega 3"]
            end 
        end 
        return productos_menor
    end     

    def self.agrega_inventario(producto, bodega, inventario, arr_productos)
        productos = solo_productos(arr_productos)
        if productos.include?(producto)
            arr_productos.each do |linea|
                if linea[0] == producto
                    linea[bodega] = linea[bodega] + inventario
                end 
            end
        else  
            agregado = [producto, 0, 0, 0]
            agregado[bodega] = inventario
            arr_productos.push(agregado)
        end   
        return arr_productos  
    end
    
    def self.crear_archivo(arr_productos)
        file = File.open('productos.txt', 'w')
        lin_archivo = ''
        arr_productos.each do |linea| 
            linea.each_with_index do |elemento, indice| 
                lin_archivo += elemento.to_s
                if indice != 3
                    lin_archivo += ", "
                end 
            end
            file.puts lin_archivo
            lin_archivo = ''
        end
        file.close
    end     
end 


