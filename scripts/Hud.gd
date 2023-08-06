extends Container


# Called when the node enters the scene tree for the first time.
func _ready():
	var view_rect = get_viewport().get_visible_rect()
	set_size(view_rect)
