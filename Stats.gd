extends Node

var time = 90

var current_location = "firstspawn"

var ghost_success = false
var ghost_encountered = false

var dad_success = false
var dad_encountered = false

var teeth_success = false
var teeth_encountered = false

var circus_success = false
var circus_encountered = false

func reset():
	current_location = "firstspawn"
	time = 90
	ghost_success = false
	ghost_encountered = false
	dad_success = false
	dad_encountered = false
	teeth_success = false
	teeth_encountered = false
	circus_success = false
	circus_encountered = false
