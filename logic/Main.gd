extends Node

var file = File.new()

func _ready():
	$Point.hide()
	file.open("res://files/items2.csv", File.READ) # La codificación del .csv tiene que ser UTF-8

func _on_HUD_start(): # Recibe la señal start del HUD
	$Point.show()
	$Timer.start()
	
func _on_Timer_timeout():
	pass
