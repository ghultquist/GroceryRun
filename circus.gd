extends Node2D

var all_tentacles = []
var successes = []
var poem = ["COME ONE, COME ALL!", "COME BIG, COME SMALL!", "YOU HEAR MY CALL!", "I SEE YOU CRAWL!", "We’re joined here tonight by X,", "One of the world’s greatest rejects!", "Archaic face with a fractured image,", "Look upon their pathetic visage!", "Did the unkind world starve you to bone,", "And leave you alone, or is fault your own?", "It’s the tragic hand you have been dealt,", "with little wealth, and poor mental health.", "By now you must realize your reclusive effect.", "Loved ones abundant left to rot in neglect.", "Postponements that you’ve been known to prolong.", "By now you must realize you do not belong."]

const worldScene = "res://world.tscn"

var fail1 = false
var fail2 = false

var timelost = 15

func _ready():
	$Player.can_move =false
	Hud.get_child(0).hide_guide()
	Hud.get_child(0).time_visible(false)
	$ghoulia.hide()
	$teeth.hide()
	$Timer.wait_time = 3
	all_tentacles = [$tentacles, $tentacles2, $tentacles3, $tentacles4, $tentacles5]
	for t in all_tentacles:
		t.get_child(0).play("writhe")
	$ringleader/AnimationPlayer.play("ungulate")
	
	lines()

func ending():
	Stats.time -= timelost
	if Stats.time > 0:
		$devour/AnimationPlayer.play_backwards("attack")
		yield($devour/AnimationPlayer, "animation_finished")
		$Player.can_move = true
		$intro1.bbcode_text = "Well you're no fun."
		$intro2.bbcode_text = "How can I feed on your shame and loneliness if you're suddenly being accountable?"
		$intro3.bbcode_text = "I thought you would be the perfect victim, but now look at what you've done!"
		$intro4.bbcode_text = "Withered me down to nothing! I'm famished!"
		$textanimate.play("line1")
		yield($textanimate, "animation_finished")
		$textanimate.play("line2")
		yield($textanimate, "animation_finished")
		$textanimate.play("line3")
		yield($textanimate, "animation_finished")
		$textanimate.play("line4")
		yield($textanimate, "animation_finished")
		$Timer.wait_time = 2
		$Timer.start()
		yield($Timer, "timeout")
		$textanimate.play_backwards("line1")
		$textanimate.play_backwards("line2")
		$textanimate.play_backwards("line3")
		$textanimate.play_backwards("line4")
		$Timer.wait_time = 2
		$Timer.start()
		yield($Timer, "timeout")
		
		$intro1.bbcode_text = "Oh, so you're like doing a Pennywise thing?"
		$intro2.bbcode_text = "..."
		$intro3.bbcode_text = "I am NOT doing a 'Pennywise thing'. "
		$intro4.bbcode_text = "Do you not see how I'm a HUGE flesh amalgamation? With tentacles and motifs that mirror your own???"
		$textanimate.play("line1")
		yield($textanimate, "animation_finished")
		$textanimate.play("line2")
		yield($textanimate, "animation_finished")
		$textanimate.play("line3")
		yield($textanimate, "animation_finished")
		$textanimate.play("line4")
		yield($textanimate, "animation_finished")
		$Timer.wait_time = 2
		$Timer.start()
		yield($Timer, "timeout")
		$textanimate.play_backwards("line1")
		$textanimate.play_backwards("line2")
		$textanimate.play_backwards("line3")
		$textanimate.play_backwards("line4")
		$Timer.wait_time = 2
		$Timer.start()
		yield($Timer, "timeout")
		
		$intro1.bbcode_text = "Listen man, I get it, it's hard to be creative, but you even have the whole circus thing going on."
		$intro2.bbcode_text = "Just leave! I'm done with you!"
		$intro3.bbcode_text = "I'm leaving, but not because you told me to."
		$intro4.bbcode_text = "I have to go to the grocery store."
		$textanimate.play("line1")
		yield($textanimate, "animation_finished")
		$textanimate.play("line2")
		yield($textanimate, "animation_finished")
		$textanimate.play("line3")
		yield($textanimate, "animation_finished")
		$textanimate.play("line4")
		yield($textanimate, "animation_finished")
		$Timer.wait_time = 2
		$Timer.start()
		yield($Timer, "timeout")
		$textanimate.play_backwards("line1")
		$textanimate.play_backwards("line2")
		$textanimate.play_backwards("line3")
		$textanimate.play_backwards("line4")
		$Timer.wait_time = 2
		$Timer.start()
		yield($Timer, "timeout")
		get_tree().change_scene(worldScene)
	
	else:
		$devour/AnimationPlayer.play_backwards("attack")
		yield($devour/AnimationPlayer, "animation_finished")
		$intro1.bbcode_text = "Oh! And just like that you're out of time!"
		$intro2.bbcode_text = "You really should be more kind to yourself."
		$intro3.bbcode_text = "I am sorry for some of the things I said..."
		$intro4.bbcode_text = "But how else would I feed on your self loathing and regret?"
		$textanimate.play("line1")
		yield($textanimate, "animation_finished")
		$textanimate.play("line2")
		yield($textanimate, "animation_finished")
		$textanimate.play("line3")
		yield($textanimate, "animation_finished")
		$textanimate.play("line4")
		yield($textanimate, "animation_finished")
		$Timer.wait_time = 2
		$Timer.start()
		yield($Timer, "timeout")
		$textanimate.play_backwards("line1")
		$textanimate.play_backwards("line2")
		$textanimate.play_backwards("line3")
		$textanimate.play_backwards("line4")
		$Timer.wait_time = 2
		$Timer.start()
		yield($Timer, "timeout")
		get_tree().change_scene(worldScene)

func grabbed():
	$devour/AnimationPlayer.play("attack")
	yield($devour/AnimationPlayer, "animation_finished")
	$devour/AnimationPlayer.play("hold")
	$Player/AnimationPlayer.play("grabbed")
	$Timer.start()
	yield($Timer, "timeout")
	
	$intro1.bbcode_text = "Now, welcome our lovely guests on the stage"
	$textanimate.play("line1")
	yield($textanimate, "animation_finished")
	$Timer.wait_time = 1
	$Timer.start()
	yield($Timer, "timeout")
	$textanimate.play_backwards("line1")
	yield($textanimate, "animation_finished")
	
	$intro1.bbcode_text = "First up! We have Ghoulia!"
	$intro2.bbcode_text = "I bet you didn't even know her name!"
	$textanimate.play("line1")
	yield($textanimate, "animation_finished")
	$ghoulia.show()
	$textanimate.play("line2")
	yield($textanimate, "animation_finished")
	$Timer.wait_time = 2
	$Timer.start()
	yield($Timer, "timeout")
	
	if Stats.ghost_success:
		
		$intro3.bbcode_text = "I actually did. I helped her find her cat earlier."
		$intro4.bbcode_text = "Not that it should matter to you. Why am I here anyways?"
		$textanimate.play("line3")
		yield($textanimate, "animation_finished")
		$textanimate.play("line4")
		yield($textanimate, "animation_finished")
		$Timer.wait_time = 2
		$Timer.start()
		yield($Timer, "timeout")
		$textanimate.play_backwards("line1")
		$textanimate.play_backwards("line2")
		$textanimate.play_backwards("line3")
		$textanimate.play_backwards("line4")
		yield($textanimate, "animation_finished")
		$ghoulia.hide()
		$intro1.bbcode_text = "Well, that's an unexpected twist! "
		$intro2.bbcode_text = "Maybe you have changed..."
		$textanimate.play("line1")
		yield($textanimate, "animation_finished")
		$textanimate.play("line2")
		yield($textanimate, "animation_finished")
		$Timer.wait_time = 1
		$Timer.start()
		yield($Timer, "timeout")
		$textanimate.play_backwards("line1")
		$textanimate.play_backwards("line2")
	else:
		$intro3.bbcode_text = "I didn't... I know I should've helped, but I was in a hurry "
		$intro4.bbcode_text = "and I'm not really into talking to strangers..."
		$textanimate.play("line3")
		yield($textanimate, "animation_finished")
		$textanimate.play("line4")
		yield($textanimate, "animation_finished")
		$Timer.wait_time = 2
		$Timer.start()
		yield($Timer, "timeout")
		$textanimate.play_backwards("line1")
		$textanimate.play_backwards("line2")
		$textanimate.play_backwards("line3")
		$textanimate.play_backwards("line4")
		yield($textanimate, "animation_finished")
		$ghoulia.hide()
		$intro1.bbcode_text = "Everyone's a stranger, until you meet them!"
		$intro2.bbcode_text = "You know not everyone is as nice as me, so maybe it was a good idea to ignore the girl with the lost cat."
		$textanimate.play("line1")
		yield($textanimate, "animation_finished")
		$textanimate.play("line2")
		yield($textanimate, "animation_finished")
		$Timer.wait_time = 1
		$Timer.start()
		yield($Timer, "timeout")
		$textanimate.play_backwards("line1")
		$textanimate.play_backwards("line2")
		timelost+= 30
		
		
	
	$intro1.bbcode_text = "Unfortunately we weren't able to get your dad out here tonight..."
	$intro2.bbcode_text = "But when's the last time you visited HIM, or even TALKED to him."
	$textanimate.play("line1")
	yield($textanimate, "animation_finished")
	$textanimate.play("line2")
	yield($textanimate, "animation_finished")
	$Timer.wait_time = 2
	$Timer.start()
	yield($Timer, "timeout")
	
	if Stats.dad_success:
		
		$intro3.bbcode_text = "Today. He called me earlier."
		$intro4.bbcode_text = "Did you pull me into your tent just to insult and interrogate me?"
		$textanimate.play("line3")
		yield($textanimate, "animation_finished")
		$textanimate.play("line4")
		yield($textanimate, "animation_finished")
		$Timer.wait_time = 2
		$Timer.start()
		yield($Timer, "timeout")
		$textanimate.play_backwards("line1")
		$textanimate.play_backwards("line2")
		$textanimate.play_backwards("line3")
		$textanimate.play_backwards("line4")
		yield($textanimate, "animation_finished")
		$intro1.bbcode_text = "Oh, erm, and you actually answered?"
		$intro2.bbcode_text = "And you didn't lie a bunch? And feel extremely guilty about it?"
		$textanimate.play("line1")
		yield($textanimate, "animation_finished")
		$textanimate.play("line2")
		yield($textanimate, "animation_finished")
		$Timer.wait_time = 2
		$Timer.start()
		yield($Timer, "timeout")
		$textanimate.play_backwards("line1")
		$textanimate.play_backwards("line2")
	else:
		$intro3.bbcode_text = "It's been a while, okay. But that's not a reason to keep me captive."
		$intro4.bbcode_text = "I care a lot about him and want to see him again, so just please let me go."
		$textanimate.play("line3")
		yield($textanimate, "animation_finished")
		$textanimate.play("line4")
		yield($textanimate, "animation_finished")
		$Timer.wait_time = 2
		$Timer.start()
		yield($Timer, "timeout")
		$textanimate.play_backwards("line1")
		$textanimate.play_backwards("line2")
		$textanimate.play_backwards("line3")
		$textanimate.play_backwards("line4")
		yield($textanimate, "animation_finished")
		
		$intro1.bbcode_text = "Interesting that you care so much about your dad,"
		$intro2.bbcode_text = "when you won't even talk to him."
		$textanimate.play("line1")
		yield($textanimate, "animation_finished")
		$textanimate.play("line2")
		yield($textanimate, "animation_finished")
		$Timer.wait_time = 1
		$Timer.start()
		yield($Timer, "timeout")
		$textanimate.play_backwards("line1")
		$textanimate.play_backwards("line2")
		timelost+=30
		
	
	$intro1.bbcode_text = "Last, but certainly not least... your buddy, Teeth!"
	$intro2.bbcode_text = "Her band played their first show in a loooong time tonight. How was it?"
	$textanimate.play("line1")
	yield($textanimate, "animation_finished")
	$teeth.show()
	$textanimate.play("line2")
	yield($textanimate, "animation_finished")
	$Timer.wait_time = 2
	$Timer.start()
	yield($Timer, "timeout")
	
	if Stats.teeth_success:
		
		$intro3.bbcode_text = "She did awesome. You should've seen it for yourself."
		$intro4.bbcode_text = "You were YOU too busy doing weird things to manipulate people?"
		$textanimate.play("line3")
		$textanimate.play("line4")
		yield($textanimate, "animation_finished")
		$Timer.wait_time = 2
		$Timer.start()
		yield($Timer, "timeout")
		$textanimate.play_backwards("line1")
		$textanimate.play_backwards("line2")
		$textanimate.play_backwards("line3")
		$textanimate.play_backwards("line4")
		yield($textanimate, "animation_finished")
		$teeth.hide()
		$intro1.bbcode_text = "You went even though there was a crowd of strangers?"
		$intro2.bbcode_text = "Well, this is just disappointing!"
		$textanimate.play("line1")
		yield($textanimate, "animation_finished")
		$textanimate.play("line2")
		yield($textanimate, "animation_finished")
		$Timer.wait_time = 2
		$Timer.start()
		yield($Timer, "timeout")
		$textanimate.play_backwards("line1")
		$textanimate.play_backwards("line2")
	else:
		$intro3.bbcode_text = "She's my bestfriend and I know she'll stay by my side."
		$intro4.bbcode_text = "I want to be there for her... She deserves better..."
		$textanimate.play("line3")
		yield($textanimate, "animation_finished")
		$textanimate.play("line4")
		yield($textanimate, "animation_finished")
		$Timer.wait_time = 2
		$Timer.start()
		yield($Timer, "timeout")
		$textanimate.play_backwards("line1")
		$textanimate.play_backwards("line2")
		$textanimate.play_backwards("line3")
		$textanimate.play_backwards("line4")
		yield($textanimate, "animation_finished")
		$teeth.hide()
		$intro1.bbcode_text = "She's been by your side through think and thin,"
		$intro2.bbcode_text = "but do you really think she'll stick around when you can't even support her?"
		$textanimate.play("line1")
		yield($textanimate, "animation_finished")
		$textanimate.play("line2")
		yield($textanimate, "animation_finished")
		$Timer.wait_time = 1
		$Timer.start()
		yield($Timer, "timeout")
		$teeth.hide()
		$textanimate.play_backwards("line1")
		$textanimate.play_backwards("line2")
		timelost+=30
		ending()

func lines():
	$dark.hide()
	$dark2.show()
	$dark3.show()
	$textanimate.play("RESET")
	$Timer.wait_time = 2
	$Timer.start()
	yield($Timer, "timeout")
	$intro1.bbcode_text = poem[0]
	$intro2.bbcode_text = poem[1]
	$intro3.bbcode_text = poem[2]
	$intro4.bbcode_text = poem[3]
	$textanimate.play("reading")
	$AnimationPlayer.play("tentacles")
	yield($textanimate, "animation_finished")
	
	$dark.show()
	$dark2.hide()
	$dark3.show()
	$intro1.bbcode_text = poem[4]
	$intro2.bbcode_text = poem[5]
	$intro3.bbcode_text = poem[6]
	$intro4.bbcode_text = poem[7]
	$textanimate.play("reading")
	yield($textanimate, "animation_finished")

	$intro1.bbcode_text = poem[8]
	$intro2.bbcode_text = poem[9]
	$intro3.bbcode_text = poem[10]
	$intro4.bbcode_text = poem[11]
	$textanimate.play("reading")
	yield($textanimate, "animation_finished")
	
	$dark.show()
	$dark2.show()
	$dark3.hide()
	$intro1.bbcode_text = poem[12]
	$intro2.bbcode_text = poem[13]
	$intro3.bbcode_text = poem[14]
	$intro4.bbcode_text = poem[15]
	$textanimate.play("reading")
	yield($textanimate, "animation_finished")
	$dark3.show()
	$Player.global_position = $devour.global_position  + Vector2(-75,0)
	$dark.hide()
	$dark2.hide()
	$dark3.hide()
	grabbed()
