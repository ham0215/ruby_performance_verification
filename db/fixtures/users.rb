(1..100).each do |i|
  User.seed do |s|
    s.id = i
    s.name = "name#{i}"
  end
end
