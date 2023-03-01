OUT = project

run:
	v .
	mv ./vlang ./$(OUT)
	./$(OUT)
	make clean

clean:
	rm ./$(OUT)

prod:
	v . -prod
	mv ./vlang ./$(OUT)-prod