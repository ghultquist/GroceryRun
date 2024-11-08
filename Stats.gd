extends Node

var time = 90

var current_location = "circusspawn"


var ghost_active = true
var dadcall_active = true
var teeth_active = true
var circus_active = true

var ghost_success = true
var ghost_encountered = false

var dad_success = true
var dad_encountered = false

var teeth_success = true
var teeth_encountered = false

var circus_success = true
var circus_encountered = true

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
