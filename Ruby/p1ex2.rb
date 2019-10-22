
def mencao(nota)
    nota.to_f
    if nota == 0
        return 'SR'
    elsif nota >= 0.1 and nota <= 2.9
        return 'II'
    elsif nota >= 3 and nota <= 4.9
        return 'MI'
    elsif nota >= 5 and nota <= 6.9
        return 'MM'
    elsif nota >= 7 and nota <= 8.9
        return 'MS'
    elsif nota >= 9 and nota <= 10
        return 'SS'
    elsif nota > 10
        return 'Insira uma nota válida'
    end
end