extends Spatial

# varables animación desaparece
onready var coche = get_tree().get_root().get_node("/root/carrera/PosicionSalida/car/BODY")
onready var animacion = get_node("AniPotenciador")

# varables tiempo del poteciador
onready var HUDcoche = get_tree().get_root().get_node("/root/carrera/PosicionSalida/car/HubFlafo")
var tiempoToque = 0
var motorOriginal = 0


func _ready():
	set_fixed_process(true)
	animacion.play("default")
	

	

	

func _fixed_process(delta):
	#reloj = HUDcoche.segundosT
	retardoPotenicador(2)

func retardoPotenicador(tiempoR):
	if HUDcoche.segundosT - tiempoToque == tiempoR: # tiempo del potenciador
		coche.engine_force = motorOriginal

func _on_Area_body_enter( body ):
	tiempoToque = HUDcoche.segundosT
	motorOriginal = coche.engine_force
	coche.engine_force = 900
	hide()
	#queue_free()
	pass 
