# Se tiene un archivo con diversos productos, donde la primera columna indica el
# nombre del producto y el resto de las columnas muestra el stock en distintas tiendas.
#
# Producto1, 10, 15, 21
# Producto2, 20, 0, 3
# Producto3, 4, 8, 0
# Producto8, 1, 2, NR
# Producto12, NR, 2, NR
#
# Donde NR significa no registrado.
# Se pide:
#     - Crear un menú con 5 opciones, se debe validar que la opción escogida sea 1, 2, 3, 4, 5 o 6.
#
#     - La opción 1 permite conocer la cantidad de productos existentes. Al seleccionar esta
#       opción, se mostrará un submenú que permitirá:
#         a) Mostrar la existencia por productos.
#         b) Mostrar la existencia total por tienda.
#         c) Mostrar la existencia total en todas las tiendas.
#         d) Volver al menú principal.
#     Hint: Se debe validar que la opción ingresada sea válida.
#
#     - La opción 2 permite que el usuario ingrese el nombre de un producto y el programa
#     responderá con la cantidad de stock total (suma en las bodegas) de ese producto.
#
#     - La opción 3 muestra los productos no registrados en cada bodega.
#
#     - La opción 4 permite conocer los productos con una existencia total menor a un
#       valor ingresado por el usuario.
#
#     - La opción 5 permite registrar un nuevo producto con su respectivo stock en cada
#       bodega. (Hint: abrir el archivo como append).
#
#     - Si el usuario ingresa la opción 6 el programa sale, si ingresa cualquier otra opción se
#       debe mostrar que la opción es inválida, y mostrar el menú nuevamente y la opción
#       de elegir.


require_relative 'metodos'

alternativas = ['Cantidad de productos existentes', 'Stock total de un producto', 
                'Productos no registrados en cada bodega', 'Productos con existencia menor a nivel',
                'Agregar un nuevo producto a bodega', 'Salir']
sub_menu = ['Mostrar la existencia por productos', 'Mostrar la existencia total por tienda',
             'Mostrar la existencia total en todas las tiendas', 'Volver al menú principal']

opcion = 0
while opcion != alternativas.count do
    InOut.imprime_menu(alternativas)

    opcion = InOut.solicita_opcion(alternativas)
    
    case opcion
    when 1     # Cantidad de Productos existentes
        InOut.imprime_menu(sub_menu)
        opcion = InOut.solicita_opcion(sub_menu)

        case opcion
        when 1  # Mostrar la existencia por productos
            arr_productos = Ops.leer_archivo('productos.txt')
            InOut.imprimir_inventario_producto(arr_productos)

        when 2 # Mostrar la existencia total por tienda
            arr_productos = Ops.leer_archivo('productos.txt')
            InOut.imprimir_total_tienda(arr_productos)

        when 3 # Mostrar la existencia total en todas las tiendas
            arr_productos = Ops.leer_archivo('productos.txt')
            InOut.imprimir_total_inventario(arr_productos)
            puts '3'

        when 4 # Volver al menú principal
            puts ''
        end 
    when 2     # Stock total de un producto
        arr_productos = Ops.leer_archivo('productos.txt')
        producto = InOut.ingresa_producto_existente(arr_productos)
        stock = Ops.stock_producto(producto, arr_productos)
        puts "El stock del producto: #{producto} es de #{stock} unidades"

    when 3     # Productos no registrados en cada bodega
        arr_productos = Ops.leer_archivo_texto('productos.txt')
        productos_nr = Ops.productos_nr(arr_productos)
        3.times { |i| puts "Producto #{productos_nr[i][0]} No Registrado en #{productos_nr[i][1]}  " }

    when 4     # Productos con existencia menor a nivel
        arr_productos = Ops.leer_archivo('productos.txt')
        nivel = InOut.ingresa_nivel
        productos_menor = Ops.busca_menor_nivel(nivel, arr_productos)
        puts "Productos debajo del nivel #{nivel} unidad"
        productos_menor.each { |menores| puts "Producto #{menores[0]} con inventario #{menores[1]} en #{menores[2]}" }

    when 5     # Agregar un Producto nuevo a bodega
        arr_productos = Ops.leer_archivo('productos.txt')
        producto = InOut.ingresa_producto(arr_productos)
        bodega = InOut.ingresa_bodega
        inventario = InOut.ingresa_inventario
        arr_productos = Ops.agrega_inventario(producto, bodega, inventario, arr_productos)
        Ops.crear_archivo(arr_productos)
    end 
end     
                
                
                





