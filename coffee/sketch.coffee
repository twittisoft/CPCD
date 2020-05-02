balls = []
radie = 100
range = _.range
#röd blå grön gul svart vit cyan magenta
#COLORS = "#f008 #00f8 #0f08 #ff08 #0008 #fff8 #0ff8 #f0f8".split " "
COLORS = []
clicked=[]
level=0
ballClicked = 0
passive = 0

createColors = (s)->
	result = []
	for r in s
		for g in s
			for b in s
				result.push "#"+r+g+b+"8"
	result

reset = (delta)->
	COLORS = createColors	"0f"
	console.log delta
	console.log COLORS 
	level+=delta
	if level==0 then level=1
	balls = []
	clicked = []
	passive = 0
	for i in range level
		x = int random width
		y = int random height
		balls.push {x:x,y:y,rgb:COLORS[i],passive:true}
		x = int random width
		y = int random height
		balls.push {x:x,y:y,rgb:COLORS[i],passive:true}


setup = ->
	createCanvas windowWidth, windowHeight
	radie = windowHeight/4
	reset 1


draw = ->
	background 255
	for ball in balls
		if ball.passive
			fill ball.rgb 
			ellipse ball.x,ball.y,radie*2
			fill 0
			#
			textSize radie/5
			#textAlign CENTER,CENTER
			#text "#{JSON.stringify clicked} #{ballClicked}",ball.x,ball.y


mousePressed = ->
	console.log mouseX, mouseY
	ballClicked=0
	#passive=0
	for ball in balls 
		if dist(ball.x,ball.y, mouseX, mouseY)<radie and ball.passive==true

			ballClicked++
			b=ball
	if ballClicked!=1 then return reset -1
	passive++
	console.log "inside"
	clicked.push b 
	console.log "clicked.length",clicked.length
	b.passive=false
	if clicked.length!=2 then return
	if clicked[1].rgb!=clicked[0].rgb then return reset -1 else clicked = []
	if passive==balls.length then return reset 1
