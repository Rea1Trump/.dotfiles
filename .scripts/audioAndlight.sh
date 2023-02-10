vol=$(mixer vol | cut -d ":" -f 2)
light=$(backlight -q)

echo " | vol:$vol | light:$light"

