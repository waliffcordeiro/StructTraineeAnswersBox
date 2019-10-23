def rand_notas n
    notas = []
    for i in (0...n)
        notas.push(rand(0..10))
    end
    notas
end

def passou? nota
    if nota == 'MM' or nota == 'MS' or nota == 'SS'
        return true
    else
        return false
    end
end

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
    @@id_counter = 0

    def initialize materias, notas
        @materias = materias
        @notas = concatena(materias, notas)

        @id = @@id_counter
        @@id_counter += 1
    end

    def materias
        @materias
    end

    def id
        @id
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

class Turma
    @@n_alunos = 0
    @@n_aprovados = 0
    def initialize materia, alunos 

        @materia = materia
        @alunos = alunos
        @n_aprovados_turma = 0

        @@n_alunos += alunos.length
    end

    def materia
        @materia
    end

    def alunos
        @alunos
    end

    def n_aprovados
        @@n_aprovados
    end

    def n_alunos
        @@n_alunos
    end

    def aprovados
        aprovados = Hash.new

        @alunos.each do |aluno|
            nota = aluno.mencoes
            nota.each do |(materia, mencao)|
                if materia == @materia and passou?(mencao)
                    aprovados[aluno.id] = mencao
                    @n_aprovados_turma += 1
                end
            end
        end
        @@n_aprovados += @n_aprovados_turma
        aprovados       
    end
end

materias_disponiveis = [
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

puts "Digite o número de matérias 'n'"
n = gets
n = n.to_i
while n <= 0 and n > 10
    puts "Digite um número entre 0 e 10"
    n = gets
    n.to_i
end

materias_aplicadas = []

# Fazendo o array de matérias aplicadas e garantindo que não haverão duplicatas
# Isso é garantido removendo-se as matérias já selecionadas
for i in (0...n)
    materias_aplicadas.push(materias_disponiveis.delete(materias_disponiveis.sample))
end

lista_de_alunos = []

# Criando todos os alunos do semestre
for i in (0...n)
    q = rand(0...20)
    turma = []
    for i in (0...q)
        aluno = Aluno.new(materias_aplicadas, rand_notas(n))
        turma.push(aluno)
    end
    lista_de_alunos.push(turma)
end

turmas = []
# Criando as turmas e colocando os alunos nela
for i in (0...n)
    turma = Turma.new(materias_aplicadas[i], lista_de_alunos[i])
    turmas.push(turma)
end

aprovados = []
turmas.each do |turma|
    aprovados.push(turma.aprovados)
end

n_alunos = turmas[0].n_alunos
percentual = 100*(turmas[0].n_aprovados.to_f/n_alunos.to_f)

puts "O total de alunos matriculados é: #{n_alunos}"
puts "O percentual de aprovados é: #{percentual}%"
puts '-----------------------------------------------'
puts aprovados
