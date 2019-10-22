def escolhe menu 
    escolha = []
    menu.each_value do |pratos|
        escolha.push(pratos.sample)
    end
    return escolha
end

menu = {
    :entradas => ["Rolinho Primavera", "Caviar", "Ostras"],
    :principal => ["Picanha", "Macarrão", "Pizza"],
    :sobremesa => ["Pudim", "Sorvete", "Chocolate"]
}

puts escolhe(menu)