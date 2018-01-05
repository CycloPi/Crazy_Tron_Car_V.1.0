extends Control



func _ready():

	pass

#Ir al menu de Creditos
func _on_Button_pressed():
	print("Boton a los creditos")
	get_tree().change_scene("res://Menus/M-Creditos/M-Creditos.tscn")
	
#Ir al Play
func _on_Play_pressed():
	print("Boton de Play")
	get_tree().change_scene("res://Menus/SeleccionCoche/car_select.scn")
	
#Ir al menu de controles
func _on_Controles_pressed():
	get_tree().change_scene("res://Menus/Controles/controls.scn")
