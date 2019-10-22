def bissexto?(ano)
    if ano % 400 == 0
        return true
    
    elsif ano % 100 == 0
        return false
    
    elsif ano % 4 == 0
        return true
    end
    return false
end

seculo20 = (1900..1999).to_a
bissextos = []

seculo20.each do |ano|
    bissextos << ano if bissexto?(ano)
end

puts bissextos
