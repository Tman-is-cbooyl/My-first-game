class_name SceneManagerControl
extends Node


## Static helper function to retrieve the "mainframe" node — essentially,
## the top-most parent node of the given node within the current active scene.
static func get_mainframe(node: Node) -> Node:
	var scene_root: Node = node.get_tree().current_scene
	
	## Traverse upward through the node hierarchy until you reach the scene root.
	while node.get_parent() != null and node != scene_root:
		node = node.get_parent()
	
	## Return the highest-level node found.
	return node
