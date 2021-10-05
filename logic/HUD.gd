extends CanvasLayer

signal start # Señal utilizada para indicar que se presionó el botón de inicio (Start)
signal end # Señal para indicar que se decidió terminar el test antes de completar todos los eventos, (EndTest)

func _ready():
	$EndTest.hide()
	reset_words() # Ocultar el cue y las palabras al iniciar el test

func _on_Exit_pressed():
	get_tree().quit() # Cerrar el CES-E

func _on_Start_pressed():
	$Message.hide() # Ocultar elementos correspondientes al menú principal
	$Start.hide()
	$Exit.hide()
	$Logo.hide()
	
	$EndTest.show() # Mostrar los elementos correspondientes de la interfaz del test
	show_words()
	emit_signal("start") # Emitir señal de inicio

func update_cue(cue): # Actualizar el texto del CUE con el correspondiente al evento
	$Cue.text = String(cue)
	
func update_words(words):  # Actulalizar el texto de Word1, Word2 y Word3 con los correspondientes al evento
	$Word1.text = String(words[0])
	$Word2.text = String(words[1])
	$Word3.text = String(words[2])
	
func show_message(message): # Permite mostrar al usuario mensajes en el centro de la pantalla, ej:"Test finalizado"
	$Message.text = message
	$Message.show()

func _on_EndTest_pressed(): # Al presionar el botón EndTest envía la señal "end"
	emit_signal("end")
	
func show_words(): # Hace visibles los elementos pertencientes al grupo "Words": Cue, Word1, Word2, Word3
	get_tree().call_group("Words", "show")

func reset_words(): # Establecer el texto de Cue, Word1, Word2 y Word3 como texto vacío
	$Cue.text = ""
	$Word1.text = ""
	$Word2.text = ""
	$Word3.text = ""
