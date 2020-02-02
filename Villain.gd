extends Node2D

export var damage = 100

signal do_damage(damage)

func do_damage():
	emit_signal("do_damage", damage)

func _on_DamageTimer_timeout():
	do_damage()

func pause(isPaused):
	$DamageTimer.set_paused(isPaused)

func spawn():
	$DamageTimer.start()
