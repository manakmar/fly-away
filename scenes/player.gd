extends RigidBody2D

var LIMIT = 0.01
var thrust = Vector2(0, -200)
var left = Vector2(-150, 0)
var right = Vector2(150, 0)
var requested_force = Vector2()
var pending_reset = false
var engine_running = false

signal engine_state_changed(running)

onready var initial_position = position;

# Called when the node enters the scene tree for the first time.
func _ready():
    pass
	
func reset():
	pending_reset = true
	
# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_pressed("ui_up"):
		requested_force = thrust
	else:
		requested_force = Vector2()
		
	if Input.is_action_pressed("ui_right"):
		requested_force += right
		
	if Input.is_action_pressed("ui_left"):
		requested_force += left
		
	var running = requested_force.length_squared() >= LIMIT
	if running != engine_running:
		engine_running = running
		emit_signal("engine_state_changed", running)

# warning-ignore:unused_argument
func _integrate_forces(state):
	if pending_reset:
		pending_reset = false
		position = initial_position
		applied_force = Vector2()
	else:
		applied_force = requested_force
