require "./person"

persons = []

file = File.new('./test-data.list')
file.each do |line|
  if line[0] != " " && line[1] != " "
    full_name = line.split(" --")[0]
    persons.push(
      Person.new(full_name.split(", ")[0], full_name.split(", ")[1])
    )
  end
end


unique_last_name_count = persons.uniq { |person| person.last_name }.length
unique_first_name_count = persons.uniq { |person| person.first_name }.length
unique_full_name_count = persons.uniq { |person| person.last_name && person.first_name }.length

puts "There are #{unique_full_name_count} unique full names."
puts "There are #{unique_first_name_count} unique first names."
puts "There are #{unique_last_name_count} unique last names."


ordred_person = persons.map { |person| {"#{person.first_name}": 1} }.group_by { |k| k.keys.first.to_s }.map do |g|
  {first_name: g[0], count: g[1].map { |e| e[:"#{g[0]}"] }.reduce(:+)}
end


puts "The ten most common first names are:"
ordred_person.sort_by { |p| -p[:count] }.first(10).each do |person|
  puts "  #{person[:first_name]} (#{person[:count]})"
end

ordred_person = persons.map { |person| {"#{person.last_name}": 1} }.group_by { |k| k.keys.first.to_s }.map do |g|
  {last_name: g[0], count: g[1].map { |e| e[:"#{g[0]}"] }.reduce(:+)}
end


puts "The ten most common last names are:"
ordred_person.sort_by { |p| -p[:count] }.first(10).each do |person|
  puts "  #{person[:last_name]} (#{person[:count]})"
end

