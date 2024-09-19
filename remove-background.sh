Video to frames
ffmpeg -i hirono.mp4 -vf "fps=5" '%04d.png' 

https://github.com/nadermx/backgroundremover

for i in *.jpg;
  do name=`echo "$i" | cut -d'.' -f1`
  echo "$name"
  backgroundremover -i "$i" -o "../png/${name}.png"
done

for i in *.png;
  do name=`echo "$i" | cut -d'.' -f1`
  echo "$name"
  convert "$i" -background white -flatten -alpha off "../jpg/${name}.jpg"
done


# batch processing batch N
task(){
  name=`echo "$1" | cut -d'.' -f1`
  echo "$1"
  backgroundremover -i "$1" -o "../png/${name}.png"
}

N=4
(
for i in *.png; do
   ((count=count%N)); ((count++==0)) && wait
   task "$i" & 
done
)

