ano = gets
ano = ano.to_i
flag = false

if ano % 400 == 0
    puts 'É bissexto'
    flag = true

elsif ano % 100 == 0
    puts 'Não é bissexto'
    flag = true

elsif ano % 4 == 0
    puts 'É bissexto'
    flag = true
end

if !flag
    puts 'Não é bissexto'
end