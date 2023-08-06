extends RigidBody2D

@onready var fire_line = $Line2D
@onready var ball = preload("res://projectile.tscn")

@export var fire_line_length = 75
@export var angle_label: Label
@export var power_label: Label
@export var fast_mode = 5

var angle: int = 0
var power: int = 500
var firing: bool = false
var fire_dir = Vector2(0, -1).rotated(deg_to_rad(angle))


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if event.is_action_pressed("Fire", false, true):
		fire_projectile()


func _physics_process(delta):
	var inc_angle = Input.is_action_pressed("Angle Inc")
	var dec_angle = Input.is_action_pressed("Angle Dec")
	var inc_power = Input.is_action_pressed("Power Inc")
	var dec_power = Input.is_action_pressed("Power Dec")
	var aim_mod = Input.is_action_pressed("Aim_Mod")
	
	if inc_angle and !aim_mod:
		angle += 1
		recalc_fire_dir()
	if inc_angle and aim_mod:
		angle += fast_mode
		recalc_fire_dir()

	if dec_angle and !aim_mod:
		angle -= 1
		recalc_fire_dir()
	if dec_angle and aim_mod:
		angle -= fast_mode
		recalc_fire_dir()
	
	if inc_power and !aim_mod:
		power += 1
	if inc_power and aim_mod:
		power += fast_mode
	
	if dec_power and !aim_mod:
		power -= 1
	if dec_power and aim_mod:
		power -= fast_mode
	
	angle_label.set_text("%d" % angle)
	power_label.set_text("%d" % power)


func recalc_fire_dir():
	var rot = deg_to_rad(angle)
	fire_dir = Vector2(0, -1).rotated(rot)
	fire_line.points[1] = fire_dir * fire_line_length


func fire_projectile():
	var projectile = ball.instantiate() as RigidBody2D
	var spawn_pos: Vector2 = global_position + fire_line.points[1]
	projectile.position = spawn_pos
	get_tree().root.add_child(projectile);
	projectile.apply_impulse(fire_dir * (power * 2))
