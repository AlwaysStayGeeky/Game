extends Node2D

@export var world_speed = 300

@onready var moving_enviorment = $"/root/World/envoirment/moving"

var platform = preload("res://Scenes/platform.tscn")
var rng = RandomNumberGenerator.new()
var last_platform_position = Vector2.ZERO
var next_spawn_time = 0

#Called when the node enterers the scene tree for first time
func _ready():
	rng.randomize()
	
#Called every frame. 'delta' is elapsed time since previous frame.
func _process(_delta):
	# Spawn a new platform
	if Time.get_ticks_msec() > next_spawn_time: 
		var new_platform = platform.instantiate()

# Set position of new platform
		if last_platform_position == Vector2.ZERO:
			new_platform.position = Vector2(400, 0)
		else:
			var x = last_platform_position.x + rng.randi_range(450, 550)
			var y = clamp(last_platform_position.y + rng.randi_range(-150, 150), 200, 1000)
			new_platform.position = Vector2 (x, y)
			
			#Add platform to moving envoirment
			moving_enviorment.add_child(new_platform)
			
			#Update last position and increase the next spawn 
			last_platform_position = new_platform.position
			next_spawn_time += world_speed 
			


func _physics_process(delta):
	# Move the platforms left
	moving_enviorment.position.x -= world_speed * delta
