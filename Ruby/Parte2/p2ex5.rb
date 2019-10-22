def notas_e_materias n
    materias_disponíveis = [
        'Cálculo 1',
        'Cálculo 2',
        'Cálculo 3',
        'Física 1',
        'Física 2',
        'Estruturas de Dados',
        'Algorítmos e Programação de Computadores',
        'Técnicas de Programação 1',
        'Sistemas Digitais',
        'Eletromagnetismo'    
    ]

    notas = []
    materias = []
    for i in (0...n)
        materias.push(materias_disponíveis.sample)
        notas.push(rand(0..10))
    end
    return notas, materias
end

puts notas_e_materias(5)