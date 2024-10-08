extends Area2D

@export var destination : String
@export var location : Vector2
@export_multiline var description : String

@onready var player = get_parent().get_node("Player")
@onready var door = $AnimationPlayer
@onready var label = $Description

var in_range : bool = false
	
func _input(event):
	if in_range and event.is_action_pressed("Interact"):
		door.play("default")
		Manager.save_game(player, player.inventory)
		await door.animation_finished
		get_tree().change_scene_to_file(destination)
		if location:
			Global.player_position = location


func _on_body_entered(body):
	if body.name == "Player":
		label.text = description
		label.visible = true
		in_range = true
	

func _on_body_exited(body):
	if body.name == "Player":
		label.visible = false
		in_range = false
	


