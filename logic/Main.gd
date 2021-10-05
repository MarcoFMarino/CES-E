extends Node

var file = File.new()
var elements = [] # Variable utilizada para cargar todos los eventos desde el .csv 
var target # Registra el target del evento actual 
var words # Palabras a mostrar durante el evento
var cue # Palabra clave
var key # Variable para habilitar o deshabilitar la utilización del teclado para responder al test
var event = 0 
var results = [["EVENT", "CUE", "G", "H", "J", "CHOICE", "TARGET", "ACC"]]

func _ready():
	$Point.hide()

func _on_HUD_start(): # Recibe la señal start del HUD
	randomize()
	file.open("res://files/items.csv", File.READ) # La codificación del .csv tiene que ser UTF-8
	var line = file.get_csv_line() # Leer encabezado el .csv
	line = file.get_csv_line() # Lee el primer evento
	while line.size() != 1: # Cargar lineas del .csv hasta encontrar una vacía []
		elements.append(line)
		line = file.get_csv_line()
	file.close()
	_level_update() # Carga los datos del primer evento del test

func _on_CueTimer_timeout():
	$HUD.update_cue(cue) # Mostrar el CUE correspondiente al evento actual
	$Point.hide()
	$WordsTimer.start() # Incia el timer para mostrar las palabras

func _on_WordsTimer_timeout():
	$HUD.update_words(words) # Mostrar palabras correspondientes al evento actual
	$LevelTimer.start() # Inicia el temporizador del evento
	key = true # Al mostrar las opciones se habilita la respuesta del usuario

func _on_LevelTimer_timeout():
	_results("TimeOut")
	_level_update() # Se pasa automáticamente al siguiente evento si no se responde dentro de 15 seg

func _on_PointTimer_timeout():
	$Point.show() # Luego de 0.5seg de empezar el evento se muestra el Point
	$CueTimer.start() # Iniciar el temporizador para mostrar el CUE
	
func _end_test(): # Almacenar los resultados en un .csv
	file.open("res://files/results.csv", File.WRITE)
	for i in results:
		file.store_csv_line(i)
	file.close()
	get_tree().quit()

func _level_update():
	key = false # Deshabilitar la respuesta del usuario
	$HUD.reset_words() # Oculta las palabras 
	randomize()
	if not elements.empty(): # Compureba que todavía queden eventos para hacer
		event += 1 # Aumenta el número del evento
		$PointTimer.start() # Inicia el timer del Point
		var level = randi() % elements.size() # Selecciona un evento aleatorio 
		
		# Asignar el CUE, target y las palabras correspondientes al evento
		cue = elements[level][1]
		target = elements[level][2]
		words = [elements[level][2], elements[level][3], elements[level][4]]
		
		words.shuffle() # Mezcla el orden de las palabras, de lo contrario el target siempre estaría en la tecla "g"
		
		elements.remove(level) # Eliminar el evento actual para que no pueda volver a ser seleccionado
		
	else: # Si ya no quedan eventos finaliza el test
		_end_test() 


func _results(answer):
	var acc = 0
	if answer == target: # Compureba que la respuesta seleccionada sea correcta
		acc = 1
	results.append([event, cue, words[0], words[1], words[2], answer, target, acc]) # Agrega el resultado correspondiente al evento que finalizó

func _process(delta):
	if key:
		if Input.is_action_just_pressed("word_1"):
			_results(words[0]) # Indica que se presionó la tecla "g"
			_level_update() # Avanza al siguiente evento
		elif Input.is_action_just_pressed("word_2"):
			_results(words[1]) # Indica que se presionó la tecla "h"
			_level_update() # Avanza al siguiente evento
		elif Input.is_action_just_pressed("word_3"):
			_results(words[2]) # Indica que se presionó la tecla "j"
			_level_update() # Avanza al siguiente evento


