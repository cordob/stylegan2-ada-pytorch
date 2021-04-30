train : 12g 이상 

pre.

python dataset_tool.py --source=m3 --dest=m3.zip  --width=256 --height=256

python dataset_tool.py --source=m3 --dest=m3.zip  --width=512 --height=512

train

python train.py --outdir=training_runs --data=land.zip --gpus=1


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
