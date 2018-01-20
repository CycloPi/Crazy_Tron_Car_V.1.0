extends Spatial

#onready var fantasma_escena = preload("res://fantasma/fantasma.tscn")
var numero_frame = 0
var grabar_coche = true
var fantasma_corre = true
onready var  meta = get_node("meta")
onready var  parcial1 = get_node("parcial1")
onready var  parcial2 = get_node("parcial2")
onready var  parcial3 = get_node("parcial3")
onready var  parcial4 = get_node("parcial4")
onready var  parcial5 = get_node("parcial5")
onready var  parcial6 = get_node("parcial6")
onready var  parcial7 = get_node("parcial7")
onready var  parcial8 = get_node("parcial8")
onready var  parcial9 = get_node("parcial9")
onready var  parcial10 = get_node("parcial10")
var vueltas = 0

############ posiciones coche ###########################################
var	posicion_coche_x_0 = []
var	posicion_coche_x_1 = []
var	posicion_coche_x_2 = []
	
var	posicion_coche_y_0 = []
var	posicion_coche_y_1 = []
var	posicion_coche_y_2 = []
	
var	posicion_coche_z_0 = []
var	posicion_coche_z_1 = []
var	posicion_coche_z_2 = []

var origen_coche_0 = []
var origen_coche_1 = []
var origen_coche_2 = []

### posiciones circuito####

var	posicion_fantasma_circuito_1_x_0 = []
var	posicion_fantasma_circuito_1_x_1 = []
var	posicion_fantasma_circuito_1_x_2 = []
	
var	posicion_fantasma_circuito_1_y_0 = []
var	posicion_fantasma_circuito_1_y_1 = []
var	posicion_fantasma_circuito_1_y_2 = []
	
var	posicion_fantasma_circuito_1_z_0 = []
var	posicion_fantasma_circuito_1_z_1 = []
var	posicion_fantasma_circuito_1_z_2 = []

var origen_fantasma_circuito_1_0 = []
var origen_fantasma_circuito_1_1 = []
var origen_fantasma_circuito_1_2 = []

## para que se mueva el cubo y no el nodo principal ###
onready var fantasma_body = get_node("fantasma")
var direccion = "res://fantasma.json"
func save_game():	
	
	var salvar = {
	"posicion_fantasma_circuito_1_x_0":posicion_fantasma_circuito_1_x_0,
	"posicion_fantasma_circuito_1_x_1":posicion_fantasma_circuito_1_x_1,
	"posicion_fantasma_circuito_1_x_2":posicion_fantasma_circuito_1_x_2,
	
	"posicion_fantasma_circuito_1_y_0":posicion_fantasma_circuito_1_y_0,
	"posicion_fantasma_circuito_1_y_1":posicion_fantasma_circuito_1_y_1,
	"posicion_fantasma_circuito_1_y_2":posicion_fantasma_circuito_1_y_2,
	
	"posicion_fantasma_circuito_1_z_0":posicion_fantasma_circuito_1_z_0,
	"posicion_fantasma_circuito_1_z_1":posicion_fantasma_circuito_1_z_1,
	"posicion_fantasma_circuito_1_z_2":posicion_fantasma_circuito_1_z_2,
	
	"origen_fantasma_circuito_1_0": origen_fantasma_circuito_1_0,
	"origen_fantasma_circuito_1_1": origen_fantasma_circuito_1_1,
	"origen_fantasma_circuito_1_2": origen_fantasma_circuito_1_2
	}
	
	var file = File.new()
	file.open(direccion, file.WRITE)
	file.store_line(salvar.to_json())
	file.close()	
	
func load_game():  
	
	var file = File.new()
	if not file.file_exists(direccion):
		return
	
	file.open(direccion, File.READ)
	var data = {}
	data.parse_json(file.get_as_text())
	
	posicion_fantasma_circuito_1_x_0 = data.posicion_fantasma_circuito_1_x_0
	posicion_fantasma_circuito_1_x_1 = data.posicion_fantasma_circuito_1_x_1
	posicion_fantasma_circuito_1_x_2 = data.posicion_fantasma_circuito_1_x_2
	
	posicion_fantasma_circuito_1_y_0 = data.posicion_fantasma_circuito_1_y_0
	posicion_fantasma_circuito_1_y_1 = data.posicion_fantasma_circuito_1_y_1
	posicion_fantasma_circuito_1_y_2 = data.posicion_fantasma_circuito_1_y_2
	
	posicion_fantasma_circuito_1_z_0 = data.posicion_fantasma_circuito_1_z_0
	posicion_fantasma_circuito_1_z_1 = data.posicion_fantasma_circuito_1_z_1
	posicion_fantasma_circuito_1_z_2 = data.posicion_fantasma_circuito_1_z_2

	origen_fantasma_circuito_1_0 = data.origen_fantasma_circuito_1_0
	origen_fantasma_circuito_1_1 = data.origen_fantasma_circuito_1_1
	origen_fantasma_circuito_1_2 = data.origen_fantasma_circuito_1_2

func _ready():
	
	
	load_game()
	#### #### escone la meta del coche, esconde la leyermask (.hide no sive) ####
	meta.set_layer_mask_bit(0,false)
	parcial1.set_layer_mask_bit(0,true)
	parcial2.set_layer_mask_bit(0,false)
	parcial3.set_layer_mask_bit(0,false)
	parcial4.set_layer_mask_bit(0,false)
	parcial5.set_layer_mask_bit(0,false)
	parcial6.set_layer_mask_bit(0,false)
	parcial7.set_layer_mask_bit(0,false)
	parcial8.set_layer_mask_bit(0,false)
	parcial9.set_layer_mask_bit(0,false)
	parcial10.set_layer_mask_bit(0,false)
	
	grabar_coche()
	
	set_fixed_process(true)
	


### hace correr al fantasma recorriendo las listas del diccionario con "numero_frame" ###
func fantasma_corre():
#	var nodo_fantasma = get_tree().get_root().get_node("fantasma")
#	# cambiar
	
	if posicion_fantasma_circuito_1_x_0.empty():
		pass
	else:
		fantasma_body.set_global_transform(Transform(
		
		Vector3(posicion_fantasma_circuito_1_x_0[numero_frame] , posicion_fantasma_circuito_1_x_1[numero_frame] , posicion_fantasma_circuito_1_x_2[numero_frame]),
		Vector3(posicion_fantasma_circuito_1_y_0[numero_frame] , posicion_fantasma_circuito_1_y_1[numero_frame] , posicion_fantasma_circuito_1_y_2[numero_frame]),
		Vector3(posicion_fantasma_circuito_1_z_0[numero_frame] , posicion_fantasma_circuito_1_z_1[numero_frame] , posicion_fantasma_circuito_1_z_2[numero_frame]),
		Vector3(origen_fantasma_circuito_1_0[numero_frame],origen_fantasma_circuito_1_1[numero_frame],origen_fantasma_circuito_1_2[numero_frame])))
		
		if numero_frame >= posicion_fantasma_circuito_1_x_0.size()-1:
			pass
		else: numero_frame +=1

func grabar_coche():	
	### apendiza a las listas del diccionario la matrix3x4 ####
	var coche_nodo = get_tree().get_root().get_node("carrera/PosicionSalida/car/BODY")
#	
	posicion_coche_x_0.append(coche_nodo.get_global_transform().basis.x[0])
	posicion_coche_x_1.append(coche_nodo.get_global_transform().basis.x[1])
	posicion_coche_x_2.append(coche_nodo.get_global_transform().basis.x[2])
	
	posicion_coche_y_0.append(coche_nodo.get_global_transform().basis.y[0])
	posicion_coche_y_1.append(coche_nodo.get_global_transform().basis.y[1])
	posicion_coche_y_2.append(coche_nodo.get_global_transform().basis.y[2])
	
	posicion_coche_z_0.append(coche_nodo.get_global_transform().basis.z[0])
	posicion_coche_z_1.append(coche_nodo.get_global_transform().basis.z[1])
	posicion_coche_z_2.append(coche_nodo.get_global_transform().basis.z[2])
	
	origen_coche_0.append(coche_nodo.get_global_transform().origin[0])
	origen_coche_1.append(coche_nodo.get_global_transform().origin[1])
	origen_coche_2.append(coche_nodo.get_global_transform().origin[2])
	
	
func _fixed_process(delta):
	if grabar_coche:
		grabar_coche()
		
	if fantasma_corre:
		fantasma_corre()

# area que hace que deje de grabar las posiciones del coche  "meta"
func _on_meta_body_enter( body ):
		
	if posicion_fantasma_circuito_1_x_0.empty() or posicion_coche_x_0.size() < posicion_fantasma_circuito_1_x_0.size():
#		
		posicion_fantasma_circuito_1_x_0 = posicion_coche_x_0
		posicion_fantasma_circuito_1_x_1 = posicion_coche_x_1
		posicion_fantasma_circuito_1_x_2 = posicion_coche_x_2
	
		posicion_fantasma_circuito_1_y_0 = posicion_coche_y_0
		posicion_fantasma_circuito_1_y_1 = posicion_coche_y_1
		posicion_fantasma_circuito_1_y_2 = posicion_coche_y_2
		
		posicion_fantasma_circuito_1_z_0 = posicion_coche_z_0
		posicion_fantasma_circuito_1_z_1 = posicion_coche_z_1
		posicion_fantasma_circuito_1_z_2 = posicion_coche_z_2
		
		origen_fantasma_circuito_1_0 = origen_coche_0
		origen_fantasma_circuito_1_1 = origen_coche_1
		origen_fantasma_circuito_1_2 = origen_coche_2
		
		save_game()
		load_game()
	numero_frame = 0
	
	posicion_coche_x_0.clear()
	posicion_coche_x_1.clear()
	posicion_coche_x_2.clear()
	
	posicion_coche_y_0.clear()
	posicion_coche_y_1.clear()
	posicion_coche_y_2.clear()
	
	posicion_coche_z_0.clear()
	posicion_coche_z_1.clear()
	posicion_coche_z_2.clear()

	origen_coche_0.clear()
	origen_coche_1.clear()
	origen_coche_2.clear()

	parcial1.set_layer_mask_bit(0,true)
#	meta.set_layer_mask_bit(0,false)
	print ("meta")
	vueltas += 1
	print ("vueltas: " + str(vueltas))
	

func _on_parcial1_body_enter( body ):
	#### hace vidible  la meta del coche, hace visible la leyermask  ####
	parcial2.set_layer_mask_bit(0,true)
	meta.set_layer_mask_bit(0,false)
#	parcial1.set_layer_mask_bit(0,false)     
	print ("parcial1")
	pass
func _on_parcial2_body_enter( body ):
	parcial3.set_layer_mask_bit(0,true)
	parcial1.set_layer_mask_bit(0,false)
#	parcial2.set_layer_mask_bit(0,false)
	print ("parcial2")
	pass # replace with function body
	
func _on_parcial3_body_enter( body ):
	parcial4.set_layer_mask_bit(0,true)
#	parcial3.set_layer_mask_bit(0,false)
	parcial2.set_layer_mask_bit(0,false)
	print ("parcial3")
	pass # replace with function body
	
func _on_parcial4_body_enter( body ):
	parcial5.set_layer_mask_bit(0,true)
#	parcial4.set_layer_mask_bit(0,false)
	parcial3.set_layer_mask_bit(0,false)
	print ("parcial4")
	pass # replace with function body
	
func _on_parcial5_body_enter( body ):
	parcial6.set_layer_mask_bit(0,true)
#	parcial5.set_layer_mask_bit(0,false)
	parcial4.set_layer_mask_bit(0,false)
	print ("parcial5")
	pass # replace with function body
	
func _on_parcial6_body_enter( body ):
	parcial7.set_layer_mask_bit(0,true)
#	parcial6.set_layer_mask_bit(0,false)
	parcial5.set_layer_mask_bit(0,false)
	print ("parcial6")
	pass # replace with function body
	
func _on_parcial7_body_enter( body ):
	parcial8.set_layer_mask_bit(0,true)
#	parcial7.set_layer_mask_bit(0,false)
	parcial6.set_layer_mask_bit(0,false)
	print ("parcial7")
	pass # replace with function body
	
func _on_parcial8_body_enter( body ):
	parcial9.set_layer_mask_bit(0,true)
#	parcial8.set_layer_mask_bit(0,false)
	parcial7.set_layer_mask_bit(0,false)
	print ("parcial8")
	pass # replace with function body
	
func _on_parcial9_body_enter( body ):
	parcial10.set_layer_mask_bit(0,true)
#	parcial9.set_layer_mask_bit(0,false)
	parcial8.set_layer_mask_bit(0,false)
	print ("parcial9")
	pass # replace with function body
	
func _on_parcial10_body_enter( body ):
	meta.set_layer_mask_bit(0,true)
#	parcial10.set_layer_mask_bit(0,false)
	parcial9.set_layer_mask_bit(0,false)
	print ("parcial10")
	pass # replace with function body






