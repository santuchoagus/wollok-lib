package spriteModule {
	/* 
	 * Clase Sprite, permite tener un mejor control de los frames de los elementos visuales
	 * de wollok.
	 * 
	 * para información de como utilizarla leer el README.md del repositorio
	 * https://github.com/santuchoagus/wollok-lib
	 * 
	 */
	class Sprite {
		const property frames
		const property path
		var cycleRange = [0, frames-1]
		var index = 0
		/* Formato path:
		 * Usar un solo caracter # en donde va el número
		 * ejemplos...
		 * "sprite/personaje-#_anim.png" 
		 * "personaje/pj_#.jpg"
		 * */
		
		method getFrame(_frame) {
			//const _index = _frame % (cycleRange.last()-cycleRange.first()+1)
			//return path.replace('#', (_index + cycleRange.first()).toString())
			return path.replace('#',_frame.toString())
		}
		// Steps negativos invierten la animación.
		method cycle(step) {
			index = (cycleRange.last()-cycleRange.first() + 1 + index + step) % (cycleRange.last()-cycleRange.first()+1)
			return self.getFrame()
		}
	
		method getFrame() {	return path.replace('#', (index + cycleRange.first()).toString()) }
		
		method cycle() {
			index = (index + 1) % (cycleRange.last()-cycleRange.first() + 1)
			return self.getFrame()
		}
		
		// Rango de ciclo (primer y ultimo frame) setter y getter.
		method setRange(_firstframe, _lastframe) { 
			cycleRange = [_firstframe, _lastframe]
			return self.getFrame(_firstframe)
		}
		method getRange() = cycleRange.first()..cycleRange.last()
	}
}