extends Node2D

func _ready() -> void:
	ScriptGlobal.portao = self

func ir_para_final(body: Node2D) -> void:
	if (body.name=="Personagem"):
		# Fase 1 -> Fase 2 -> tela de vitória
		if (get_tree().current_scene.scene_file_path == "res://cena_fase.tscn"):
			ScriptGlobal.fase_atual = 2
			get_tree().call_deferred("change_scene_to_file", "res://cena_fase2.tscn")
		else:
			get_tree().call_deferred("change_scene_to_file", "res://cena_final.tscn")
