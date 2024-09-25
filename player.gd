extends Node2D

@export var damage_indicator_duration: float = 1
@export var damage_indicator_speed: float = 50
@onready var player: Sprite2D = $Sprite2D

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("damageIndicator"):
		var damage: int = randi_range(5, 15)
		var is_critical: bool = randi() % 2 == 0
		show_damage(damage, is_critical)

func show_damage(amount: int, is_critical: bool) -> void:
	if is_critical:
		amount *= 2

	var damage_label: Label = Label.new()
	
	if is_critical:
		damage_label.add_theme_color_override("font_color", Color(1,1,0))
	else:
		damage_label.add_theme_color_override("font_color", Color(1,0,0))

	damage_label.text = str(amount)

	damage_label.position = player.position + Vector2(0, -50) + Vector2(randf_range(-20, 20), 0)
	add_child(damage_label)

	var tween: Tween = create_tween()
	tween.tween_property(damage_label, "position:y", damage_label.position.y - 50, damage_indicator_duration)
	tween.tween_property(damage_label, "modulate:a", 0, damage_indicator_duration)
	tween.connect("finished", Callable(damage_label, "queue_free"))
