extends Area2D

export var speed = 400 #o quão rápido o jogador vai se mover
var screen_size # tamanho da janela do jogo


func _ready():
	hide()
	screen_size = get_viewport_rect().size

func _process(delta):
	move(delta)

func move(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x +=1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y +=1

	if velocity.length() > 0: #Se o cara está se movendo
		velocity = velocity.normalized() * speed #O valor é normalizado para que, se o jogador pressione dois botões ao mesmo tempo,a velocidade não será maior do que o esperado)
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x) #Clamp restringe um valor a um máximo.
	position.y = clamp(position.y, 0, screen_size.y) #Neste caso, ele é usado para que o jogador não ultrapasse o tamanho da janela.
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0 
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0


func update_animations():
	pass