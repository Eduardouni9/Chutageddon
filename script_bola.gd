extends CharacterBody2D

var direcao    = 1 #  1 => Direita, -1 => Esquerda
var velocidade = 350
var tempo_fogo = 0.0

func _process(delta: float) -> void:
	velocity.x = velocidade * direcao
	velocity.y = 0
	
	# Bola flamejante: anima as chamas e vira o rastro de fogo para trás
	tempo_fogo += delta
	$Sprite2D.frame = int(tempo_fogo * 14) % $Sprite2D.hframes
	$Sprite2D.scale.x = abs($Sprite2D.scale.x) * direcao
	
	if ($RayCast2D.is_colliding()):
		var alvo = $RayCast2D.get_collider()
		if (alvo.name=="Chefao"):
			alvo.levar_dano()
		else:
			alvo.queue_free()
		get_parent().queue_free()
	
	move_and_slide()
	
