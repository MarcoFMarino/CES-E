extends CanvasLayer

signal start 

func _ready():
	$EndTest.hide()
	get_tree().call_group("Words", "hide") # Ocultar el cue y las palabras al iniciar el test


func _on_Exit_pressed():
	get_tree().quit()

func _on_Start_pressed():
	$Label.hide()
	$Start.hide()
	$Exit.hide()
	$Logo.hide()
	
	$EndTest.show() # Mostrar los elementos correspondientes de la interfaz del test
	get_tree().call_group("Words", "show") 
	
	emit_signal("start") # Emitir señal


	
