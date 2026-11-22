extends Node2D

# Fogos de artifício na tela de vitória
var cores = [Color(1, 0.25, 0.25), Color(1, 0.85, 0.2), Color(0.3, 0.7, 1), Color(0.35, 1, 0.45), Color(1, 0.4, 1), Color(1, 0.6, 0.15)]
var timer_fogos : Timer

func _ready() -> void:
	ScriptGlobal.tocar_narracao("res://Sons/narracao_e_tetra.mp3")
	timer_fogos = Timer.new()
	timer_fogos.one_shot = true
	timer_fogos.timeout.connect(soltar_fogo)
	add_child(timer_fogos)
	soltar_fogo()

func soltar_fogo() -> void:
	# área do céu: entre o título e a arquibancada
	var pos = Vector2(randf_range(130, 1040), randf_range(105, 185))
	var cor = cores[randi() % cores.size()]
	criar_explosao(pos, cor, 90, 230.0, 4.5)
	criar_explosao(pos, Color(1, 1, 0.9), 35, 110.0, 3.0)
	timer_fogos.start(randf_range(0.35, 1.0))

func criar_explosao(pos: Vector2, cor: Color, quantidade: int, velocidade: float, tamanho: float) -> void:
	var p = CPUParticles2D.new()
	p.position = pos
	p.one_shot = true
	p.explosiveness = 1.0
	p.amount = quantidade
	p.lifetime = 1.5
	p.direction = Vector2(0, -1)
	p.spread = 180.0
	p.gravity = Vector2(0, 90)
	p.initial_velocity_min = velocidade * 0.6
	p.initial_velocity_max = velocidade
	p.damping_min = 60.0
	p.damping_max = 110.0
	p.scale_amount_min = tamanho * 0.6
	p.scale_amount_max = tamanho
	var rampa = Gradient.new()
	rampa.offsets = PackedFloat32Array([0.0, 0.15, 1.0])
	rampa.colors = PackedColorArray([Color(1, 1, 1, 1), cor, Color(cor.r, cor.g, cor.b, 0)])
	p.color_ramp = rampa
	add_child(p)
	p.emitting = true
	p.finished.connect(p.queue_free)

func ir_para_inicio() -> void:
	get_tree().change_scene_to_file("res://cena_inicio.tscn")
