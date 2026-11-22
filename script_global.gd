extends Node

var qtd_vidas     = 0
var fase_atual    = 0
var pontuacao     = 0
var musica_ligada = true
var valor_dano    = 0
var personagem    = null
var portao        = null

func resetar_variaveis():
	qtd_vidas  = 10
	fase_atual = 1
	pontuacao  = 0
	valor_dano = 1

func _ready() -> void:	
	resetar_variaveis()

# Toca uma narração por cima de tudo. Como o ScriptGlobal não é destruído
# na troca de cena, o áudio continua tocando mesmo mudando de fase.
func tocar_narracao(caminho: String) -> void:
	if not ResourceLoader.exists(caminho):
		return
	var som = AudioStreamPlayer.new()
	som.stream = load(caminho)
	som.volume_db = 4.0
	add_child(som)
	som.play()
	som.finished.connect(som.queue_free)
