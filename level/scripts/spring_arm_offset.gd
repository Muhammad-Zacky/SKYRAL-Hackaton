extends Node3D
class_name SpringArmCharacter

const MOUSE_SENSIBILITY: float = 0.005

@export_category("Objects")
@export var _spring_arm: SpringArm3D = null

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(_event) -> void:
	if (_event is InputEventMouseMotion) and is_multiplayer_authority():
		rotate_y(-_event.relative.x * MOUSE_SENSIBILITY)
		_spring_arm.rotate_x(-_event.relative.y * MOUSE_SENSIBILITY)
		_spring_arm.rotation.x = clamp(_spring_arm.rotation.x, -PI/4, PI/24)
