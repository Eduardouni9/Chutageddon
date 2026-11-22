extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func reiniciar() -> void:
	# recomeça na fase em que o jogador perdeu
	var fase = ScriptGlobal.fase_atual
	ScriptGlobal.resetar_variaveis()
	ScriptGlobal.fase_atual = fase
	if (fase == 2):
		get_tree().change_scene_to_file("res://cena_fase2.tscn")
	else:
		get_tree().change_scene_to_file("res://cena_fase.tscn")

func sair() -> void:
	ScriptGlobal.resetar_variaveis()
	get_tree().change_scene_to_file("res://cena_inicio.tscn")
