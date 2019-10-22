def concatena chaves, dados
    hash = Hash.new
    arr = []

    if chaves.length == dados.length
        chaves.each_with_index do |chave, index|
            hash[chave] = dados[index]
        end    
        return hash

    elsif chaves.length > dados.length
        cont = 0
        while cont < dados.length
            hash[chaves[cont]] = dados[cont]
            cont += 1
        end
        while cont < chaves.length
            hash[chaves[cont]] = ''
            cont += 1
        end
        return hash

    else 
        cont = 0
        while cont < chaves.length
            hash[chaves[cont]] = dados[cont]
            cont += 1
        end
        cont += 1
        while cont < dados.length
            arr.push(dados[cont])
            cont += 1
        end
        hash[dados[-arr.length-1]] = arr
        return hash
    end
end


arr1 = [1,2,3,4,5,6]
arr2 = ['a','b','c','d','e','f','g','h', 'i', 'j']

hash = concatena(arr1, arr2)

puts hash