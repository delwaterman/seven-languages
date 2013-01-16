# FILENAME = 'generic_text.txt'

expression = ARGV[0]
filename = ARGV[1]

f = File.open(filename, 'r')
f.each do |line|
  if /#{expression}/i =~ line
    puts "#{f.lineno}: #{line}"
  end
end

f.close()