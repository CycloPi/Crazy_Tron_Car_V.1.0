extends Spatial

onready var coche = get_tree().get_root().get_node("/root/carrera/PosicionSalida/car/BODY")
onready var animacion = get_node("AniPotenciador")

func _ready():
#	set_fixed_process(true)
	animacion.play("default")

	pass

#func _fixed_process(delta):
#	
#	if coche 

func _on_Area_body_enter( body ):
	queue_free()	
	coche.engine_force = 20000000000
#	print (coche.engine_force)
	
	
	pass 
