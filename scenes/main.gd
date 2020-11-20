extends Node

onready var player = $player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func restart():
	var tree = get_tree()
	if tree != null:
		tree.reload_current_scene()

func _on_takeoff_platform_body_entered(body):
	if body.get_name() == 'player':
		print("The spaceship is in the take-off area. Use arrows to control it.")


func _on_landing_platform_body_entered(body):
	if body.get_name() == 'player':
		var vel = Vector2(body.linear_velocity.x, body.linear_velocity.y)
		var g = vel.length() / 98.0
		if g < 0.5:
			print("The spaceship has landed in the landing area with " + String(g) + " G. Congratulations. ")
		else:
			print("The spaceship has crashed with " + String(g) + " G. Try again.")
			restart()

func _on_safeArea_body_exited(body):
	if body.get_name() == 'player':
		print("The spaceship is outside the safe area")
		restart()
