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

def concatena chaves, dados
    hash = Hash.new

    chaves.each_with_index do |chave, index|
        hash[chave] = dados[index]
    end    
    hash
end

class Aluno
    def initialize materias, notas
        @materias = materias
        @notas = concatena(materias, notas)
    end

    def materias
        @materias
    end

    def get_notas materia
        @notas[materia]
    end

    def set_notas materia, nota
        @notas[materia] = nota
    end

    def mencoes
        mencoes = Hash.new
        @notas.each_with_index do |(materia, nota), index|
            mencoes[@materias[index]] = mencao(nota)
        end
        mencoes
    end
end

materias = ['c1', 'c2', 'c3']
notas = [1,2,3]

aluno = Aluno.new(materias, notas)

puts aluno.mencoes
