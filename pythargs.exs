for a <- 1..100, b <- (a + 1)..100, c <- (b + 1)..100, a * a + b * b == c * c do
  IO.puts "a: #{a}, b: #{b}, c: #{c}"
end
