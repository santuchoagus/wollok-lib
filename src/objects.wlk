import wollok.game.*
import wlklib.spriteModule.Sprite
import wlklib.essentials

object pepita {
	/* En "frames" va la cantidad de frames, ejemplo:
	 * si va del "frame-0.png" al "frame-13.png", entonces frames=14
	 * 
	 * En "path" va el string que representa la ruta de los sprites.
	 * en esta ruta va un numeral "#" que indica el número que ordena estos sprites.
	 * la clase Sprite asume que el primer número es 0.*/
	const property sprite = new Sprite(frames = 14, path="sprites/sprite-de-prueba-con-000/frame-###.png")
	
	// Estas son dos propiedades de wollok-game, no de la libreria.
	var property image = sprite.getFrame() // incializo la imagen como el primer frame.
	var property position = game.at(0,0)
	
	method ciclarAnimacion() {
		image = sprite.cycle() // Seteo la imagen al proximo sprite.
  	}
}