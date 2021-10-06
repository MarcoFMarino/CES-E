extends LineEdit


signal name


func enable():
	text = "Nombre del participante"
	$Enter.disabled = false
	show()


func disable():
	$Enter.disabled = true
	hide()


func _on_UserName_text_entered(_name):
	emit_signal("name")
