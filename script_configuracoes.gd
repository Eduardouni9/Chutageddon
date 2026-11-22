extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# mostra na barra o volume que já está valendo
	var bus = AudioServer.get_bus_index("Master")
	var porcentagem = 0.0
	if not AudioServer.is_bus_mute(bus):
		porcentagem = round(db_to_linear(AudioServer.get_bus_volume_db(bus)) * 100.0)
	$SliderVolume.set_value_no_signal(porcentagem)
	$LabelPorcentagem.text = str(int(porcentagem)) + "%"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func voltar() -> void:
	get_tree().change_scene_to_file("res://cena_inicio.tscn")
	
	
# Barra de volume: 0% silencia, 100% é o volume original
func _mudar_volume(valor: float) -> void:
	var bus = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(bus, valor <= 0)
	if (valor > 0):
		AudioServer.set_bus_volume_db(bus, linear_to_db(valor / 100.0))
	$LabelPorcentagem.text = str(int(valor)) + "%"
