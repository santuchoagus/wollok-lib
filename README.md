# 😁 Wollok-lib Librería de Wollok! 😁
Esta librería es un proyecto con utilidades para el manejo de objetos visuales de la biblioteca [wollok.game](https://www.wollok.org/documentacion/wollokdoc/), con el fin de facilitar las animaciones de los _sprites_[^sprite].<br />
Cualquier sugerencia es bienvenida, pueden mandarme al Discord: Pop#1912
<br /><br />
**También puede mandarme para preguntarme como utilizar correctamente la librería si la documentación no se entiende.**

En el repositorio está lo importante que es el archivo `wlklib.wlk` que debe ir en la carpeta `src` para que la librería se pueda importar.
Luego para importar todos los elementos de la librería `import wlklib.(modulo).*` si se quisiera importar todos los elementos de un modulo particular, ejemplo si quisieramos importar solamente
el [modulo de sprites](#sprm) bastaría con hacer `import wlklib.spriteModule.*` en el archivo que se desea utilizar.

#### Algunos trucos con la librería que les facilitan la vida en vez de volverse locos ❗❗
1. [Como ciclar infinitamente](#pepita-cicla)
1. [Como animar un objeto al tocar una tecla](#pepa-come)

## Tabla de contenido
1. [¿Para que Wollok-lib?](#faq)
1. [spriteModule](#sprm)
    - [Atributos](#sprm-atb)
    - [Metodos](#sprm-mtd)
1. [Objeto essentials](#esse)
  
  
## ¿Para que sirve wollok-lib? <span id="faq"></span>
**RESUMEN:** wollok-lib facilita el manejo de sprites, con respecto a las animaciones y _colisiones_ (pronto), en base a la clase `class Sprite {}` que nos permite una interfaz amigable para el control de cada _frame_[^frame] (fotograma), la velocidad y el rango de cada una de las animaciones.

**CON WOLLOK-GAME:** Cuando tenemos un objeto, y queremos darle una representación grafica dentro del contexto de wollok game, esta librería nos indica que para poder visualizarlo, el objeto debe poder entender los metodos `image()` y `position()` el cual nos debe retornar una imagen como string, y un objeto de tipo `wollok.game.Position`, que se puede crear utilizando `wollok.game.at` como `game.at(x,y)` y devuelve un objeto Position.
```wollok
object objetoPrueba {
	// Estas son dos propiedades y metodos de wollok-game, no de la libreria.
	var property image = "imagenes/imagen-0.jpg"
	var property position = game.at(0,0)
```
_"imagenes/imagen-0.jpg" representa una de las imagenes dentro de la carpeta `Proyecto/assets/imagenes/`_

De esta forma wollok nos permite dibujar al objeto cuando lo pasemos por parametro en `game.addVisual(objetoPrueba)`.
Pero si quisieramos animarlo tendríamos que rediseñar una lógica de como va a cambiar el sprite a lo largo del tiempo.

Gracias a wollok-lib, tenemos la clase `wlklib.spriteModule.Sprite` que nos permite manejar la lógica de la animación utilizando unos [métodos](#sprm-mtd) más sencillos, y para empezar a aprovechar solamente basta con crear un nuevo objeto de este tipo.
```wollok
object objetoPrueba {
	/* En "frames" va la cantidad de frames, ejemplo:
	 * si va del "imagen-0.png" al "imagen-13.png", entonces frames=14
	 * 
	 * En "path" va el string que representa la ruta de los sprites.
	 * en esta ruta va un numeral "#" que indica el número que ordena estos sprites.
	 * la clase Sprite asume que el primer número es 0.*/
	const sprite = new Sprite(frames = 14, path="imagenes/imagen-#.png")
	
	// Estas son dos propiedades de wollok-game, no de la libreria.
	var property image = sprite.getFrame() // incializo la imagen como el primer frame en vez de especificarla.
	var property position = game.at(0,0)
```
Por ahora el comportamiento es el mismo, el metodo `getFrame()` me va a dar la imagen-0, o mejor dicho, la imagen actual (que en este caso es la primera).
Si quisieramos inicializarlo con una imagen en particular, podemos pasarle por parametro cual es la imagen (o frame) que estamos buscando.
```wollok
var property image = sprite.getFrame(5) // Incializo con el frame 5, es decir "imagenes/imagen-5.png"
```

De igual forma, esto es solo una de las formas que podemos acceder a distintos frames, pero si quisieramos animarlo solo con esto tendríamos que crear la lógica que incremente el parametro para conseguir siempre un frame distinto (el siguiente).<br/><br/>
<span id="pepita-cicla"><strong>Como darle vida a pepita (animarla)</strong></p><span>
Para no reinventar la rueda por cada objeto que queramos animar, una vez creado el objeto de tipo Sprite, podemos pasar al siguiente frame utilizando: `sprite.cycle()`. Este metodo en principio no parece hacer nada, pero lo que este retorna, es siguiente frame en base al que está actualmente, y situa el frame actual (al cual accedemos con `sprite.getFrame()`) como este nuevo.

```wollok
object objetoPrueba {
	const sprite = new Sprite(frames = 14, path="imagenes/imagen-#.png")
  
	var property image; // objetoPrueba.image() retorna el objeto null
  
  image = sprite.getFrame() // sprite.getFrame() retorna "imagenes/imagen-0.png"
  sprite.cycle() // Paso al siguiente frame.
  image = sprite.getFrame() // sprite.getFrame() retorna "imagenes/imagen-1.png"
  sprite.cycle() // Paso al siguiente frame.
  image = sprite.getFrame() // sprite.getFrame() retorna "imagenes/imagen-2.png"
  /*              .
  *               .
  *               .
  * Al llegar a la ultima imagen, sprite.getFrame() retorna la primera nuevamente.
  */
```
De esta forma podemos solamente definir un metodo general que haga un ciclo y retorne el frame actual.
```wollok
object objetoPrueba {
	const sprite = new Sprite(frames = 14, path="imagenes/imagen-#.png")
	var property image;
  
  method ciclarSprite() {
    image = sprite.getFrame() // sprite.getFrame() retorna el frame actual.
    sprite.cycle() // Paso al siguiente frame.
  }
}
```
_También se puede utilizar `sprite.Cycle(n)` el cual salta "n" frames, si se ponen valores negativos la animación va en la dirección contraria._

De esta forma, al utilizar el metodo `game.onTick(milliseconds, name, action)` de la libreria wollok.game que nos ejecuta una acción (un bloque) cada ciertos milisegundos, podemos definir en alguna parte del codigo o un "wollok program" (.wpgm) el siguiente.

<div align='center'>
 <p>Pepita cambia de estado a cada rato (darle a play al video)</p>
 <img src="https://user-images.githubusercontent.com/97124374/229312160-5e87988e-b3f3-4c79-b03a-7ac51e2964da.gif" width="440">
</div>

```wollok
import wollok.game.*
import objects.objetoPrueba

/* Por acá se empieza a ejecutar */
program main {
  // Configuraciones generales de wollok game (el tamaño y resolución del tablero)
  game.cellSize(128)
  game.width(8)
  game.height(6)
  
  // Agrego a "objetoPrueba" como un objeto visual de wollok game.
  game.addVisualCharacter(objetoPrueba)
  
  // El elemento importante: Cada 500 ticks se llama al metodo que controla la animación.
  game.onTick(500, "animar objeto", {objetoPrueba.ciclarSprite()})
  game.start()
}
```

Dentro de la definición del "objetoPrueba", una vez creado el objeto de tipo Sprite, también podemos definir un rango de frames que vamos a utilizar para la animación. Al momento de crear el sprite el rango es `Range(0, frames-1)` es decir, si al instanciar el objeto de tipo Sprite le indicamos que tiene 14 frames en total, el rango es `Range(0, 13)` (va desde img-0.jpg a img-13.jpg)

Utilizando el metodo `setRange(n, m)` podemos indicar que el rango de imagenes para ese sprite empieza en el frame numero "n" y termina en el numero "m".<br />
Ejemplo: si nuestras imagenes empiezan a contar desde "img-1.jpg", al crear el sprite la librería asume que empieza de "img-0.jpg" y este no existe, entonces una vez creado tendríamos que llamar al metodo setRange().<br/>
Si tuvieramos desde "img-1.jpg" hasta "img-5.jpg" entonces tendriamos 5 frames en total:
```wollok
object objetoPrueba {
	const sprite = new Sprite(frames = 5, path="imagenes/imagen-#.png")
  // wlklib asume que los frames estan numerados desde 0 a 4, por lo que Range(0,4)
  
  // para cambiarlo llamo al metodo después de crear el objeto con el nuevo rango.
  // al asignarlo este retorna el primer frame del rango: "imagenes/imagen-#.png"
	var property image = sprite.setRange(1, 5)
```

<span id="pepa-come"><strong>Como hacer que "pepa" coma al tocar una tecla:</strong></p><span>
Otra de las cosas que se puede hacer con esta libreria, es ciclar una cantidad fija de frames en el tiempo, y esto solamente
requiere una linea de codigo!

Supongamos que queremos hacer una animación cuando un personaje llamado "pepa" controlado por el jugador, presiona la tecla "c"
para comer. Primero definimos el objeto como veníamos haciendo, y definidos su sprite (observación: puede ser otro sprite distinto y esa es la magia!)

```wollok
object pepa {
	const property sprite = new Sprite(frames = 14, path="sprites/sprite-de-prueba/frame-#.png")
	
	var property image = sprite.getFrame()
	var property position = game.at(0,0)
	
	method comer() { }
```
Para utilizar esta funcionalidad de la librería, tenemos que recurrir al objeto "essentials" que se encuentra en la librería
y para eso hay que importarlo primero con `import wlklib.essentials`

La funcionalidad que vamos a utilizar, es uno de los metodos del objeto "essentials" que se llama `makeCycle`. Su función es repetir una acción
una cierta cantidad de veces entre un lapso de tiempo, sin frenar el flujo del programa.<br />
Para saber mas sobre esta funcionalidad pueden ir a los metodos del objeto essentials.

Ahora definamos que cuando "pepa" come, se repite una acción, que en este caso va a a ser que si sprite de un ciclo y se asigne la nueva imagen a pepa.
```wollok
method comer() {
	// 50 son los milisegundos por cada frame.
	// sprite.frames() retorna la cantidad de frames que tiene el sprite (osea 14).
	/* {sprite.cycle()} es el bloque que se va a ejecutar, podrían ser instrucciones
	* cualesquiera, se ejecutarían 14 veces en este caso.
	*/
	essentials.makeCycle(50, sprite.frames(), { image = sprite.cycle() } )
}
```

Y listo es así de sencillo! ahora cada  vez pepita come, su animación cicla 14 veces cada 50 milisegundos.<br/><br/>
Una observación es que si llamaramos a comer repetidas veces antes de que termine su primer ciclo, pepa lo haría mucho mas rapido
ya que se superponen, de igual forma esto no hace que se rompa, siempre va a avanzar 14 veces cada  vez que se llame el metodo (en este caso, 14 es su cantidad de frames por lo que cada vez que se llama hace un ciclo completo).

Para implementar que pepita solo pueda ser llamada una vez, se puede utilizar uno de los metodos de `wollok.game` llamado `schedule` el cual ejecuta un bloque de codigo despues de un tiempo especifico al ser llamado, en este caso si la animación cicla cada 50ms y lo hace 14 veces (50ms por frame) entonces le damos un schedule de 14*50 = 700 milisegundos para poder presionarlo denuevo, a partir de una condición.
```wollok
object pepa {
    const property sprite = new Sprite(frames = 14, path="sprites/sprite-de-prueba/frame-#.png")
    var property image = sprite.getFrame()
    var property position = game.at(0,0)
    var flag_comiendo = false // creo una nueva variable que representa si pepa esta comiendo o no.

    method comer() {
	// Si pepita no está comiendo, se ejecuta lo de adentro.
	    if (!flag_comiendo) {
		flag_comiendo = true // Si no está comiendo, empieza a comer, solo puede hacerlo 1 vez cada 700 ms.
		essentials.makeCycle(50, sprite.frames(), { image = sprite.cycle() } )
		// A los 700ms se ejecuta el codigo de adentro que vuelve a poner el flag en false, y permite hacer que coma denuevo!
		game.schedule(700, { flag_comiendo=false })
	     }
     }
}
```
Y ahora si, pepa come y su animación e interacción no se ve afectada si tocamos la "c" muchas veces mientras come, pepa solo come de a mordiscos! Y todo esto es controlado por 1 sola linea de codigo que corresponde a wollok-lib, y una de wollok.game!.

<div align='center'>
 <p>Pepa come una vez cada 7000ms! (darle play al video)</p>
 <img src="https://user-images.githubusercontent.com/97124374/229312181-86d7031c-8344-4023-adb6-430ed90a56d9.gif" width="440">
</div>


<br/><br/><br/><br/>
## 📦 Modulo de Sprites <span id="sprm"><span>
Para instanciar un objeto de tipo sprite, se necesita primero importar la clase `Sprite` dentro del modulo `spriteModule`.
```wollok
import wlklib.spriteModule.Sprite
```
Se debe inicializar los [atributos](#Atributos) frames y path a la hora de instanciarlo, de la siguiente forma
```wollok
const spriteObj = new Sprite(frames = int, path = String)
```
### Atributos <span id="sprm-atb"><span>
- **frames**
  Número entero de frames que tiene la animación/sprite. Ejemplo si la animación va desde `caminar-0.png` a `caminar-7.png` entonces `frames = 8`
- **path**
  La ruta desde la carpeta assets o img utilizando wollok.game. Ejemplo:
  Si tuvieramos las siguientes imagenes
  imagen-0.png, imagen-1.png, imagen-2.png … imagen-47.png
  en la ruta: `Proyecto/assets/animacion` entonces el atributo path debería ser inicializado como 
  ```
  path = "Proyecto/assets/animacion/imagen-#.png"
  ```
  En donde `#` representa la parte del nombre del sprite por donde se ordenan numericamente los sprites.
  _Los sprites tienen que estar numerados con números enteros como (0, 1, 2 ... 511, 512)

  De ocurrir que los sprites estén numerados con ceros delante como 00, 01, 02.. o 000, 001, 002... etc.
  el path tiene que tener la misma cantidad de "#" que de digitos.

  Ejemplo:<br />
  Si los sprites van desde "imagen-000.png" a "imagen-049.png" entonces `path="imagen-###.png"`
### Metodos <span id="sprm-mtd"><span>

|Metodos    | Descripción |
|---|---|
| getFrame() | Devuelve la ruta del frame actual (en string) |
| getFrame(n) | Devuelve el frame numero "n" del sprite. |
| setFrame(n)| Setea el frame actual en el numero "n", retorna este mismo frame. <br />Observación: Nostese que a diferencia de getFrame(n), setFrame(n) cambia el estado interno del objeto para que el siguiente al utilizar cycle() sea n + 1, a diferencia de getFrame(n) que solamente retoran el frame "n" pero no garantiza que el siguiente sea n + 1.|
| setIndex(n)| Setea el frame actual "n" mas adelante del primero, es decir si el primer frame es el 0 (como por default) setIndex() se comporta igual que setFrame(), mientras que si el primer frame del rango no es el 0 (ejemplo: un rango entre 5 y 11, el primer frame sería el 5. Con setIndex(n) lo seteamos en "5 + n", a diferencia de setFrame(n) que solamente lo setea en el frame "n" sin importar el rango. |
| cycle() | Pasa al siguiente frame dentro del rango, si es el último vuelve a empezar.<br /><br /> Retorna el nuevo frame. |
| cycle(n) | Pasa a los siguientes "n" frames, si n es negativo, la dirección es sentido contrario.<br /><br /> Ejemplo: sprite.cycle(-1) hace el ciclo en sentido contrario (decreciente).<br /><br /> Retorna el nuevo frame.|
| setRange(n, m) | Hace que el rango de frames del sprites sea entre "n" y "m" (numeros enteros), y retorna el primer frame (el numero "n"). <br /> Por defecto al instanciar un objeto de clase Sprite su rango es Range(0,frames-1).<br /><br /> Ejemplo: si el sprite tiene 20 frames su rango inicial es Range(0,19) ya que asume que el inicial es 0. <br />Usando setRange(2, 10) en este caso, los sprites irian desde 2 a 10.|
| getRange()| Devuelve un objeto de tipo "wollok Range" que representa el rango de frames del sprite. |


## 🛟 Objeto essentials <span id="esse"><span>

El objeto essentials tiene funcionalidades extras que no necesariamente son exclusivas para el manejo de los sprites, pero se complementa perfectamente con estos.
Para poder acceder a sus funcionalidades hay que importar el objeto con `import wlklib.essentials` y acceder a sus funcionalidades.

| Metodos | Descripción |
|---|---|
| makeCycle(ms, veces, bloque) | makeCycle ejecuta un bloque de codigo, (que es codigo entre corchetes) cada ciertos milisegundos especificados una cierta cantidad de veces <br/><br/>Ejemplo:<br/>essentials.makeCycle(20,55,{pepa.mirar()})<br/>Se ejecuta cada 20ms unas 55 veces pepa.mirar() (el bloque tiene que ir entre {})|

[^sprite]: Un sprite es una imagen, sprites en plurar es una secuencia de imágenes, generalmente con el objetivo de representar los fotogramas de una animación.
[^frame]: En el contexto de la animación, el frame (o fotograma) es una unica foto que compone toda la animación cuando los distintos frames van cambiando en orden a lo largo del tiempo.
