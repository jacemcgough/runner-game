extends Node

@export var mobs: Array[PackedScene] = []

var score

func game_over():
    $ParallaxBackground2.speed = 0
    $MobTimer.stop()
    $HUD.show_game_over()

func new_game():
    get_tree().call_group("mobs", "queue_free")
    $Player.start($StartPosition.position)
    $StartTimer.start()
    $ParallaxBackground2.speed = 1300

    score = 0
    $HUD.update_score(score)
    $HUD.show_message()

func update_score():
    $DeathSound.play()
    score += 1
    $HUD.update_score(score)

func _on_start_timer_timeout():
    $MobTimer.start()

func _on_mob_timer_timeout():
    var mob = mobs.pick_random().instantiate()

    var mob_spawn_location
    var velocity
    if mob.name == 'Flyer':
        mob_spawn_location = $FlyerSpawner
        velocity = 500
    else:
        mob_spawn_location = $WalkerSpawner
        velocity = 300

    mob.connect('die', update_score)

    mob.position = mob_spawn_location.position
    mob.linear_velocity = Vector2(-velocity, 0)

    add_child(mob)
