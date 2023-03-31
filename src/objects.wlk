import wollok.game.*
import config.*
import sprites.*

object pepita {
	/* En "frames" va la cantidad de frames, ejemplo:
	 * si va del "frame-0.png" al "frame-13.png", entonces frames=14
	 * */
	const sprite = new Sprite(frames = 14, path="sprites/sprite-de-prueba/frame-#.png")
	var property image = sprite.getFrame()
	var property position = game.at(0,0)
	
	method getSprite() { return sprite }
	method ciclarAnimacion() {
		image = sprite.cycle()
  	}
}


object rueda {
	
	const property sprite = new Sprite(frames = 20, path = "sprites/wheel/wheel-#.png")
	var property image = sprite.getFrame()
	var property position = game.at(1,1)
}

object rueda2 {
	
	const property sprite = new Sprite(frames = 20, path = "sprites/wheel/wheel-#.png")
	var property image = sprite.getFrame()
	var property position = game.at(3,1)
}
