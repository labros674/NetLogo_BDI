;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; RoboLogo
;;; A recreation of the robocode game in NetLogo
;;; v0.8 2017
;;; Ilias Sakellariou, Spyridon Krantas

;;;Behaviours related code
__includes["NetRobologo.nls"]


;;; Set up actions needed for each tank
to setup-tank-team1
  radar-rotation radar_max_rotation
  radar-start

  init-intentions

  initial-intention "Kill Enemies" "kill-enemies" forever
  add-belief create-belief "borders" (list 0 0)
  add-belief create-belief "enemies" (list 0 0)
  add-belief create-belief "friends" (list 0 0)
  ;print beliefs

end

to kill-enemies
end

;Beliefs: The tank's information about the environment
;Intention: Current intention (scan, move, shoot etc)
;; BDI example
to tank-behaviour-team1
  set label "BDI"
   let temp_list 0
   let tempy 0
  ;if any-enemy-tanks?[
    set temp_list [list xcor ycor] of one-of turtles with [breed = tanks and my-team != [ my-team ]
    of myself]
  print temp_list

 ; update-beliefs
 ; update-intentions
 ; execute-actions
end

to update-beliefs


;if close to edge apothikefsi patches-red
;if tanks-close apothikefsi x,y

;sortarisma patches-red analoga me ti thesi?

end


;;;First example of tank behaviour.(FOLLOW)
;;;The tank follows his enemy.
to setup-tank-team2
  radar-rotation radar_max_rotation
  radar-start
end

to tank-behaviour-team2
    set label "Follow"
     ;;; Avoid Walls and other tanks
    if close-to-edge? [tank-turn-rt 25 stop]
    if tanks-close? and not tank-ahead? [tank-move 0.2 ]
    if tanks-close? and tank-ahead? [tank-turn-rt 30]
    ;;; Find the closest tank
    if any-enemy-tanks? and (in-range-a my-gun-heading heading-closest-tank 0)
      [fire random game-bullet-power
       tank-turn-rt (subtract-headings heading-closest-tank heading)
       tank-move 0.2
       stop ]
    if any-enemy-tanks?
      [ turn-gun-relative-heading (subtract-headings  heading-closest-tank my-gun-heading)
        radar-stop
        stop
        ]
    if not close-to-edge? [radar-start tank-turn-rt 2 tank-move 0.1 ]
end



;;; Second example of tank behaviour.(CRAZY)
;;; The tank follows the enemy tank and tries to rams it along with the fire-shots.
to tank-behaviour-team3
    set label "Crazy"
    ;;; Avoid Walls
    if close-to-edge? [tank-turn-rt 10 stop]
    if any-enemy-tanks? and (tank-at-heading? my-gun-heading )
     [ fire random game-bullet-power
       tank-turn-rt 4 tank-move 0.2
       ]
   if true [
    tank-turn-rt (one-of [-1 1 ] * random 10)
    tank-move 0.4
    turn-gun-left 3
    turn-radar-left 3]
end



;;;Third example of tank behaviour.(STILL)
;;;The tank stays still and scans for enemies. Moves when hit.
to tank-behaviour-team4
    set label "Still"
    ;;; Avoid Walls
     if close-to-edge? [tank-turn-rt 25 stop]
     if any-enemy-tanks? and (in-range-a my-gun-heading heading-closest-tank 0)
      [fire random game-bullet-power
       tank-turn-rt (subtract-headings heading-closest-tank heading)
       stop ]
    if any-enemy-tanks?
      [ turn-gun-relative-heading (subtract-headings  heading-closest-tank my-gun-heading)
        radar-stop
        stop
        ]
    if not close-to-edge?
    [radar-start
    if any-incoming-bullets? [tank-turn-rt random 22 tank-move 0.5]
    ]
end





;;;Fourth example of tank behaviour.(RAMFIRE)
;;;Drives at robots trying to ram them. Fires when it hits them.
to tank-behaviour-team5
    set label "Ramfire"
    ;;; Avoid Walls
    if close-to-edge? [tank-turn-rt 25 stop]
    if any-enemy-tanks? and not team-tank-close? [face closest-enemy-tank tank-move 0.2]
    ;;; Avoid ramming with team tanks
    if any-enemy-tanks? and team-tank-close? [tank-turn-rt 25 tank-move 0.2]
    if any-enemy-tanks? and ramming?
      [fire random game-bullet-power
       tank-turn-rt (subtract-headings heading-closest-tank heading)
       stop ]
    if any-enemy-tanks?
      [ turn-gun-relative-heading (subtract-headings  heading-closest-tank my-gun-heading)
        radar-stop
        stop
        ]
    if not close-to-edge? [radar-start tank-move 0.2 tank-turn-rt 5]
end



;;;Fifth example of tank behaviour.(SPINBOT)
;;;Moves in a circle, firing hard when an enemy is detected.
to tank-behaviour-team6
    set label "Spinbot"
    ;;; Avoid Walls and other tanks
    if close-to-edge? [tank-turn-rt 25 stop]
    if tanks-close? and not tank-ahead? [tank-move 0.2 ]
    if tanks-close? and tank-ahead? [tank-turn-rt 30]
    ;;; Find the closest tank
    if any-enemy-tanks? and (in-range-a my-gun-heading heading-closest-tank 0)
      [fire random game-bullet-power
       tank-move 0.3 tank-turn-rt 45
       stop ]
    if any-enemy-tanks?
      [ turn-gun-relative-heading (subtract-headings  heading-closest-tank my-gun-heading)
        radar-stop
        stop
        ]
    if not close-to-edge? [radar-start tank-move 0.2 tank-turn-rt 20]
end




;;;PROTOTYPE
to tank-behaviour-team10
    ;;; Avoid Walls and other tanks
    if close-to-edge? [tank-turn-rt 25 stop]
    if tanks-close? and not tank-ahead? [tank-move 0.2 stop]
    if tanks-close? and tank-ahead? [tank-turn-rt 30 stop]
    ;if any-incomming-fire-close?
    ;     [tank-turn
    ;;; Find the closest tank

    if any-enemy-tanks? and (my-gun-heading  =  heading-closest-tank)
      [fire random game-bullet-power ;;stop] ;; one action at the time.
       unlock-gun-motion
       unlock-radar-motion
       tank-turn-rt (90 +  (subtract-headings heading-closest-tank heading) )
       tank-move 0.2 ;; robot_acceleration
       stop]

    ;;; turning
    if any-enemy-tanks?
      [ ;; let t-heading (first heading-distance-closest-tank)

      ;; THIS IS WRONG - Should have used an action ask my-gun [rt subtract-headings t-heading  ]
       turn-gun-relative-heading (subtract-headings  heading-closest-tank my-gun-heading)
       radar-stop ;;; locks radar
       stop]
   ;; Moving around
   if not close-to-edge? [radar-start tank-move 0.1  stop]

end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
956
757
-1
-1
18.0
1
10
1
1
1
0
0
0
1
-20
20
-20
20
1
1
1
ticks
30.0

BUTTON
24
18
196
51
Setup Robolog
setup-netrobologo
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
26
66
198
99
num-tanks
num-tanks
2
50
2.0
2
1
NIL
HORIZONTAL

SLIDER
25
441
197
474
edgeWidth
edgeWidth
1
10
8.0
1
1
NIL
HORIZONTAL

BUTTON
23
119
104
152
NIL
run-game
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
120
119
198
152
NIL
run-game
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
23
389
195
422
wait-for
wait-for
0
0.5
0.0
0.05
1
NIL
HORIZONTAL

SLIDER
15
619
189
652
game-bullet-power
game-bullet-power
0.1
3
2.9
0.1
1
NIL
HORIZONTAL

SLIDER
18
673
190
706
speed
speed
1
8
3.0
1
1
NIL
HORIZONTAL

OUTPUT
1031
99
1271
480
11

TEXTBOX
1031
71
1181
98
Score
22
0.0
1

BUTTON
24
188
153
221
Debug
set-bdi-debug-mode 1
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
47
280
166
325
Debug Off
bdi-lib##DEBUG
17
1
11

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250
Line -7500403 true 0 0 0 300

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

cannon
true
0
Polygon -7500403 true true 165 0 165 15 180 150 195 165 195 180 180 195 165 225 135 225 120 195 105 180 105 165 120 150 135 15 135 0
Line -16777216 false 120 150 180 150
Line -16777216 false 120 195 180 195
Line -16777216 false 165 15 135 15
Polygon -16777216 false false 165 0 135 0 135 15 120 150 105 165 105 180 120 195 135 225 165 225 180 195 195 180 195 165 180 150 165 15

cannon-2
true
0
Polygon -7500403 true true 105 90 195 90 225 120 225 195 210 270 150 300 90 270 75 195 75 120
Polygon -7500403 true true 165 0 165 15 180 150 195 165 195 180 180 195 165 225 135 225 120 195 105 180 105 165 120 150 135 15 135 0
Line -16777216 false 120 150 180 150
Line -16777216 false 120 195 180 195
Line -16777216 false 165 15 135 15
Polygon -16777216 false false 165 0 135 0 135 15 120 150 105 165 105 180 120 195 135 225 165 225 180 195 195 180 195 165 180 150 165 15
Polygon -16777216 false false 75 120 75 195 90 270 150 300 210 270 225 195 225 120 195 90 105 90

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

explosion-shape
true
0
Rectangle -7500403 true true 60 165 90 195
Circle -7500403 true true 54 54 42
Circle -7500403 true true 195 45 30
Circle -7500403 true true 99 84 42
Circle -7500403 true true 75 210 30
Circle -7500403 true true 150 255 30
Circle -7500403 true true 210 120 30
Circle -7500403 true true 210 180 30
Circle -2674135 true false 114 9 42
Circle -5825686 true false 99 144 42
Circle -2674135 true false 135 195 30
Circle -2674135 true false 150 120 30
Circle -2674135 true false 24 99 42
Circle -2674135 true false 270 165 30
Rectangle -2674135 true false 195 240 210 255
Rectangle -2674135 true false 240 90 255 105
Rectangle -955883 true false 195 165 210 180
Rectangle -955883 true false 30 195 45 210
Rectangle -955883 true false 165 75 180 90
Rectangle -955883 true false 105 255 120 270
Rectangle -955883 true false 75 135 90 150

explosion-shape2
true
0
Line -955883 false 180 180 225 225
Line -955883 false 150 135 180 60
Line -955883 false 165 135 255 75
Line -955883 false 120 105 90 30
Line -2674135 false 105 120 30 105
Line -2674135 false 75 195 45 210
Line -2674135 false 60 255 120 180
Line -2674135 false 120 285 135 240
Line -7500403 true 210 270 180 210
Line -7500403 true 135 165 45 195
Line -7500403 true 165 120 210 30
Line -7500403 true 180 165 270 210
Line -7500403 true 120 120 60 45
Line -7500403 true 60 90 30 60
Line -5825686 false 165 60 180 0
Line -1184463 false 120 210 90 270
Line -1184463 false 240 165 285 180
Line -1184463 false 210 195 255 225
Line -1184463 false 15 165 75 165
Line -1184463 false 225 120 285 90
Line -1184463 false 195 90 240 45
Line -2674135 false 150 195 165 285
Line -955883 false 135 135 135 15
Line -955883 false 165 150 270 135
Line -955883 false 120 150 0 135
Circle -2674135 true false 105 150 28
Circle -955883 true false 120 165 30
Circle -955883 true false 135 135 30
Circle -955883 true false 120 135 30
Circle -2674135 true false 135 150 30
Circle -2674135 true false 120 120 28

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fire
false
0
Polygon -7500403 true true 151 286 134 282 103 282 59 248 40 210 32 157 37 108 68 146 71 109 83 72 111 27 127 55 148 11 167 41 180 112 195 57 217 91 226 126 227 203 256 156 256 201 238 263 213 278 183 281
Polygon -955883 true false 126 284 91 251 85 212 91 168 103 132 118 153 125 181 135 141 151 96 185 161 195 203 193 253 164 286
Polygon -2674135 true false 155 284 172 268 172 243 162 224 148 201 130 233 131 260 135 282

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

hit-shape
true
0
Polygon -7500403 true true 105 150 15 165 105 165 30 225 105 195 60 255 135 210 180 300 180 195 270 240 195 165 285 150 180 135 255 75 165 105 135 30 135 135 75 30 105 120 15 105

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

radar
true
0
Rectangle -7500403 true true 15 105 285 120
Circle -16777216 true false 135 150 30
Polygon -1 false false 15 120 45 180 90 210 210 210 255 180 285 120 150 120

rocket
true
0
Polygon -7500403 true true 120 165 75 285 135 255 165 255 225 285 180 165
Polygon -1 true false 135 285 105 135 105 105 120 45 135 15 150 0 165 15 180 45 195 105 195 135 165 285
Rectangle -7500403 true true 147 176 153 288
Polygon -7500403 true true 120 45 180 45 165 15 150 0 135 15
Line -7500403 true 105 105 135 120
Line -7500403 true 135 120 165 120
Line -7500403 true 165 120 195 105
Line -7500403 true 105 135 135 150
Line -7500403 true 135 150 165 150
Line -7500403 true 165 150 195 135

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

tank
true
0
Rectangle -6459832 true false 195 45 255 255
Rectangle -16777216 false false 195 45 255 255
Rectangle -6459832 true false 45 45 105 255
Rectangle -16777216 false false 45 45 105 255
Line -16777216 false 45 75 255 75
Line -16777216 false 45 105 255 105
Line -16777216 false 45 60 255 60
Line -16777216 false 45 240 255 240
Line -16777216 false 45 225 255 225
Line -16777216 false 45 195 255 195
Line -16777216 false 45 150 255 150
Polygon -7500403 true true 90 60 60 90 60 240 120 255 180 255 240 240 240 90 210 60
Polygon -16777216 false false 135 120 105 135 101 181 120 225 149 234 180 225 199 182 195 135 165 120
Polygon -16777216 false false 240 90 210 60 211 246 240 240
Polygon -16777216 false false 60 90 90 60 89 246 60 240
Polygon -16777216 false false 89 247 116 254 183 255 211 246 211 237 89 236
Rectangle -16777216 false false 90 60 210 90

tank-2
true
0
Rectangle -6459832 true false 195 45 255 255
Rectangle -16777216 false false 195 45 255 255
Rectangle -6459832 true false 45 45 105 255
Rectangle -16777216 false false 45 45 105 255
Line -16777216 false 45 75 255 75
Line -16777216 false 45 105 255 105
Line -16777216 false 45 60 255 60
Line -16777216 false 45 240 255 240
Line -16777216 false 45 225 255 225
Line -16777216 false 45 195 255 195
Line -16777216 false 45 150 255 150
Polygon -7500403 true true 90 60 60 90 60 240 120 255 180 255 240 240 240 90 210 60
Polygon -16777216 false false 240 90 210 60 211 246 240 240
Polygon -16777216 false false 60 90 90 60 89 246 60 240
Polygon -16777216 false false 89 247 116 254 183 255 211 246 211 237 89 236
Rectangle -16777216 false false 90 60 210 90

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
