extends CharacterBody2D

@onready var move_state_machine: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/MoveStateMachine/playback")
@onready var tool_state_machine: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/ToolStateMachine/playback")


var direction: Vector2
var speed := 300
enum Tools  {HOE, AXE, WATER}
var can_move := true

var current_tool: Tools = Tools.AXE
const tool_connection = {
	Tools.HOE: 'hoe',
	Tools.AXE: 'axe',
	Tools.WATER: 'water',
}



func _physics_process(_delta: float) -> void:
	if can_move:
		get_input()
	velocity = direction * speed * int(can_move)
	move_and_slide()
	animation()


func get_input() -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	
	if Input.is_action_just_pressed("action"):
		tool_state_machine.travel(tool_connection[current_tool])
		$AnimationTree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		can_move = false
	
	if Input.is_action_just_pressed("tool_forward") or Input.is_action_just_pressed("tool_backward"):
		var tool_direction = Input.get_axis("tool_forward", "tool_backward") as int
		current_tool = posmod(current_tool + tool_direction, Tools.size()) as Tools


func animation() -> void:
	if direction:
		var target_vector: Vector2 = Vector2(round(direction.x), round(direction.y))
		$AnimationTree.set("parameters/MoveStateMachine/move/blend_position", target_vector)
		$AnimationTree.set("parameters/MoveStateMachine/idle/blend_position", target_vector)
		for state in tool_connection.values():
			$AnimationTree.set("parameters/ToolStateMachine/"+ state +"/blend_position", target_vector)
		move_state_machine.travel("move")
	else:
		move_state_machine.travel("idle")
	

# 只是非循环动画才会触发
func _on_animation_tree_animation_finished(_anim_name: StringName) -> void:
	can_move = true
