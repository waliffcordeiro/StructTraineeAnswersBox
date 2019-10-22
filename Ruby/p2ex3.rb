def concatena chaves, dados
    hash = Hash.new

    chaves.each_with_index do |chave, index|
        hash[chave] = dados[index]
    end    
    hash
end

arr1 = [1,2,3,4,5,6]
arr2 = ['a','b','c','d','f']

if arr1.length != arr2.length
    puts 'O tamanho dos arrays é diferente'
else
    hash = concatena(arr1, arr2)
end

puts hash