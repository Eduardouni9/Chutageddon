extends CharacterBody2D 

var direcao    = 1
var gravidade  = 20
@export var velocidade = 300
var esta_na_tela = false
@export var vidas = 3
var invulneravel = false

func _process(delta: float) -> void:
	velocity.y += gravidade
	velocity.x  = 0
	if (esta_na_tela and is_on_floor() and not $Timer.is_stopped()):
		$AnimationPlayer.play("andando")
		velocity.x = velocidade * direcao

	var posx = $VisibleOnScreenNotifier2D.position.x
	if (direcao<0):
		$Sprite2D.flip_h = true
		$VisibleOnScreenNotifier2D.position.x = abs(posx) * -1
	else:
		$Sprite2D.flip_h = false
		$VisibleOnScreenNotifier2D.position.x = abs(posx)
	
	move_and_slide()

func parado() -> void:
	$Timer.stop()
	$AnimationPlayer.play("parado")

func atacar() -> void:
	$AnimationPlayer.play("atacando")
	
func voltar_andar():
	$Timer.start()
	$AnimationPlayer.play("andando")

func mudar_direcao() -> void:
	esta_na_tela = false
	direcao *= -1
	
func perseguir() -> void:
	esta_na_tela = true
	
func causar_dano_personagem():
	var personagem = ScriptGlobal.personagem
	
	if (personagem.is_on_floor() and esta_na_tela):
		ScriptGlobal.qtd_vidas -= ScriptGlobal.valor_dano


# O chefão aguenta 3 golpes (bola ou carrinho) antes de ser derrotado
func levar_dano():
	if (invulneravel):
		return
	vidas -= 1
	var som = AudioStreamPlayer.new()
	som.stream = preload("res://Sons/Dano_chefão.mp3")
	get_tree().root.add_child(som)
	som.play()
	som.finished.connect(som.queue_free)
	if (vidas <= 0):
		ScriptGlobal.portao.get_node("AnimationPlayer").play("abrir")
		if (get_tree().current_scene.scene_file_path == "res://cena_fase.tscn"):
			ScriptGlobal.tocar_narracao("res://Sons/narracao_que_fase.mp3")
		queue_free()
		return
	invulneravel = true
	var piscar = create_tween()
	for i in range(3):
		piscar.tween_property($Sprite2D, "modulate", Color(1, 0.3, 0.3), 0.1)
		piscar.tween_property($Sprite2D, "modulate", Color(1, 1, 1), 0.1)
	await piscar.finished
	invulneravel = false
