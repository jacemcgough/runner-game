extends CharacterBody2D
signal hit

const SPEED = 800
const GRAVITY = 20

var is_attacking = false

func _ready():
    hide()
    pass

func _process(_delta):
    if is_on_floor() && !is_attacking:
        $AnimationPlayer.play('run')

    if Input.is_action_pressed("jump"):
        jump()

    if Input.is_action_pressed("attack"):
        attack()

    if velocity.y != 0:
        if !is_attacking:
            $AnimationPlayer.play("jump")

    velocity.y += GRAVITY

    move_and_slide()
    for i in get_slide_collision_count():
        var collision = get_slide_collision(i)
        if collision.get_collider().is_in_group('mobs'):
            take_damage()

func start(pos):
    global_position = Vector2(pos)
    velocity = Vector2.ZERO
    show()
    $CollisionShape2D.disabled = false

func jump():
    if is_on_floor():
        velocity.y = -SPEED

func attack():
    if Input.is_action_just_pressed('attack'):
        if !is_attacking:
            is_attacking = true
            $AnimationPlayer.play("attack")

func take_damage():
    hide()
    hit.emit()
    $CollisionShape2D.set_deferred("disabled", true)

func _on_animation_player_animation_finished(anim_name):
    if anim_name == 'attack':
        is_attacking = false


func _on_attack_body_entered(body):
    if body.is_in_group('mobs') && body.has_method('take_damage'):
        body.take_damage()
