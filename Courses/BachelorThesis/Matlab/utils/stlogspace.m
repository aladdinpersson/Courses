function points = stlogspace(min, max, N)
points =sort(10.^((log10(max)-log10(min)).*rand([1,N])+log10(min)));
end