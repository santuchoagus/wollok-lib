## Modulo de Sprites
Para instanciar un objeto de tipo sprite, se necesita primero importar la clase `Sprite` dentro del modulo `spriteModule`.
```wollok
import wlklib.spriteModule.Sprite
```
Se debe inicializar los [atributos](#Atributos) frames y path a la hora de instanciarlo, de la siguiente forma
```wollok
const spriteObj = new Sprite(frames = int, path = String)
```
### Atributos
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
  _Los sprites tienen que estar numerados con números enteros como 0, 1, 2… No deben tener ceros adelante como 01, 02, 03.._

### Metodos

|Metodos    | Descripción |
|---|---|
| getFrame() | Devuelve la ruta del frame actual (en string) |
| getFrame(n) | Devuelve el frame numero "n" del sprite. |
| cycle() | Pasa al siguiente frame dentro del rango, si es el último vuelve a empezar. |
| cycle(n) | Pasa a los siguientes "n" frames, si n es negativo, la dirección es sentido contrario. |
| setCycleRange(n, m) | Hace que el rango de frames del sprites sea entre "n" y "m" (numeros enteros). <br /> Por defecto al instanciar un objeto de clase Sprite su rango es Range(0,frames-1).<br /><br /> Ejemplo: si el sprite tiene 20 frames su rango inicial es Range(0,19) ya que asume que el inicial es 0. <br />Usando setCycleRange(2, 10) en este caso, los sprites irian desde 2 a 10.|
| getCycleRange()| Devuelve un objeto de tipo "wollok Range" que representa el rango de frames del sprite. |