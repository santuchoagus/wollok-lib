# Ideas
Una nota para no olvidarme las ideas.

## makeCycle
Hacer un ciclo o varios dependiendo del parametro, esta utilizaría wollok game.


## Spritesheet

mejora:
Agregar una clase o forma de agregar varios sprites de forma organizada,
y que esto facilite el manejo de animaciones con multiples direcciones.

spritesheet con keepindex, osea que si tenes varias animaciones que son largas y representan
como "caminar" por ej, no tiene sentido que cuando cambie de dirección vuelva a empezar

method comer() {
  		essentials.makeCycle(20, sprite.frames(), {image = sprite.cycle()} )
  	}
  	
keyboard.c().onPressDo({ pepita.comer() })

## Alfabeto
Agregar un alfabeto que funcione, que tome un buffer y lo escriba.