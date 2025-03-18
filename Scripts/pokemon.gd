extends Node2D

@onready var sprite_2d = $Sprite2D

#Sprites
@export var back_sprite: CompressedTexture2D
@export var front_sprite: CompressedTexture2D
@export var shiny_back_sprite: CompressedTexture2D
@export var shiny_front_sprite: CompressedTexture2D
@export var bag_sprite: CompressedTexture2D
@export var shiny_bag_sprite: CompressedTexture2D

#Levels
@export var level: int
@export var evolution_level: int
@export var evolution: Node2D

#Moves
@export var move_slot_1: String
@export var move_slot_2: String
@export var move_slot_3: String
@export var move_slot_4: String

#Base Stats
@export var hp_base: int
@export var attack_base: int
@export var defense_base: int
@export var special_attack_base: int
@export var special_defense_base: int
@export var speed_base: int

#Individual Values
@export var hp_iv: int
@export var attack_iv: int
@export var defense_iv: int
@export var special_attack_iv: int
@export var special_defense_iv: int
@export var speed_iv: int

#Effort Values
@export var hp_ev: int
@export var attack_ev: int
@export var defense_ev: int
@export var special_attack_ev: int
@export var special_defense_ev: int
@export var speed_ev: int

#Actual Stat Values (calculated using base/iv/ev)
var hp: int
var attack: int
var defense: int
var special_attack: int
var special_defense: int
var speed: int

#Stat Values to be Used in Battle
var current_hp: int
var current_attack: int
var current_defense: int
var current_special_attack: int
var current_special_defense: int
var current_speed: int

func _ready():
	set_sprite()

func set_sprite():
	#if is_in_group("party"):
		#pass
	sprite_2d.texture = back_sprite
