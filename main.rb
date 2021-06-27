require "matrix"
def imprimir(matriz,num) #permite imprimir la matriz
    (0..num).each do |i|
        (0..num).each do |j|
            print "#{matriz[i,j]} "
        end
        puts "\n"
    end
end
puts "(0) Usar archivo texto.txt\n(1) Usar otro texto"
opt = gets.chomp.to_i #usuario indica si va usar el archivo de texto provisto o uno propio
if opt == 0 then
    file = "texto.txt"
else
    puts "El archivo de texto debe estar dentro de la carpeta Proyecto\n"
    puts "Ingrese el nombre del archivo (no olvidar la extension .txt): "
    file = gets.chomp #el usuario ingresa el nombre del archivo de texto
end
$padre=[] #variable global para saber si todos los vertices fueron visitados
def get_num_vertices(file) #obtiene el numero de vertices del archivo
    contenido = File.read(file)
    filas = contenido.split("\n")
    numVertices = filas.length
    return numVertices
end
numero = get_num_vertices(file)
$matrizDFS=Matrix.zero(numero) #genera una matriz global numero X numero lleno de 0's, esta sirve para almacenar los valores de la funcion recursiva generar_DFS
def generar_DFS(index,mat,num_vertices) #genera una matriz DFS recursivamente
    $padre[index] = 1 #se indica que se visito el vertices
    (0..num_vertices).each do |i| #recorre los vertices iniciales de la arista
        if i == index then
            (0..num_vertices).each do |j| #recorre los vertices finales
                if mat[i,j]==1 and $padre[j]==0 then #si el vertice inicial esta conectado al vertice final y este no fue visitado
                    $matrizDFS[i,j] += 1 #se registra la conexion en la matriz dfs global
                    generar_DFS(j,mat,num_vertices) #se busca la siguiente conexion tomando el vertice final como inicial de otra busqueda
                end
            end
        end
    end
    nuevamatriz = $matrizDFS #los datos de la matriz global pasan a una matriz local
    return nuevamatriz #se regresa la matriz DFS
end
matriz = Matrix.zero(numero)

i=0
File.foreach("texto.txt") do |line| #
    j=0                             #
    for data in line.split("\t") do # Genera la matriz del grafo del
        matriz[i,j] = data.to_i     # archivo texto.txt
        j +=1                       #
    end                             # Inicializa la variable global como un array
    $padre[i]=0                     # unidimensional con el numero de vertices de elementos
    i +=1                           # con sus valores en 0
end                                 #

puts "*"*50
puts "Matriz del grafo:\n"
imprimir(matriz,numero) #imprime la matriz de adyacencia del grafo
puts "*"*50
(0..numero-1).each do |k|
    if k <=25 then
        puts "(#{k}) Vertice #{(65+k).chr}." #imprime un caracter por vertice
    else
        label=""
        ((65 + k) / 26).times do |n|
            label += ((65 + n) / 26).chr
        end
        puts "(#{k}) Vertice #{label}." #si supera los 25 caracteres o sea ya hay vertices de la A a la Z, continuara como AA,AB,etc
    end

end
puts "*"*50
puts "ingrese el numero del vertice por donde se iniciara la busqueda por profundidad: "
    index = gets.chomp.to_i #usuario ingresa numero
    while index > numero-1 do #si se ingresa un numero de vertice mayor a la cantidad de vertices
        puts "Error: Numero de vertices excedido.\nIntente otra vez: "
        index = gets.chomp.to_i #vuelve a preguntar por un numero
    end
puts "Matriz DFS:\n"
matrizresultante = generar_DFS(index,matriz,numero) #genera la matriz de adyacencia de la busqueda de profundidad
imprimir(matrizresultante,numero) #imprime la matriz
system("pause")