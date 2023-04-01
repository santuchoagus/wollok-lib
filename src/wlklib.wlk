object __wlklib__ {
	method get0s(_path, _i) {
		if (_path.contains("#")) {
			const _newpath = _path.substring(_path.indexOf("#") + 1)
			return self.get0s(_newpath,_i + 1)
		}
		return _i
	}
	
	method zeroed(number, digits) {
		//number = 324
		var n = (number/10).truncate(0)
		//n = 32
		var rem = number%10
		//rem 4
		if (digits > 1) { return self.zeroed(n, digits-1).toString() + rem.toString() }
		return rem.toString()
	}
}

package spriteModule {
 
	/* Clase Sprite, permite tener un mejor control de los frames de los elementos visuales
	 * de wollok.
	 * 
	 * para información de como utilizarla leer el README.md del repositorio
	 * https://github.com/santuchoagus/wollok-lib
	 */
	class Sprite {
		const property frames
		const property path
		const _digits = __wlklib__.get0s(path, 0) //retorna el numero de "#" del sprite.
		var cycleRange = [0, frames-1]
		var index = 0
		/* Formato path:
		 * Usar un solo caracter # en donde va el número
		 * ejemplos...
		 * "sprite/personaje-#_anim.png" 
		 * "personaje/pj_#.jpg"
		 */
		
		method getFrame(_frame) {
			if (_digits > 1) {
				return  (
						path.substring(0,path.indexOf("#")) + 
						__wlklib__.zeroed(_frame,_digits) +
				 		path.substring(path.lastIndexOf("#")+1, path.length())
				 		)
				 
			} else return path.replace('#',_frame.toString())
		}
		// Steps negativos invierten la animación.
		method cycle(step) {
			index = (cycleRange.last()-cycleRange.first() + 1 + index + step) % (cycleRange.last()-cycleRange.first()+1)
			return self.getFrame()
		}
	
		method getFrame() {	return self.getFrame(index + cycleRange.first()) }
		
		// Metodos para setear un frame en particular o un offset.
		method setFrame(_frame) {
			/* frame = index + cyclefirst
			 * index = frame - cyclefirst
			 */
			index = _frame - cycleRange.first()
			return self.getFrame()
		}
		method setIndex(_index) { 
			index = _index
			return self.getFrame()
		}
		
		method cycle() {
			index = (index + 1) % (cycleRange.last()-cycleRange.first() + 1)
			return self.getFrame()
		}
		
		
		// frame  first  x
		// x = frame + first
		
		// Rango de ciclo (primer y ultimo frame) setter y getter.
		method setRange(_firstframe, _lastframe) { 
			cycleRange = [_firstframe, _lastframe]
			return self.getFrame(_firstframe)
		}
		method getRange() = cycleRange.first()..cycleRange.last()
	}
	
	/* NO INSTANCIAR LAS CLASES DE ACÁ ABAJO!!!!!!!!
	 * Wollok no deja poner mixins en paquetes por lo tanto
	 * no se puede hacer herencias que no sean entre clases y estén
	 * dentro del mismo paquete.
	 */
}
