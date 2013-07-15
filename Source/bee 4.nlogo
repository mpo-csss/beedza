globals [total_honey total_bees total_honey_accacia total_honey_lime total_honey_polyflower total_honey_sunflower total_hives random_distribution beekeepers is_setup]
turtles-own [hives accacia_honey lime_honey sunflower_honey polyflower_honey origin_x origin_y]
patches-own [spots_total spots_occupied honey_type min_day max_day county hi_polyflower hi]

to setup
  clear-all
  set is_setup true
  set random_distribution false
  set beekeepers 1
  setup_beekeepers
    
  setup_patches
  
  set is_setup false
  reset-ticks
 ;; movie-start "out1.mov"
end

to go
  if ticks >= 90 [;;movie-close 
    stop ] 
  ask turtles [
    increase_population
    harvest
  ]
  
  tick
;;  movie-grab-interface
end

to increase_population
    ;; print (word "hive " hives)
    let new_hives []
    foreach hives[
         set new_hives lput (? + 100) new_hives
         set total_bees (total_bees + ? + 100)
      ]
   ;; print (word "new hive " new_hives)
   set hives new_hives
   ;; print (word "new hive final " hives)
end

to harvest
   
    if [honey_type] of patch xcor ycor = 0 [set polyflower_honey (polyflower_honey + 1) set total_honey_polyflower (total_honey_polyflower + 1)]
    
    if [honey_type] of patch xcor ycor = 1 [
      ifelse ticks >= [min_day] of patch xcor ycor and ticks <= [max_day] of patch xcor ycor 
      [set accacia_honey (accacia_honey + 100) set total_honey_accacia (total_honey_accacia + 100)]
      [set polyflower_honey (polyflower_honey + 1) set total_honey_polyflower (total_honey_polyflower + 1)]
    ]
    
    if [honey_type] of patch xcor ycor = 2 [
      ifelse ticks >= [min_day] of patch xcor ycor and ticks <= [max_day] of patch xcor ycor 
      [set lime_honey (lime_honey + 100) set total_honey_lime (total_honey_lime + 100)]
      [set polyflower_honey (polyflower_honey + 1) set total_honey_polyflower (total_honey_polyflower + 1)]
    ]
    
    if [honey_type] of patch xcor ycor = 3 [
      ifelse ticks >= [min_day] of patch xcor ycor and ticks <= [max_day] of patch xcor ycor 
      [set sunflower_honey (sunflower_honey + 100) set total_honey_sunflower (total_honey_sunflower + 100)]
      [set polyflower_honey (polyflower_honey + 1) set total_honey_polyflower (total_honey_polyflower + 1)]
    ]
    set total_honey total_honey_polyflower + total_honey_accacia + total_honey_lime + total_honey_sunflower
    fd 1            ;; forward 1 step
    rt random 10    ;; turn right
    lt random 10    ;; turn left
end

to setup_beekeepers
  create-turtles Beekeepers * 80 [ setxy random-xcor random-ycor ];;[setxy -3 3]
  if not random_distribution [setup_beekeepers_origin]
  ask turtles [
   ;; if not random_distribution [setxy -3 3]
   ;; let hive n-values (30 + random (30)) [(20000 + random (10000))]
    set hives ((30 + random (30)) * (20000 + random (10000))) ;; initialize the bees population of the origin
    set color red
    set origin_x xcor ;; remember the origin x
    set origin_y ycor ;; remember the origin y
  ]
  inspect turtle 0
  inspect turtle 1
end



to setup_patches
  if is_setup [
 
  ask patches[
     ask patch -4 8 [set honey_type 1 set min_day 15 set max_day 30 set county "SM" set spots_total 30 set hi 0.0000115]
  ask patch -4 7 [set honey_type 0 set min_day 1 set max_day 90 set county "SM"]
  ask patch -4 6 [set honey_type 0 set min_day 1 set max_day 90 set county "SM"]
  ask patch -3 8 [set honey_type 0 set min_day 1 set max_day 90 set county "SM"]
  ask patch -3 7 [set honey_type 1 set min_day 15 set max_day 30 set county "SM" set spots_total 18 set hi 0.0000115]
  ask patch -3 6 [set honey_type 0 set min_day 1 set max_day 90 set county "SM"]
  
  ask patch -2 8 [set honey_type 0 set min_day 1 set max_day 90 set county "MM"]
  ask patch -2 7 [set honey_type 0 set min_day 1 set max_day 90 set county "MM"]
  ask patch -2 6 [set honey_type 0 set min_day 1 set max_day 90 set county "MM"]
  ask patch -1 8 [set honey_type 0 set min_day 1 set max_day 90 set county "MM"]
  ask patch -1 7 [set honey_type 0 set min_day 1 set max_day 90 set county "MM"]
  ask patch -1 6 [set honey_type 0 set min_day 1 set max_day 90 set county "MM"]
  
  ask patch 0 8 [set honey_type 0 set min_day 1 set max_day 90 set county "SV"]
  ask patch 0 7 [set honey_type 0 set min_day 1 set max_day 90 set county "SV"]
  ask patch 0 6 [set honey_type 0 set min_day 1 set max_day 90 set county "SV"]
  ask patch 1 8 [set honey_type 0 set min_day 1 set max_day 90 set county "SV"]
  ask patch 1 7 [set honey_type 0 set min_day 1 set max_day 90 set county "SV"]
  ask patch 1 6 [set honey_type 0 set min_day 1 set max_day 90 set county "SV"]
  
  ask patch 1 8 [set honey_type 0 set min_day 1 set max_day 90 set county "BT"]
  ask patch 1 7 [set honey_type 0 set min_day 1 set max_day 90 set county "BT"]
  ask patch 1 6 [set honey_type 0 set min_day 1 set max_day 90 set county "BT"]
  ask patch 2 8 [set honey_type 0 set min_day 1 set max_day 90 set county "BT"]
  ask patch 2 7 [set honey_type 0 set min_day 1 set max_day 90 set county "BT"]
  ask patch 2 6 [set honey_type 0 set min_day 1 set max_day 90 set county "BT"]
  
  ask patch -6 5 [set honey_type 1 set min_day 12 set max_day 27 set county "BH" set spots_total 42 set hi 0.0000115]
  ask patch -6 4 [set honey_type 1 set min_day 12 set max_day 27 set county "BH" set spots_total 30 set hi 0.0000115]
  ask patch -6 3 [set honey_type 0 set min_day 1 set max_day 90 set county "BH"]
  ask patch -5 5 [set honey_type 0 set min_day 1 set max_day 90 set county "BH"]
  ask patch -5 4 [set honey_type 0 set min_day 1 set max_day 90 set county "BH"]
  ask patch -5 3 [set honey_type 0 set min_day 1 set max_day 90 set county "BH"]
  
  ask patch -4 5 [set honey_type 0 set min_day 1 set max_day 90 set county "SJ"]
  ask patch -4 4 [set honey_type 0 set min_day 1 set max_day 90 set county "SJ"]
  ask patch -4 3 [set honey_type 0 set min_day 1 set max_day 90 set county "SJ"]
  ask patch -3 5 [set honey_type 0 set min_day 1 set max_day 90 set county "SJ"]
  ask patch -3 4 [set honey_type 0 set min_day 1 set max_day 90 set county "SJ"]
  ask patch -3 3 [set honey_type 0 set min_day 1 set max_day 90 set county "SJ"]
  
  ask patch -2 5 [set honey_type 0 set min_day 1 set max_day 90 set county "CJ"]
  ask patch -2 4 [set honey_type 0 set min_day 1 set max_day 90 set county "CJ"]
  ask patch -2 3 [set honey_type 0 set min_day 1 set max_day 90 set county "CJ"]
  ask patch -1 5 [set honey_type 0 set min_day 1 set max_day 90 set county "CJ"]
  ask patch -1 4 [set honey_type 0 set min_day 1 set max_day 90 set county "CJ"]
  ask patch -1 3 [set honey_type 0 set min_day 1 set max_day 90 set county "CJ"]
  
  ask patch 0 5 [set honey_type 0 set min_day 1 set max_day 90 set county "BN"]
  ask patch 0 4 [set honey_type 0 set min_day 1 set max_day 90 set county "BN"]
  ask patch 0 3 [set honey_type 0 set min_day 1 set max_day 90 set county "BN"]
  ask patch 1 5 [set honey_type 0 set min_day 1 set max_day 90 set county "BN"]
  ask patch 1 4 [set honey_type 0 set min_day 1 set max_day 90 set county "BN"]
  ask patch 1 3 [set honey_type 0 set min_day 1 set max_day 90 set county "BN"]
  
  ask patch 2 5 [set honey_type 0 set min_day 1 set max_day 90 set county "NT"]
  ask patch 2 4 [set honey_type 0 set min_day 1 set max_day 90 set county "NT"]
  ask patch 2 3 [set honey_type 0 set min_day 1 set max_day 90 set county "NT"]
  ask patch 3 5 [set honey_type 0 set min_day 1 set max_day 90 set county "NT"]
  ask patch 3 4 [set honey_type 0 set min_day 1 set max_day 90 set county "NT"]
  ask patch 3 3 [set honey_type 0 set min_day 1 set max_day 90 set county "NT"]
  
  ask patch 4 5 [set honey_type 0 set min_day 1 set max_day 90 set county "IS"]
  ask patch 4 4 [set honey_type 0 set min_day 1 set max_day 90 set county "IS"]
  ask patch 4 3 [set honey_type 0 set min_day 1 set max_day 90 set county "IS"]
  ask patch 5 5 [set honey_type 2 set min_day 43 set max_day 63 set county "IS" set spots_total 180 set hi 0.000014]
  ask patch 5 4 [set honey_type 2 set min_day 43 set max_day 63 set county "IS" set spots_total 168 set hi 0.000014]
  ask patch 5 3 [set honey_type 0 set min_day 1 set max_day 90 set county "IS"]
  
  ask patch -6 2 [set honey_type 0 set min_day 1 set max_day 90 set county "AR"]
  ask patch -6 1 [set honey_type 3 set min_day 55 set max_day 90 set county "AR" set spots_total 528 set hi 0.000004]
  ask patch -6 0 [set honey_type 0 set min_day 1 set max_day 90 set county "AR"]
  ask patch -5 2 [set honey_type 0 set min_day 1 set max_day 90 set county "AR"]
  ask patch -5 1 [set honey_type 3 set min_day 55 set max_day 90 set county "AR" set spots_total 540 set hi 0.000004]
  ask patch -5 0 [set honey_type 3 set min_day 55 set max_day 90 set county "AR" set spots_total 546 set hi 0.000004]
   
  ask patch -4 2 [set honey_type 0 set min_day 1 set max_day 90 set county "AB"]
  ask patch -4 1 [set honey_type 0 set min_day 1 set max_day 90 set county "AB"]
  ask patch -4 0 [set honey_type 0 set min_day 1 set max_day 90 set county "AB"]
  ask patch -3 2 [set honey_type 1 set min_day 19 set max_day 34 set county "AB" set spots_total 72 set hi 0.0000115]
  ask patch -3 1 [set honey_type 0 set min_day 1 set max_day 90 set county "AB"]
  ask patch -3 0 [set honey_type 0 set min_day 1 set max_day 90 set county "AB"]
  
  ask patch -2 2 [set honey_type 0 set min_day 1 set max_day 90 set county "MS"]
  ask patch -2 1 [set honey_type 0 set min_day 1 set max_day 90 set county "MS"]
  ask patch -2 0 [set honey_type 0 set min_day 1 set max_day 90 set county "MS"]
  ask patch -1 2 [set honey_type 0 set min_day 1 set max_day 90 set county "MS"]
  ask patch -1 1 [set honey_type 0 set min_day 1 set max_day 90 set county "MS"]
  ask patch -1 0 [set honey_type 0 set min_day 1 set max_day 90 set county "MS"]
  
  ask patch 0 2 [set honey_type 0 set min_day 1 set max_day 90 set county "HR"]
  ask patch 0 1 [set honey_type 0 set min_day 1 set max_day 90 set county "HR"]
  ask patch 0 0 [set honey_type 0 set min_day 1 set max_day 90 set county "HR"]
  ask patch 1 2 [set honey_type 0 set min_day 1 set max_day 90 set county "HR"]
  ask patch 1 1 [set honey_type 0 set min_day 1 set max_day 90 set county "HR"]
  ask patch 1 0 [set honey_type 0 set min_day 1 set max_day 90 set county "HR"]
  
  ask patch 2 2 [set honey_type 0 set min_day 1 set max_day 90 set county "BC"]
  ask patch 2 1 [set honey_type 0 set min_day 1 set max_day 90 set county "BC"]
  ask patch 2 0 [set honey_type 0 set min_day 1 set max_day 90 set county "BC"]
  ask patch 3 2 [set honey_type 0 set min_day 1 set max_day 90 set county "BC"]
  ask patch 3 1 [set honey_type 0 set min_day 1 set max_day 90 set county "BC"]
  ask patch 3 0 [set honey_type 0 set min_day 1 set max_day 90 set county "BC"]
  
  ask patch 4 2 [set honey_type 0 set min_day 1 set max_day 90 set county "VS"]
  ask patch 4 1 [set honey_type 0 set min_day 1 set max_day 90 set county "VS"]
  ask patch 4 0 [set honey_type 0 set min_day 1 set max_day 90 set county "VS"]
  ask patch 5 2 [set honey_type 0 set min_day 1 set max_day 90 set county "VS"]
  ask patch 5 1 [set honey_type 0 set min_day 1 set max_day 90 set county "VS"]
  ask patch 5 0 [set honey_type 0 set min_day 1 set max_day 90 set county "VS"]
  
  ask patch -6 -1 [set honey_type 0 set min_day 1 set max_day 90 set county "TM"]
  ask patch -6 -2 [set honey_type 1 set min_day 16 set max_day 31 set county "TM" set spots_total 24 set hi 0.0000115]
  ask patch -6 -3 [set honey_type 0 set min_day 1 set max_day 90 set county "TM"]
  ask patch -5 -1 [set honey_type 3 set min_day 55 set max_day 90 set county "TM" set spots_total 552 set hi 0.000004]
  ask patch -5 -2 [set honey_type 1 set min_day 16 set max_day 31 set county "TM" set spots_total 24 set hi 0.0000115]
  ask patch -5 -3 [set honey_type 0 set min_day 1 set max_day 90 set county "TM"]
  
  ask patch -4 -1 [set honey_type 0 set min_day 1 set max_day 90 set county "HD"]
  ask patch -4 -2 [set honey_type 0 set min_day 1 set max_day 90 set county "HD"]
  ask patch -4 -3 [set honey_type 0 set min_day 1 set max_day 90 set county "HD"]
  ask patch -3 -1 [set honey_type 0 set min_day 1 set max_day 90 set county "HD"]
  ask patch -3 -2 [set honey_type 0 set min_day 1 set max_day 90 set county "HD"]
  ask patch -3 -3 [set honey_type 0 set min_day 1 set max_day 90 set county "HD"]
  
  ask patch -2 -1 [set honey_type 0 set min_day 1 set max_day 90 set county "SB"]
  ask patch -2 -2 [set honey_type 0 set min_day 1 set max_day 90 set county "SB"]
  ask patch -2 -3 [set honey_type 0 set min_day 1 set max_day 90 set county "SB"]
  ask patch -1 -1 [set honey_type 0 set min_day 1 set max_day 90 set county "SB"]
  ask patch -1 -2 [set honey_type 0 set min_day 1 set max_day 90 set county "SB"]
  ask patch -1 -3 [set honey_type 0 set min_day 1 set max_day 90 set county "SB"]
  
  ask patch 0 -1 [set honey_type 0 set min_day 1 set max_day 90 set county "BV"]
  ask patch 0 -2 [set honey_type 0 set min_day 1 set max_day 90 set county "BV"]
  ask patch 0 -3 [set honey_type 0 set min_day 1 set max_day 90 set county "BV"]
  ask patch 1 -1 [set honey_type 0 set min_day 1 set max_day 90 set county "BV"]
  ask patch 1 -2 [set honey_type 0 set min_day 1 set max_day 90 set county "BV"]
  ask patch 1 -3 [set honey_type 0 set min_day 1 set max_day 90 set county "BV"]
  
  ask patch 2 -1 [set honey_type 0 set min_day 1 set max_day 90 set county "CV"]
  ask patch 2 -2 [set honey_type 0 set min_day 1 set max_day 90 set county "CV"]
  ask patch 2 -3 [set honey_type 0 set min_day 1 set max_day 90 set county "CV"]
  ask patch 3 -1 [set honey_type 0 set min_day 1 set max_day 90 set county "CV"]
  ask patch 3 -2 [set honey_type 0 set min_day 1 set max_day 90 set county "CV"]
  ask patch 3 -3 [set honey_type 0 set min_day 1 set max_day 90 set county "CV"]
  
  ask patch 4 -1 [set honey_type 0 set min_day 1 set max_day 90 set county "VN"]
  ask patch 4 -2 [set honey_type 0 set min_day 1 set max_day 90 set county "VN"]
  ask patch 4 -3 [set honey_type 0 set min_day 1 set max_day 90 set county "VN"]
  ask patch 5 -1 [set honey_type 0 set min_day 1 set max_day 90 set county "VN"]
  ask patch 5 -2 [set honey_type 0 set min_day 1 set max_day 90 set county "VN"]
  ask patch 5 -3 [set honey_type 0 set min_day 1 set max_day 90 set county "VN"]
  
  ask patch 7 -1 [set honey_type 0 set min_day 1 set max_day 90 set county "GL"]
  ask patch 7 -2 [set honey_type 1 set min_day 6 set max_day 21 set county "GL" set spots_total 60 set hi 0.0000115]
  ask patch 7 -3 [set honey_type 0 set min_day 1 set max_day 90 set county "GL"]
  ask patch 6 -1 [set honey_type 3 set min_day 55 set max_day 90 set county "GL" set spots_total 594 set hi 0.000004]
  ask patch 6 -2 [set honey_type 1 set min_day 6 set max_day 21 set county "GL" set spots_total 66 set hi 0.0000115]
  ask patch 6 -3 [set honey_type 0 set min_day 1 set max_day 90 set county "GL"]
  
  ask patch -8 -4 [set honey_type 2 set min_day 34 set max_day 54 set county "CS" set spots_total 30 set hi 0.000014]
  ask patch -8 -5 [set honey_type 2 set min_day 34 set max_day 54 set county "CS" set spots_total 30 set hi 0.000014]
  ask patch -8 -6 [set honey_type 2 set min_day 34 set max_day 54 set county "CS" set spots_total 30 set hi 0.000014]
  ask patch -7 -4 [set honey_type 2 set min_day 34 set max_day 54 set county "CS" set spots_total 42 set hi 0.000014]
  ask patch -7 -5 [set honey_type 0 set min_day 1 set max_day 90 set county "CS"]
  ask patch -7 -6 [set honey_type 0 set min_day 1 set max_day 90 set county "CS"]
  
  ask patch -6 -4 [set honey_type 0 set min_day 1 set max_day 90 set county "GJ"]
  ask patch -6 -5 [set honey_type 0 set min_day 1 set max_day 90 set county "GJ"]
  ask patch -6 -6 [set honey_type 0 set min_day 1 set max_day 90 set county "GJ"]
  ask patch -5 -4 [set honey_type 0 set min_day 1 set max_day 90 set county "GJ"]
  ask patch -5 -5 [set honey_type 0 set min_day 1 set max_day 90 set county "GJ"]
  ask patch -5 -6 [set honey_type 0 set min_day 1 set max_day 90 set county "GJ"]
  
  ask patch -4 -4 [set honey_type 0 set min_day 1 set max_day 90 set county "VL"]
  ask patch -4 -5 [set honey_type 1 set min_day 13 set max_day 28 set county "VL" set spots_total 354 set hi 0.0000145]
  ask patch -4 -6 [set honey_type 0 set min_day 1 set max_day 90 set county "VL"]
  ask patch -3 -4 [set honey_type 0 set min_day 1 set max_day 90 set county "VL"]
  ask patch -3 -5 [set honey_type 0 set min_day 1 set max_day 90 set county "VL"]
  ask patch -3 -6 [set honey_type 0 set min_day 1 set max_day 90 set county "VL"]
  
  ask patch -2 -4 [set honey_type 0 set min_day 1 set max_day 90 set county "AG"]
  ask patch -2 -5 [set honey_type 0 set min_day 1 set max_day 90 set county "AG"]
  ask patch -2 -6 [set honey_type 13 set min_day 28 set max_day 30 set county "AG" set spots_total 174 set hi 0.0000145]
  ask patch -1 -4 [set honey_type 0 set min_day 1 set max_day 90 set county "AG"]
  ask patch -1 -5 [set honey_type 0 set min_day 1 set max_day 90 set county "AG"]
  ask patch -1 -6 [set honey_type 0 set min_day 1 set max_day 90 set county "AG"]
  
  ask patch 0 -4 [set honey_type 0 set min_day 1 set max_day 90 set county "DB"]
  ask patch 0 -5 [set honey_type 0 set min_day 1 set max_day 90 set county "DB"]
  ask patch 0 -6 [set honey_type 0 set min_day 1 set max_day 90 set county "DB"]
  ask patch 1 -4 [set honey_type 0 set min_day 1 set max_day 90 set county "DB"]
  ask patch 1 -5 [set honey_type 1 set min_day 3 set max_day 18 set county "DB" set spots_total 12 set hi 0.0000145]
  ask patch 1 -6 [set honey_type 1 set min_day 3 set max_day 18 set county "DB" set spots_total 12 set hi 0.0000145]
  
  ask patch 2 -4 [set honey_type 0 set min_day 1 set max_day 90 set county "PH"]
  ask patch 2 -5 [set honey_type 0 set min_day 1 set max_day 90 set county "PH"]
  ask patch 2 -6 [set honey_type 1 set min_day 13 set max_day 28 set county "PH" set spots_total 150 set hi 0.0000145]
  ask patch 3 -4 [set honey_type 0 set min_day 1 set max_day 90 set county "PH"]
  ask patch 3 -5 [set honey_type 0 set min_day 1 set max_day 90 set county "PH"]
  ask patch 3 -6 [set honey_type 0 set min_day 1 set max_day 90 set county "PH"]
  
  ask patch 4 -4 [set honey_type 0 set min_day 1 set max_day 90 set county "BZ"]
  ask patch 4 -5 [set honey_type 3 set min_day 50 set max_day 85 set county "BZ" set spots_total 588 set hi 0.000006]
  ask patch 4 -6 [set honey_type 1 set min_day 3 set max_day 18 set county "BZ" set spots_total 18 set hi 0.0000145]
  ask patch 5 -4 [set honey_type 0 set min_day 1 set max_day 90 set county "BZ"]
  ask patch 5 -5 [set honey_type 0 set min_day 1 set max_day 90 set county "BZ"]
  ask patch 5 -6 [set honey_type 1 set min_day 3 set max_day 18 set county "BZ" set spots_total 30 set hi 0.0000145]
  
  ask patch 6 -4 [set honey_type 3 set min_day 50 set max_day 85 set county "BR" set spots_total 558 set hi 0.000008]
  ask patch 6 -5 [set honey_type 3 set min_day 50 set max_day 85 set county "BR" set spots_total 582 set hi 0.000008]
  ask patch 6 -6 [set honey_type 1 set min_day 3 set max_day 18 set county "BR" set spots_total 42 set hi 0.0000145]
  ask patch 7 -4 [set honey_type 0 set min_day 1 set max_day 90 set county "BR"]
  ask patch 7 -5 [set honey_type 3 set min_day 50 set max_day 85 set county "BR" set spots_total 540 set hi 0.000008]
  ask patch 7 -6 [set honey_type 1 set min_day 3 set max_day 18 set county "BR" set spots_total 60 set hi 0.0000145]
  
  ask patch 8 -4 [set honey_type 3 set min_day 50 set max_day 85 set county "TL" set spots_total 594 set hi 0.000008]
  ask patch 8 -5 [set honey_type 3 set min_day 50 set max_day 85 set county "TL" set spots_total 594 set hi 0.000008]
  ask patch 8 -6 [set honey_type 1 set min_day 3 set max_day 18 set county "TL" set spots_total 18 set hi 0.0000145]
  ask patch 9 -4 [set honey_type 0 set min_day 1 set max_day 90 set county "TL"]
  ask patch 9 -5 [set honey_type 2 set min_day 34 set max_day 54 set county "TL" set spots_total 216 set hi 0.000022]
  ask patch 9 -6 [set honey_type 2 set min_day 34 set max_day 54 set county "TL" set spots_total 180 set hi 0.000022]
  
  ask patch -8 -7 [set honey_type 0 set min_day 1 set max_day 90 set county "MH"]
  ask patch -8 -8 [set honey_type 1 set min_day 10 set max_day 25 set county "MH" set spots_total 72 set hi 0.0000175]
  ask patch -8 -9 [set honey_type 1 set min_day 1 set max_day 15 set county "MH" set spots_total 60 set hi 0.0000175]
  ask patch -7 -7 [set honey_type 0 set min_day 1 set max_day 90 set county "MH"]
  ask patch -7 -8 [set honey_type 1 set min_day 10 set max_day 25 set county "MH" set spots_total 84 set hi 0.0000175]
  ask patch -7 -9 [set honey_type 1 set min_day 1 set max_day 15 set county "MH" set spots_total 90 set hi 0.0000175]
  
  ask patch -6 -7 [set honey_type 0 set min_day 1 set max_day 90 set county "DJ"]
  ask patch -6 -8 [set honey_type 1 set min_day 1 set max_day 15 set county "DJ" set spots_total 90 set hi 0.0000175]
  ask patch -6 -9 [set honey_type 1 set min_day 1 set max_day 15 set county "DJ" set spots_total 78 set hi 0.0000175]
  ask patch -5 -7 [set honey_type 0 set min_day 1 set max_day 90 set county "DJ"]
  ask patch -5 -8 [set honey_type 1 set min_day 1 set max_day 15 set county "DJ" set spots_total 60 set hi 0.0000175]
  ask patch -5 -9 [set honey_type 3 set min_day 60 set max_day 90 set county "DJ" set spots_total 540 set hi 0.000004]
  
  ask patch -4 -7 [set honey_type 1 set min_day 10 set max_day 25 set county "OT" set spots_total 126 set hi 0.0000175]
  ask patch -4 -8 [set honey_type 0 set min_day 1 set max_day 90 set county "OT"]
  ask patch -4 -9 [set honey_type 0 set min_day 1 set max_day 90 set county "OT"]
  ask patch -3 -7 [set honey_type 0 set min_day 1 set max_day 90 set county "OT"]
  ask patch -3 -8 [set honey_type 0 set min_day 1 set max_day 90 set county "OT"]
  ask patch -3 -9 [set honey_type 0 set min_day 1 set max_day 90 set county "OT"]
  
  ask patch -2 -7 [set honey_type 3 set min_day 45 set max_day 80 set county "TR" set spots_total 540 set hi 0.000006]
  ask patch -2 -8 [set honey_type 3 set min_day 45 set max_day 80 set county "TR" set spots_total 570 set hi 0.000006]
  ask patch -2 -9 [set honey_type 3 set min_day 45 set max_day 80 set county "TR" set spots_total 594 set hi 0.000006]
  ask patch -1 -7 [set honey_type 3 set min_day 45 set max_day 80 set county "TR" set spots_total 564 set hi 0.000006]
  ask patch -1 -8 [set honey_type 1 set min_day 1 set max_day 15 set county "TR" set spots_total 102 set hi 0.0000175]
  ask patch -1 -9 [set honey_type 0 set min_day 1 set max_day 90 set county "TR"]
  
  ask patch 0 -7 [set honey_type 0 set min_day 1 set max_day 90 set county "GR"]
  ask patch 0 -8 [set honey_type 2 set min_day 31 set max_day 51 set county "GR" set spots_total 24 set hi 0.000018]
  ask patch 0 -9 [set honey_type 2 set min_day 31 set max_day 51 set county "GR" set spots_total 30 set hi 0.000018]
  ask patch 1 -7 [set honey_type 0 set min_day 1 set max_day 90 set county "GR"]
  ask patch 1 -8 [set honey_type 3 set min_day 45 set max_day 80 set county "GR" set spots_total 558 set hi 0.000006]
  ask patch 1 -9 [set honey_type 3 set min_day 45 set max_day 80 set county "GR" set spots_total 594 set hi 0.000006]
  
  ask patch 2 -7 [set honey_type 3 set min_day 45 set max_day 80 set county "IF" set spots_total 582 set hi 0.000006]
  ask patch 2 -8 [set honey_type 1 set min_day 1 set max_day 15 set county "IF" set spots_total 72 set hi 0.0000145]
  ask patch 2 -9 [set honey_type 3 set min_day 45 set max_day 80 set county "IF" set spots_total 552 set hi 0.000006]
  ask patch 3 -7 [set honey_type 0 set min_day 1 set max_day 90 set county "IF"]
  ask patch 3 -8 [set honey_type 2 set min_day 31 set max_day 51 set county "IF" set spots_total 36 set hi 0.000018]
  ask patch 3 -9 [set honey_type 2 set min_day 31 set max_day 51 set county "IF" set spots_total 30 set hi 0.000018]
  
  ask patch 4 -7 [set honey_type 3 set min_day 45 set max_day 80 set county "IL" set spots_total 582 set hi 0.000006]
  ask patch 4 -8 [set honey_type 0 set min_day 1 set max_day 90 set county "IL"]
  ask patch 4 -9 [set honey_type 3 set min_day 45 set max_day 80 set county "IL" set spots_total 576 set hi 0.000006]
  ask patch 5 -7 [set honey_type 1 set min_day 1 set max_day 15 set county "IL" set spots_total 150 set hi 0.0000145]
  ask patch 5 -8 [set honey_type 3 set min_day 45 set max_day 80 set county "IL" set spots_total 588 set hi 0.000006]
  ask patch 5 -9 [set honey_type 0 set min_day 1 set max_day 90 set county "IL"]
  
  ask patch 6 -7 [set honey_type 3 set min_day 45 set max_day 80 set county "CL" set spots_total 552 set hi 0.000008]
  ask patch 6 -8 [set honey_type 3 set min_day 45 set max_day 80 set county "CL" set spots_total 594 set hi 0.000008]
  ask patch 6 -9 [set honey_type 3 set min_day 45 set max_day 80 set county "CL" set spots_total 588] set hi 0.000008
  ask patch 7 -7 [set honey_type 0 set min_day 1 set max_day 90 set county "CL"]
  ask patch 7 -8 [set honey_type 0 set min_day 1 set max_day 90 set county "CL"]
  ask patch 7 -9 [set honey_type 3 set min_day 45 set max_day 80 set county "CL" set spots_total 594 set hi 0.000008]
  
  ask patch 8 -7 [set honey_type 1 set min_day 1 set max_day 15 set county "CT" set spots_total 174 set hi 0.0000145]
  ask patch 8 -8 [set honey_type 3 set min_day 45 set max_day 80 set county "CT" set spots_total 594 set hi 0.000008]
  ask patch 8 -9 [set honey_type 3 set min_day 45 set max_day 80 set county "CT" set spots_total 594 set hi 0.000008]
  ask patch 9 -7 [set honey_type 3 set min_day 45 set max_day 80 set county "CT" set spots_total 594 set hi 0.000008]
  ask patch 9 -8 [set honey_type 3 set min_day 45 set max_day 80 set county "CT" set spots_total 594 set hi 0.000008]
  ask patch 9 -9 [set honey_type 0 set min_day 1 set max_day 90 set county "CT"]
       if honey_type = 0[ set pcolor black ]
       if honey_type = 1[ set pcolor green ]
       if honey_type = 2[ set pcolor yellow ]
       if honey_type = 3[ set pcolor cyan ]
       ifelse county != 0 [set plabel county] [set plabel ""]
       set spots_occupied 0
       set hi_polyflower 0.000004
       ;;set plabel county
    ]
  ]
end

to setup_beekeepers_origin
  let i 0
  while [i < beekeepers *  80][
    ifelse (int (i / beekeepers) = 0) [
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy 2 -1]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy 2 -2]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy 2 -3]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy 3 -1]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy 3 -2]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy 3 -3]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) = 1) [
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy 0 -7]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy 0 -8]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy 0 -9]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy 1 -7]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy 1 -8]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy 1 -9]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) = 2) [
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy 0 -1]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy 0 -2]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy 0 -3]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy 1 -1]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy 1 -2]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy 1 -3]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) = 3) [
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy 4 -1]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy 4 -2]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy 4 -3]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy 5 -1]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy 5 -2]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy 5 -3]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) = 4) [
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy -4 8]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy -4 7]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy -4 6]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy -3 8]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy -3 7]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy -3 6]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) = 5) [
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy -4 2]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy -4 1]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy -4 0]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy -3 2]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy -3 1]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy -3 0]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) = 6) [
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy 0 2]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy 0 1]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy 0 0]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy 1 2]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy 1 1]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy 1 0]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) = 7) [
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy 4 -7]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy 4 -8]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy 4 -9]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy 5 -7]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy 5 -8]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy 5 -9]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) = 8) [
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy -6 5]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy -6 4]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy -6 3]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy -5 5]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy -5 4]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy -5 3]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) = 9) [
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy 0 5]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy 0 4]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy 0 3]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy 1 5]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy 1 4]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy 1 3]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) = 10) [
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy 8 -7]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy 8 -8]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy 8 -9]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy 9 -7]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy 9 -8]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy 9 -9]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) = 11) [
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy -6 -4]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy -6 -5]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy -6 -6]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy -5 -4]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy -5 -5]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy -5 -6]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) = 12) [
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy 7 -1]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy 7 -2]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy 7 -3]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy 6 -1]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy 6 -2]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy 6 -3]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) = 13) [
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy 6 -7]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy 6 -8]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy 6 -9]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy 7 -7]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy 7 -8]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy 7 -9]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) = 14) [
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy -1 -1]][;;sb
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy -1 -2]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy -1 -3]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy -2 -1]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy -2 -2]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy -2 -3]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 15 and int (i / beekeepers) <= 16) [;;br
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy 6 -4]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy 6 -5]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy 6 -6]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy 7 -4]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy 7 -5]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy 7 -6]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 17 and int (i / beekeepers) <= 18) [;;nt
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy 2 5]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy 2 4]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy 2 3]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy 3 5]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy 3 4]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy 3 3]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 19 and int (i / beekeepers) <= 20) [;;ot
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy -4 -7]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy -4 -8]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy -4 -9]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy -3 -7]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy -3 -8]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy -3 -9]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 21 and int (i / beekeepers) <= 22) [;;sv
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy 0 8]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy 0 7]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy 0 6]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy 1 8]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy 1 7]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy 1 6]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 23 and int (i / beekeepers) <= 24) [;;hd
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy -4 -1]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy -4 -2]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy -4 -3]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy -3 -1]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy -3 -2]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy -3 -3]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 25 and int (i / beekeepers) <= 26) [;;mh
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy -8 -7]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy -8 -8]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy -8 -9]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy -7 -7]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy -7 -8]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy -7 -9]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 27 and int (i / beekeepers) <= 28) [;;cj
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy -2 5]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy -2 4]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy -2 3]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy -1 5]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy -1 4]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy -1 3]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 29 and int (i / beekeepers) <= 30) [;;mm
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy -2 8]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy -2 7]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy -2 6]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy -1 8]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy -1 7]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy -1 6]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 31 and int (i / beekeepers) <= 32) [;;db
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy 0 -4]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy 0 -5]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy 0 -6]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy 1 -4]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy 1 -5]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy 1 -6]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 33 and int (i / beekeepers) <= 34) [;;tr
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy -2 -7]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy -2 -8]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy -2 -9]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy -1 -7]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy -1 -8]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy -1 -9]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 35 and int (i / beekeepers) <= 36) [;;sj
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy -4 5]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy -4 4]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy -4 3]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy -3 5]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy -3 4]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy -3 3]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 37 and int (i / beekeepers) <= 38) [;;vs
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy 4 2]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy 4 1]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy 4 0]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy 5 2]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy 5 1]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy 5 0]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 39 and int (i / beekeepers) <= 40) [;;dj
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy -6 -7]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy -6 -8]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy -6 -9]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy -5 -7]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy -5 -8]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy -5 -9]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 41 and int (i / beekeepers) <= 42) [;;bt
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy 1 8]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy 1 7]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy 1 6]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy 2 8]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy 2 7]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy 2 6]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 43 and int (i / beekeepers) <= 44) [;;ph
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy 2 -4]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy 2 -5]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy 2 -6]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy 3 -4]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy 3 -5]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy 3 -6]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 45 and int (i / beekeepers) <= 46) [;;cs
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy -8 -4]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy -8 -5]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy -8 -6]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy -7 -4]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy -7 -5]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy -7 -6]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 47 and int (i / beekeepers) <= 48) [;;tl
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy 8 -4]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy 8 -5]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy 8 -6]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy 9 -4]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy 9 -5]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy 9 -6]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 49 and int (i / beekeepers) <= 51) [;;ms
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy -2 2]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy -2 1]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy -2 0]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy -1 2]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy -1 1]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy -1 0]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 52 and int (i / beekeepers) <= 54) [;;tm
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy -6 -1]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy -6 -2]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy -6 -3]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy -5 -1]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy -5 -2]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy -5 -3]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 55 and int (i / beekeepers) <= 57) [;;is
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy 4 5]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy 4 4]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy 4 3]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy 5 5]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy 5 4]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy 5 3]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 58 and int (i / beekeepers) <= 60) [;;bz
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy 4 -4]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy 4 -5]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy 4 -6]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy 5 -4]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy 5 -5]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy 5 -6]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 61 and int (i / beekeepers) <= 63) [;;ar
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy -6 2]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy -6 1]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy -6 0]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy -5 2]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy -5 1]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy -5 0]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 64 and int (i / beekeepers) <= 67) [;;if
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy 2 -7]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy 2 -8]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy 2 -9]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy 3 -7]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy 3 -8]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy 3 -9]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 68 and int (i / beekeepers) <= 71) [;;bc
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy 2 2]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy 2 1]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy 2 0]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy 3 2]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy 3 1]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy 3 0]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 72 and int (i / beekeepers) <= 75) [;;AG
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy -2 -4]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy -2 -5]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy -2 -6]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy -1 -4]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy -1 -5]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy -1 -6]][
      ]]]]]]
    ]
    [
    ifelse (int (i / beekeepers) >= 76 and int (i / beekeepers) <= 79) [;;vl
      ifelse (i mod beekeepers mod 6 = 0) [ask turtle i [setxy -4 -4]][
      ifelse (i mod beekeepers mod 6 = 1) [ask turtle i [setxy -4 -5]][
      ifelse (i mod beekeepers mod 6 = 2) [ask turtle i [setxy -4 -6]][
      ifelse (i mod beekeepers mod 6 = 3) [ask turtle i [setxy -3 -4]][
      ifelse (i mod beekeepers mod 6 = 4) [ask turtle i [setxy -3 -5]][
      ifelse (i mod beekeepers mod 6 = 5) [ask turtle i [setxy -3 -6]][
      ]]]]]]
    ]
    []
    ]
    ]
    ]
    ]
    ]
    ]
    ]
    ]
    ]
    ]
    ]
    ]
    ]
    ]
    ]
    ]    
    ]
    ]
    ]
    ]
    ]
    ]    
    ]
    ]
    ]
    ]
    ]    
    ]
    ]
    ]
    ]
    ]
    ]
    ]
    ]
    ]
    ]
    ]
    ]]
    set i (i + 1)
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
429
15
817
424
10
10
18.0
1
10
1
1
1
0
1
1
1
-10
10
-10
10
1
1
1
Days
30.0

BUTTON
0
41
120
74
Go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

BUTTON
-1
80
121
113
Setup
setup
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
135
41
247
86
Bees
total_bees
17
1
11

MONITOR
255
42
373
87
Total honey
total_honey
17
1
11

PLOT
2
211
378
361
Honey
days
amount
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"polyflower" 1.0 0 -16777216 true "" "plot total_honey_polyflower"
"total" 1.0 0 -7500403 true "" "plot total_honey"
"accacia" 1.0 0 -10899396 true "" "plot total_honey_accacia"
"sunflower" 1.0 0 -11221820 true "" "plot total_honey_sunflower"
"lime" 1.0 0 -1184463 true "" "plot total_honey_lime"

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
NetLogo 5.0.4
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 1.0 0.0
0.0 1 1.0 0.0
0.2 0 1.0 0.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
