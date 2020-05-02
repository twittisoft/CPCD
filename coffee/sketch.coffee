balls = []
radie = 100
range = _.range
#röd blå grön gul svart vit cyan magenta
#COLORS = "#f008 #00f8 #0f08 #ff08 #0008 #fff8 #0ff8 #f0f8".split " "
COLORS = []
clicked=[]
level = 0
ballClicked = 0
passive = 0
pattern = "0f"

overlap = (x1,y1,x2,y2) -> 
	result = dist(x1,y1,x2,y2) < radie*1.5 
	if result
		console.log dist(x1,y1,x2,y2), radie, x1,y1,x2,y2 
	result 

createColors = (s)->
	pattern = s
	result = []
	for r in s
		for g in s
			for b in s
				result.push "#"+r+g+b+"8"
	_.shuffle result

reset = (delta)->
#0123456789abcdef
	#COLORS = createColors	"cdef"
	#console.log delta
	#console.log COLORS 
	level+=delta
	if level==0 then level=1
	radie=windowHeight/2/(level+1)**0.4
	balls = []
	clicked = []
	passive = 0
	for i in range level
		for j in range 2
			antal = 0
			loop
				antal++
				if antal > 100 then break 
				x = int random width
				y = int random height

				count = 0
				for ball in balls
					if overlap x,y,ball.x,ball.y then count++
				if count == 0 then break	

			#console.log 'balls',balls
			#console.log 'count',count,antal
			balls.push {x:x,y:y,rgb:COLORS[i],passive:true}

setup = ->
	createCanvas windowWidth, windowHeight
	radie = windowHeight/4
	#params = getParameters()
	#console.log params
	#if params == 0
	pattern = '05af'
	#else
	#	pattern = params.pattern
	COLORS=createColors pattern
	reset 1
	#console.log getParameters()


draw = ->
	background 255
	fill 240
	textSize height/5
	textAlign CENTER,CENTER
	text level,width/2,height/2
	text pattern,width/2,300
	textSize height/50
	fill 0
	text '0123456789abcdef',width-100,50
	for ball in balls
		if ball.passive
			fill ball.rgb 
			ellipse ball.x,ball.y,radie*2
			# sc 0
			# sw 5
			# point ball.x,ball.y


keyPressed = ->
	#console.log key, keyCode
	if key=="2" 
		COLORS=createColors "0f"
		reset 0
	if key=="3" 
		COLORS=createColors "08f"
		reset 0
	if key=="4" 
		COLORS=createColors "05af"
		reset 0
	if key=="5" 
		COLORS=createColors "048bf"
		reset 0





mousePressed = ->
	#console.log mouseX, mouseY
	ballClicked=0
	#passive=0
	for ball in balls 
		if dist(ball.x,ball.y, mouseX, mouseY)<radie and ball.passive==true

			ballClicked++
			b=ball
	if ballClicked!=1 then return reset -1
	passive++
	# console.log "inside"
	clicked.push b 
	# console.log "clicked.length",clicked.length
	b.passive=false
	if clicked.length!=2 then return
	if clicked[1].rgb!=clicked[0].rgb then return reset -1 else clicked = []
	if passive==balls.length then return reset 1