import wollok.game.*

// Configuración general, no afecta a la biblioteca wlklib.
object config {
	const property CELL_SIZE = 128
	const property SCR_W = 1024/CELL_SIZE
	const property SCR_H = 512/CELL_SIZE
	const BACKGROUND = ""
	const TITLE = ""
	
	
	method apply() {
		game.cellSize(CELL_SIZE)
		game.width(SCR_W)
		game.height(SCR_H)
		if (BACKGROUND != "") { game.boardGround(BACKGROUND) }
		if (TITLE != "") { game.title(TITLE) }			
	}
}
