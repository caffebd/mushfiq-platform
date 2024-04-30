extends KinematicBody2D

export var speed = 250

var attacking = false

export var jump_speed = -500
var gravity = 900


var used_portal = false

var direction := Vector2.ZERO

var pushed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignal.connect("power_up" , self, "_power_up")
	GlobalSignal.connect("push_up" , self, "_push_up")
	GlobalSignal.connect("use_portal", self, "_use_portal")
	
func _push_up():
	pushed = true
	
	
func _input(event):
	
	direction.x = 0
	
	if Input.is_action_pressed("right"):
		direction.x += speed
		$AttackNode.scale.x = 1
		$PlayerAnim.flip_h = false
		if not attacking:
			$PlayerAnim.play("walk")
			
			
	elif Input.is_action_pressed("left"):
		direction.x -= speed
		$AttackNode.scale.x = -1
		$PlayerAnim.flip_h = true
		if not attacking:
			$PlayerAnim.play("walk")
	
	else:
		if not attacking:
			$PlayerAnim.play("idle")
		
	if GlobalVars.can_fly == true:
		direction.y = 0
		
		if Input.is_action_pressed("jump"):
			direction.y -= speed
			
		if Input.is_action_pressed("down"):
			direction.y += speed
			
	if Input.is_action_just_pressed("send_ufo"):
		GlobalSignal.emit_signal("ufo_attack")
	#else:
		#




func _process(delta):
	
	direction.y += gravity * delta
	
	var is_geounded = $RayCast2D.is_colliding()
	
	
	if Input.is_action_just_pressed("jump"):
		if is_geounded and not GlobalVars.can_fly:
			direction.y = jump_speed	
	
	if Input.is_action_just_pressed("attack"):
		attacking = true
		$PlayerAnim.set_frame(0)
		$PlayerAnim.play("attack")
			
		$AttackNode/AttackArea/AttackCollisionShape2D.disabled = false
		
		
	if pushed:
		direction.y = jump_speed/2
		pushed = false
	
	direction = move_and_slide(direction,  Vector2.UP)
 
func _power_up():
	gravity = 0
	GlobalVars.can_fly = true

func _use_portal(new_position):
	direction = Vector2.ZERO
	visible = false
	call_deferred("_collision_off")
	var tween = create_tween()
	tween.tween_property(self, "global_position", new_position, 1.0)
	yield (tween, "finished")
	call_deferred("_collision_on")
	visible = true


func _on_PlayerAnim_animation_finished():
	if $PlayerAnim.animation == "attack":
		attacking = false
		$AttackNode/AttackArea/AttackCollisionShape2D.disabled = true

func _collision_on():
	$PlayerCollision.disabled = false

func _collision_off():
	$AttackNode/AttackArea/AttackCollisionShape2D.disabled= true
	$PlayerCollision.disabled = true
