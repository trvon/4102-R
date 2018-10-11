above <- list()
below <- list()

a <- 0
y <- 0
z <- 0

print(" Enter 10 numbers between 1 and 100")


while  (a < 10) {
	n <- readline(prompt="Enter a number: ")
	val <- as.integer(n)

	if (val > 50) {
   		above[y] <- val
  		y = y + 1
  
	} else {
 		below[z] <- val
  		z = z + 1
	}

	a = a + 1
}

print ("Numbers above 50: ")
print(above)

print ("Numbers below 50: ")
print (below)
