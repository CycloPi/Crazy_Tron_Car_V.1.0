
extends VehicleBody

# Member variables car
const STEER_SPEED = 1
const STEER_LIMIT = 0.4

var steer_angle = 0
var steer_target = 0

export var engine_force = 40

# cyclo pi variables
var velo  = 1
var veloRef = 1
onready var imprimeVelo = get_owner().get_node("HubFlafo/Velocidad")
onready var imprimeAngu = get_owner().get_node("HubFlafo/Angulo")
onready var auja = get_owner().get_node("HubFlafo/Panel")
#onready var imprimeVeloLed = get_owner().get_node("HubFlafo/Velo150led")
onready var imprimePuntos = get_owner().get_node("HubFlafo/Puntos")

var banderaPuntos10 = false
var puntos = 0


func _fixed_process(delta):
	
	#modificación de gd original para hub velocidad
	#velo = 5*(get_linear_velocity().length())
	#imprimeVelo.set_text(str(int(velo))+" Km/h")
	
	# parte de pruebas
	#veloRef = (get_linear_velocity().length())
	#imprimeAngu.set_text(str(velo/150)+" grados a 150")
	
	# Pantalla de led con velocidad
	#imprimeVeloLed.set_text(str(int(velo)))
	#GDglobal.velo = velo
	
	#rotación velocimetro
	#auja.set_rotation(velo/150)
	
	
	
	if (Input.is_action_pressed("ui_left")):
		steer_target = -STEER_LIMIT
	elif (Input.is_action_pressed("ui_right")):
		steer_target = STEER_LIMIT
	else:
		steer_target = 0
	
	if (Input.is_action_pressed("ui_up")):
		set_engine_force(engine_force)
		
	else:
		set_engine_force(0)
		
	if (Input.is_action_pressed("ui_down")):
		set_engine_force(-engine_force)
#	if (Input.is_action_pressed("ui_down")):
#		set_engine_force(-engine_force)
#	else:
#		set_engine_force(0)
#	
	if (Input.is_action_pressed("ui_frenar")):
		set_brake(1)	
	
	
	if (steer_target < steer_angle):
		steer_angle -= STEER_SPEED*delta
		if (steer_target > steer_angle):
			steer_angle = steer_target
	elif (steer_target > steer_angle):
		steer_angle += STEER_SPEED*delta
		if (steer_target < steer_angle):
			steer_angle = steer_target
	
	set_steering(steer_angle)


func _ready():
	set_fixed_process(true)
