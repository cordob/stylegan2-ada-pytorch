colab  disconnect   방해 명령. : 콘솔창  띄우고.  

먼저
function ClickConnect(){
console.log("Working"); 
document.querySelector("colab-toolbar-button").click() 
}setInterval(ClickConnect, 1800000)

그리고 
function HidePopUp() { let style = ``; document.head.insertAdjacentHTML("beforeend", style); } HidePopUp();



정사각형 이미지로 전처리

for i in *.*; do
convert  $i -set option:size '%[fx:min(w,h)]x%[fx:min(w,h)]' xc:none +swap -gravity center -composite -resize 1024x1024 $i 
done


train : 12g 이상 

pre.

python dataset_tool.py --source=m3 --dest=m3.zip  --width=256 --height=256

python dataset_tool.py --source=m3 --dest=m3.zip  --width=512 --height=512

# Original 1024x1024 resolution.

python dataset_tool.py --source=m3 --dest=m3.zip


              

Transfer learning  train !!!!!  512x512.    (최소 2시간 이상).  --snap 2.  save interval 

1

python train.py --outdir=training_runs --data=m3.zip --resume=https://nvlabs-fi-cdn.nvidia.com/stylegan2-ada/pretrained/afhqwild.pkl  --gpus=1 --mirror=1 --snap 2

pretained  :  https://github.com/cordob/awesome-pretrained-stylegan2

2

python train.py --outdir=training_runs --data=m3.zip --snap 2 --resume=https://nvlabs-fi-cdn.nvidia.com/stylegan2-ada-pytorch/pretrained/transfer-learning-source-nets/ffhq-res512-mirror-stylegan2-noaug.pkl --gpus=1 --mirror=1


2A  GTX1080TI gpu ram 11g. :  --batch 2 추가 

python train.py --outdir=training_runs --data=m3.zip  --batch 2 --snap 2 --resume=https://nvlabs-fi-cdn.nvidia.com/stylegan2-ada-pytorch/pretrained/transfer-learning-source-nets/ffhq-res512-mirror-stylegan2-noaug.pkl --gpus=1 --mirror=1


3  1024 resolution  Transfer learning 

python train.py --outdir=training_runs --data=data.zip --snap 2 --resume=ffhq1024 --gpus=1 --mirror=1



3 중단후 다시 재개

!python train.py --outdir=training_runs --snap 2 --data='/content/drive/My Drive/m3.zip' --resume=training_runs/00000-m3-mirror-auto1-resumecustom/network-snapshot-000000.pkl --gpus=1 --mirror=1


4 pkl file download 

from google.colab import files
files.download('training_runs/00000-m3-mirror-auto1-resumecustom/network-snapshot-000000.pkl')


5. image generate 

이미지 생성 (Using custom trained network)

python generate.py --outdir=out --trunc=0.7 --seeds=6100-6135 --network=training_runs/00001-m3-auto1/network-snapshot-000000.pkl

!sudo apt install imagemagick-6.q16

!montage -mode concatenate -tile 4x4 out/*.png out/result.jpg

from google.colab import files
from IPython import display
display.Image("out/result-0.jpg",
              width=1600)





이미지 생성

python generate.py --outdir=out --trunc=0.7 --seeds=6100-6135 --network=https://nvlabs-fi-cdn.nvidia.com/stylegan2-ada-pytorch/pretrained/ffhq.pkl 


이미지 믹싱 !!!!!   (모핑에 응용)

python style_mixing.py --outdir=out --rows=1500,1501 --cols=333,334 \
    --network=ffhq.pkl


타겟 이미지 모핑  !!!

python projector.py --seed 100 --outdir=out2 --target=j.png --network=ffhq.pkl 



 비디오 생성 (--network_pkl 모델지정)
 
 python render.py --mp4_fps 30 --filename test --duration_sec 5 --network_pkl  ffhq.pkl





pretained  :  https://github.com/cordob/awesome-pretrained-stylegan2
